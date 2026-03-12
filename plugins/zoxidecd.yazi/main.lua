-- https://github.com/sxyazi/yazi/blob/v25.5.31/yazi-plugin/preset/plugins/zoxide.lua

local state = ya.sync(function(st)
	return {
		cwd = tostring(cx.active.current.cwd),
		empty = st.empty,
	}
end)

local set_state = ya.sync(function(st, empty) st.empty = empty end)

local function fail(s, ...) ya.notify { title = "Zoxide", content = s:format(...), timeout = 5, level = "error" } end

local function options()
	-- https://github.com/ajeetdsouza/zoxide/blob/main/src/cmd/query.rs#L92
	local default = {
		-- NOTE: custom changes added here
		"--tiebreak=end",
		"--cycle",
		"--keep-right",
		"--layout=reverse",
		"--height=100%",
		"--scrollbar=▌",
		"--exit-0",
		[[--preview='preview.sh {2..}']]
	}

	return (os.getenv("FZF_DEFAULT_OPTS") or "")
			.. " "
			.. table.concat(default, " ")
			.. " "
			.. (os.getenv("YAZI_ZOXIDE_OPTS") or "")
end

local function empty(cwd)
	local child = Command("zoxide"):arg({ "query", "-l", "--exclude", cwd }):stdout(Command.PIPED):spawn()
	if not child then
		return true
	end

	local first = child:read_line()
	child:start_kill()
	return not first
end

local function setup(_, opts)
	opts = opts or {}

	if opts.update_db then
		ps.sub(
			"cd",
			function()
				ya.emit("shell", {
					cwd = fs.cwd(),
					orphan = true,
					"zoxide add " .. ya.quote(tostring(cx.active.current.cwd)),
				})
			end
		)
	end
end

local function entry()
	local st = state()
	if st.empty == nil then
		st.empty = empty(st.cwd)
		set_state(st.empty)
	end

	if st.empty then
		return fail("No directory history found, check Zoxide's doc to set it up and restart Yazi.")
	end

	local _permit = ui.hide()
	local child, err1 = Command("zoxide")
			:arg({ "query", "-i", "--exclude", st.cwd })
			:env("SHELL", "sh")
			:env("CLICOLOR", 1)
			:env("CLICOLOR_FORCE", 1)
			:env("_ZO_FZF_OPTS", options())
			:stdin(Command.INHERIT)
			:stdout(Command.PIPED)
			:stderr(Command.PIPED)
			:spawn()

	if not child then
		return fail("Failed to start `zoxide`, error: " .. err1)
	end

	local output, err2 = child:wait_with_output()
	if not output then
		return fail("Cannot read `zoxide` output, error: " .. err2)
	elseif not output.status.success and output.status.code ~= 130 then
		return fail("`zoxide` exited with code %s: %s", output.status.code, output.stderr:gsub("^zoxide:%s*", ""))
	end

	local target = output.stdout:gsub("\n$", "")
	if target ~= "" then
		ya.emit("cd", { target })
	end
end

return { setup = setup, entry = entry }
