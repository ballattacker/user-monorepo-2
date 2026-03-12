local M = {}

function M.entry()
	local _permit = ya.hide()
	local cwd, selected, files = state()

	local output, err = M.run_with(cwd, #selected > 0 and selected or files)
	if not output then
		return ya.notify { title = "Fzf", content = tostring(err), timeout = 5, level = "error" }
	end

	local urls = M.split_urls(cwd, output)
	if #urls == 1 then
		local cha = #selected == 0 and fs.cha(urls[1])
		ya.emit(cha and cha.is_dir and "cd" or "reveal", { urls[1] })
	elseif #urls > 1 then
		urls.state = #selected > 0 and "off" or "on"
		ya.emit("toggle_all", urls)
	end
end

function M.run_with(cwd, selected)
	local child, err = Command("fzf")
			-- NOTE: custom changes added here
			:env("FZF_DEFAULT_OPTS", table.concat({
				"-m",
				"--height=100%",
				"--layout=reverse",
				[[--preview='preview.sh {}']]
			}, " "))
			:cwd(tostring(cwd))
			:stdin(#selected > 0 and Command.PIPED or Command.INHERIT)
			:stdout(Command.PIPED)
			:spawn()

	if not child then
		return nil, Err("Failed to start `fzf`, error: %s", err)
	end

	for _, u in ipairs(selected) do
		child:write_all(string.format("%s\n", u))
	end
	if #selected > 0 then
		child:flush()
	end

	local output, err = child:wait_with_output()
	if not output then
		return nil, Err("Cannot read `fzf` output, error: %s", err)
	elseif not output.status.success and output.status.code ~= 130 then
		return nil, Err("`fzf` exited with error code %s", output.status.code)
	end
	return output.stdout, nil
end

function M.split_urls(cwd, output)
	local t = {}
	for line in output:gmatch("[^\r\n]+") do
		local u = Url(line)
		if u.is_absolute then
			t[#t + 1] = u
		else
			t[#t + 1] = cwd:join(u)
		end
	end
	return t
end

return M
