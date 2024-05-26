local dmacro_key = '<C-T>'
vim.g.keyhist = ''

local function guess_macro()
	local keyhist = vim.g.keyhist
	for i = math.ceil(#keyhist / 2) + 1, #keyhist do
		for j = 1, 2 * i - #keyhist do
			local curspan = keyhist:sub(i, #keyhist)
			local cmpspan = keyhist:sub(j, j + #curspan - 1)
			if curspan == cmpspan then
				local curmacro = keyhist:sub(j + #curspan, i - 1)
				vim.g.prev_macro = curspan .. curmacro
				return curmacro
			end
		end
	end
end

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
