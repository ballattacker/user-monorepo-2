require("session"):setup({
	sync_yanked = true,
})

require("zoxide"):setup({
	update_db = true,
})

require("git"):setup({
	-- Order of status signs showing in the linemode
	order = 1500,
})

require("starship"):setup({
	show_right_prompt = true,
})
