local rainbow = {
	"#ff0000",
	"#ff7f00",
	"#ffff00",
	"#00ff00",
	"#00ffff",
	"#0000ff",
	"#800080"
}
local current_color_id = 1

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
	callback = function()
		current_color_id = current_color_id % 7 + 1
		vim.api.nvim_set_hl(0, "Cursor", { bg = rainbow[current_color_id] })
	end
})
