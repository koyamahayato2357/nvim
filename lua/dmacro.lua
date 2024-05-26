local dmacro_key = '<C-T>'
vim.g.keyhist = ''

---@return string
local function guess_macro()
	local keyhist = vim.g.keyhist
	for i = math.ceil(#keyhist / 2) + 1, #keyhist do
		local curspan = keyhist:sub(i)
		local srchspan = keyhist:sub(1, i - 1)
		local start, fin = srchspan:find(curspan, 1, true)
		if start and fin then
			vim.g.prev_macro = srchspan:sub(start)
			return srchspan:sub(fin + 1)
		end
	end
end

---@param typed string
local function record_macro(_, typed)
	if typed and typed ~= '' and vim.fn.keytrans(typed) ~= dmacro_key then
		vim.g.keyhist = vim.g.keyhist .. typed
		vim.g.prev_macro = nil
	end
end

vim.on_key(record_macro)
vim.keymap.set({ 'i', 'n', 'v', 'o', 'c', 't' }, dmacro_key, function()
	vim.fn.feedkeys(vim.g.prev_macro or guess_macro())
end)
