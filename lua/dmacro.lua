local dmacro_key = '<C-T>'
local clear_key = '<C-S-T>'
local key_log = ''
local prev_macro = nil

---@param kl string
---@return string
local function guess_macro(kl)
	for i = #kl / 2, #kl do
		local curspan = kl:sub(i)
		local srchspan = kl:sub(1, i - 1)
		local start, fin = srchspan:find(curspan, 1, true)
		if start and fin then
			prev_macro = srchspan:sub(start)
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

	key_log = key_log .. readable_keycode
	if #key_log > 100 then
		key_log = key_log:sub(#key_log - 100)
	end
	prev_macro = nil
end

vim.on_key(key_logger)
vim.keymap.set({ 'i', 'n', 'v', 'o', 'c', 't' }, dmacro_key, function()
	vim.api.nvim_input(prev_macro or guess_macro(key_log))
end)
vim.keymap.set({ 'i', 'n', 'v', 'o', 'c', 't' }, clear_key, function()
	key_log = ''
end)
