return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false }, { mode = "n" })
			end,
		}, -- this will register the leader key for normal and visual modes e
		description = "Show which-key help",
	},
}
