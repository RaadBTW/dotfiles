return {
	"diepm/vim-rest-console",
	config = function()
		vim.g.vrc_get_default_mapping = 0
		vim.g.vrc_output_buffer_name = "_OUTPUT.json"
		vim.g.vrc_response_default_content_type = "application/json"
		vim.g.vrc_auto_format_resposne_patterns = { json = "jq" }
	end,
}
