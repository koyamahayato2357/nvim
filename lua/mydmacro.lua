local dmacro_key = '<C-T>'
vim.b.keyhist = ''

local function guess_macro()
	local keyhist = vim.b.keyhist
	for i = math.ceil(#keyhist / 2) + 1, #keyhist do
		for j = 1, 2 * i - #keyhist do
			local curspan = keyhist:sub(i, #keyhist)
			local cmpspan = keyhist:sub(j, j + #keyhist - i)
			if curspan == cmpspan then
				local curmacro = keyhist:sub(j + #keyhist - i + 1, i - 1)
				vim.b.prev_macro = curspan .. curmacro
				return curmacro
			end
		end
	end
end

local function record_macro(_, typed)
	if typed ~= nil and typed ~= '' and vim.fn.keytrans(typed) ~= dmacro_key then
		local mod = vim.fn.mode()
		if mod ~= 'c' and not (mod == 'n' and typed == ':') then
			vim.b.keyhist = vim.b.keyhist .. typed
			vim.b.prev_macro = ''
			if #vim.b.keyhist > 100 then
				vim.b.keyhist = vim.b.keyhist:sub(-100)
			end
		end
	end
end

local function play_macro()
	if vim.b.prev_macro == '' then
		local curmacro = guess_macro()
		vim.fn.feedkeys(curmacro)
		vim.b.keyhist = vim.b.keyhist .. curmacro
	else
		vim.fn.feedkeys(vim.b.prev_macro)
	end
end

vim.on_key(record_macro)
vim.keymap.set({ 'i', 'n' }, dmacro_key, play_macro)
