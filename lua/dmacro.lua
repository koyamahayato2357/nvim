local dmacro_key = '<C-T>'
local clear_key = '<C-S-T>'
vim.g.key_log = ''

---@param key_log string
---@return string
local function guess_macro(key_log)
	for i = #key_log / 2, #key_log do
		local curspan = key_log:sub(i)
		local srchspan = key_log:sub(1, i - 1)
		local start, fin = srchspan:find(curspan, 1, true)
		if start and fin then
			vim.g.prev_macro = srchspan:sub(start)
			return srchspan:sub(fin + 1)
		end
	end
	return ''
end

---@param typed string
local function key_logger(_, typed)
	local readable_keycode = vim.fn.keytrans(typed)
	if readable_keycode == dmacro_key then
		return
	end

	vim.g.key_log = vim.g.key_log .. readable_keycode
	if #vim.g.key_log > 100 then
		vim.g.key_log = vim.g.key_log:sub(#vim.g.key_log - 100)
	end
	vim.g.prev_macro = nil
end

vim.on_key(key_logger)
vim.keymap.set({ 'i', 'n', 'v', 'o', 'c', 't' }, dmacro_key, function()
	vim.api.nvim_input(vim.g.prev_macro or guess_macro(vim.g.key_log))
end)
vim.keymap.set({ 'i', 'n', 'v', 'o', 'c', 't' }, clear_key, function()
	vim.g.key_log = ''
end)
