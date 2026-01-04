return {
	"rafamadriz/friendly-snippets",
	ft = { "html", "markdown" },
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
