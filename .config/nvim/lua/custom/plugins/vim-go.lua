return {
	"fatih/vim-go",
	build = ":GoUpdateBinaries",
	ft = { "go", "gomod" },

	config = function()
		vim.g.go_doc_popup_window = 1
	end,
}
