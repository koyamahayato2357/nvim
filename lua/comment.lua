local comments = {
	["bash"] = "# ",
	["lua"] = "-- ",
	["c"] = "// ",
	["cpp"] = "// ",
	["rust"] = "// ",
	["tex"] = "% ",
	["arduino"] = "// ",
}


function toggle_comment()
	local filetype = vim.bo.filetype
	local current_line = vim.api.nvim_get_current_line()
	local prefix = comments[filetype]
	local first_non_blank_char = string.find(current_line, "%S") or 1
	if current_line:sub(first_non_blank_char, first_non_blank_char + #prefix - 1) == prefix then
		vim.api.nvim_set_current_line(current_line:sub(1, first_non_blank_char - 1) .. current_line:sub(first_non_blank_char + #prefix))
	else
		vim.api.nvim_command('normal I' .. prefix)
	end
end

vim.keymap.set("n", "gm", function() toggle_comment() end)
