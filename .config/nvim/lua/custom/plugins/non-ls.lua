return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.gofmt, -- Go formatter
				-- You can add other null-ls sources here if needed
			},
			on_attach = function(client, bufnr)
				-- Format on save for all attached clients that support it
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = "LspFormatting", buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})

		-- Now setup Lua language server (sumneko_lua) for Lua LSP features
		local lspconfig = require("lspconfig")

		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT", -- Neovim uses LuaJIT
						path = vim.split(package.path, ";"),
					},
					diagnostics = {
						globals = { "vim" }, -- recognize 'vim' global
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
}
