return {
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		vim.cmd([[colorscheme carbonfox]])
	-- 	end,
	-- },
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		vim.cmd([[colorscheme tokyonight-moon]])
	-- 	end,
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("catppuccin")
	-- 	end,
	-- },
	--
	{
		"rose-pine/neovim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	-- {
	-- 	"nyoom-engineering/oxocarbon.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("oxocarbon")
	-- 	end,
	-- },
}
