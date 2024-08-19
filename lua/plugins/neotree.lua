return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		--		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left toggle<CR>", {})

		require("neo-tree").setup({
			close_if_last_window = false,
			enable_git_status = true,
			enable_diagnostics = true,
			default_component_configs = {
				container = {
					enable_character_fade = true,
				},
				indent = {
					with_markers = true,
					indent_marker = "¦",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
					with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "■",
					-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
					-- then these will never be used.
					default = "*",
					highlight = "NeoTreeFileIcon",
				},
				modified = {
					symbol = "[+]",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
			},
			window = {
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
					["o"] = { "open", nowait = true },
				},
			},
			default_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added = "✚",
						deleted = "✖",
						modified = "",
						renamed = "󰁕",
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
			},
		})
	end,
}
