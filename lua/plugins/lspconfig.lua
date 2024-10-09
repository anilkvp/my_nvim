return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local nvim_lsp = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")

		local protocol = require("vim.lsp.protocol")

		local on_attach = function(client, bufnr)
			-- format on save
			if client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("Format", { clear = true }),
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format()
					end,
				})
			end
		end

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		mason_lspconfig.setup_handlers({
			function(server)
				nvim_lsp[server].setup({
					capabilities = capabilities,
				})
			end,
			["ts_ls"] = function()
				nvim_lsp["ts_ls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["html"] = function()
				nvim_lsp["html"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["pyright"] = function()
				nvim_lsp["pyright"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["rust_analyzer"] = function()
				nvim_lsp["rust_analyzer"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["jdtls"] = function()
				nvim_lsp["jdtls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["helm_ls"] = function()
				nvim_lsp["helm_ls"].setup({
					settings = {
						["helm-ls"] = {
							yamlls = {
								path = "yaml-language-server",
							},
						},
					},
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["dockerls"] = function()
				nvim_lsp["dockerls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["zls"] = function()
				nvim_lsp["zls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
		})
	end,
}
