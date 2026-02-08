-- https://github.com/smoka7/hop.nvim/issues/59#issuecomment-2361869106
local M = {}
M.opts = {}

local function parse()
  local ok, parser = pcall(vim.treesitter.get_parser)
  if ok then
    parser:parse(true)
    return parser
  end
end

local function for_each_named_child_node(node, fn)
  fn(node)
  for i = 0, node:named_child_count() - 1, 1 do
    for_each_named_child_node(node:named_child(i), fn)
  end
end

local function named_nodes()
  local root_parser = parse()
  if root_parser then
    local nodes = {}
    root_parser:for_each_tree(function(tree, _parser)
      for_each_named_child_node(tree:root(), function(node)
        table.insert(nodes, node)
      end)
    end)
    return nodes
  end
end

local function text_objects()
  local root_parser = parse()
  if root_parser then
    local objects = {}
    root_parser:for_each_tree(function(tree, parser)
      local query = vim.treesitter.query.get(parser:lang(), "textobjects")
      if query then
        for _, match, _metadata in query:iter_matches(tree:root(), 0, nil, nil, { all = true }) do
          for id, nodes in pairs(match) do
            table.insert(objects, {
              capture = query.captures[id],
              nodes = nodes,
            })
          end
        end
      end
    end)
    return objects
  end
end

local function jump_target_from_node(node, seen)
  local row, col = node:range()
  row = row + 1

  local seen_key = row .. ":" .. col
  if not seen[seen_key] then
    seen[seen_key] = true

    return {
      window = 0,
      buffer = 0,
      cursor = {
        row = row,
        col = col,
      },
      length = 0,
    }
  end
end

-- NOTE: remove the jump targets that are x characters before
-- another jump target on the same line
-- prefer targets that are further to the right
local function sparse_jump_targets(jump_targets)
  local min_x_distance = 3
  local sparse_targets = {}
  local targets_by_line = {}

  for _, target in ipairs(jump_targets) do
    local line = target.cursor.row
    if not targets_by_line[line] then
      targets_by_line[line] = {}
    end
    table.insert(targets_by_line[line], target)
  end

  for _, targets in pairs(targets_by_line) do
    table.sort(targets, function(a, b)
      return a.cursor.col > b.cursor.col
    end)

    local last_col = math.huge
    for _, target in ipairs(targets) do
      if target.cursor.col < last_col - min_x_distance then
        table.insert(sparse_targets, target)
        last_col = target.cursor.col
      end
    end
  end

  return sparse_targets
end

local function named_nodes_locations(types)
  local jump_targets = {}
  local seen = {}

  for _, node in ipairs(named_nodes() or {}) do
    if not types or vim.tbl_contains(types, node:type()) then
      local jump_target = jump_target_from_node(node, seen)
      if jump_target then
        table.insert(jump_targets, jump_target)
      end
    end
  end

  jump_targets = sparse_jump_targets(jump_targets)

  return { jump_targets = jump_targets }
end

local function text_objects_locations(captures)
  local jump_targets = {}
  local seen = {}

  for _, object in ipairs(text_objects() or {}) do
    if not captures or vim.tbl_contains(captures, object.capture) then
      for _, node in ipairs(object.nodes) do
        local jump_target = jump_target_from_node(node, seen)
        if jump_target then
          table.insert(jump_targets, jump_target)
        end
      end
    end
  end

  return { jump_targets = jump_targets }
end

local function sort_indirect_jump_targets(locations, opts)
  local indirect_jump_targets = {}
  local c_row, c_col = unpack(vim.api.nvim_win_get_cursor(0))
  local cursor = { row = c_row, col = c_col }
  for i, jump_target in ipairs(locations.jump_targets) do
    table.insert(indirect_jump_targets, {
      index = i,
      score = opts.distance_method(cursor, jump_target.cursor, opts.x_bias),
    })
  end
  require("hop.jump_target").sort_indirect_jump_targets(indirect_jump_targets, opts)

  locations.indirect_jump_targets = indirect_jump_targets
end

function M.named_nodes(types, opts)
  opts = setmetatable(opts or {}, { __index = M.opts })
  require("hop").hint_with(function()
    local locations = named_nodes_locations(types)
    sort_indirect_jump_targets(locations, opts)
    return locations
  end, opts)
end

function M.text_objects(captures, opts)
  opts = setmetatable(opts or {}, { __index = M.opts })
  require("hop").hint_with(function()
    local locations = text_objects_locations(captures)
    sort_indirect_jump_targets(locations, opts)
    return locations
  end, opts)
end

function M.register(opts)
  M.opts = opts

  vim.api.nvim_create_user_command("HopNodesNamed", function(info)
    M.named_nodes(#info.fargs > 0 and info.fargs)
  end, {
    nargs = "*",
  })

  vim.api.nvim_create_user_command("HopTextObjects", function(info)
    M.text_objects(#info.fargs > 0 and info.fargs)
  end, {
    nargs = "*",
  })
end

return M
