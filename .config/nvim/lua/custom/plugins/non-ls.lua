return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.htmlbeautifier,
				null_ls.builtins.diagnostics.htmlhint,
			},

			-- Format on save
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					local group = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
					vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = group,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})

		-- Lua LSP
		vim.lsp.config.lua_ls = {
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
		}
	end,
}
