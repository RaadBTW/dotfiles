return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		keywords = {
			RED = {
				color = "#FF0000",
			},
			WHITE = {
				color = "#FFFFFF",
			},
			BLUE = {
				color = "#0000FF",
			},
			YELLOW = {
				color = "#FFFF00",
			},
			LIME = {
				color = "#00FF00",
			},
			AQUA = {
				color = "#00FFFF",
			},
		},
		merge_keywords = true,
	},
}
