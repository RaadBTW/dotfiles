return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.config")
			configs.setup({
				highlight = {
					enable = true,
				},
				indent = { enable = true },
				ensure_installed = {
					"bash",
					"c",
					"diff",
					"html",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"query",
					"vim",
					"vimdoc",
					"go",
				},
				auto_install = true,
				vim.api.nvim_create_autocmd("FileType", {
					pattern = { "go", "templ" },
					callback = function()
						vim.treesitter.start(0, vim.bo.filetype)
					end,
				}),
			})
		end,
	},
}
