return {
	"folke/twilight.nvim",
	opts = {
		dimming = { alpha = 0.25 }, -- 25% gray (adjust 0-1)
		context = 10, -- Lines around cursor
		treesitter = true, -- Syntax-aware
	},
	keys = {
		{ "<leader>tw", ":Twilight<CR>", desc = "Toggle Twilight" },
	},
}
