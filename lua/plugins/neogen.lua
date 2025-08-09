return {
	"danymat/neogen",
	config = true,
	-- Uncomment next line if you want to follow only stable versions
	version = "*",
	opts = {
		snippet_engine = "luasnip",
	},
	keys = {
		{ "<leader>nf", "<cmd>lua require('neogen').generate()<CR>", desc = "Generate Neogen function annotation" },
		{
			"<leader>nc",
			"<cmd>lua require('neogen').generate({ type = 'class'} )<CR>",
			desc = "Generate Neogen class annotation",
		},
	},
}
