return {
	-- Mason: LSP/DAP/linter/formatter installer
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				-- LSP servers
				"lua-language-server",
				--	"typescript-language-server",
				"pyright",
				"rust-analyzer",
				-- "gopls",
				"clangd",
				-- "tailwindcss-language-server",
				"html-lsp",
				-- "css-lsp",
				"json-lsp",
				-- Formatters
				"stylua",
				"prettier",
				"black",
				"isort",
				-- Linters
				"eslint_d",
				-- "flake8",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},

	-- Mason LSP Config Bridge
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
		opts = {
			automatic_installation = true,
		},
	},
}
