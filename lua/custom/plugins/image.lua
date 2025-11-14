return {
	"3rd/image.nvim",
	build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
	opts = {
		processor = "magick_cli",
		integrations = {
			markdown = {
				only_render_image_at_cursor = true,
				resolve_image_path = function(document_path, image_path, fallback)
					local obsidian_client = require("obsidian").get_client()
					local new_image_path = obsidian_client:vault_relative_path(image_path).filename
					if vim.fn.filereadable(new_image_path) == 1 then
						return new_image_path
					else
						return fallback(document_path, image_path)
					end
				end,
			}
		},
		window_overlap_clear_enabled = true,
		tmux_show_only_in_active_window = true,
	}
}
