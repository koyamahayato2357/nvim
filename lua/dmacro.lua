local dmacro_key = '<C-T>'
vim.g.keyhist = ''

local function guess_macro()
	local keyhist = vim.g.keyhist
	for i = math.ceil(#keyhist / 2) + 1, #keyhist do
		for j = 1, 2 * i - #keyhist do
			local curspan = keyhist:sub(i, #keyhist)
			local cmpspan = keyhist:sub(j, j + #keyhist - i)
			if curspan == cmpspan then
				local curmacro = keyhist:sub(j + #keyhist - i + 1, i - 1)
				vim.g.prev_macro = curspan .. curmacro
				return curmacro
			end
		end
	end
end

local function record_macro(_, typed)
	if typed == nil or typed == '' or vim.fn.keytrans(typed) == dmacro_key then
		return
	end
	local mod = vim.fn.mode()
	if mod == 'n' and typed == ':' or mod == 'c' then
		return
	end
	vim.g.keyhist = vim.g.keyhist .. typed
	vim.g.prev_macro = ''
	if #vim.g.keyhist > 100 then
		vim.g.keyhist = vim.g.keyhist:sub(-100)
	end
end

local function play_macro()
	if vim.g.prev_macro == '' then
		local curmacro = guess_macro()
		vim.fn.feedkeys(curmacro)
		vim.g.keyhist = vim.g.keyhist .. curmacro
	else
		vim.fn.feedkeys(vim.g.prev_macro)
	end
end

vim.on_key(record_macro)
vim.keymap.set({ 'i', 'n' }, dmacro_key, play_macro)
