local dmacro_key = '<C-t>'
local macro = ''
vim.b.keyhist = ''

local function guess_macro1()
	local keyhist = vim.b.keyhist
	for i = #keyhist, 1, -1 do
		for j = #keyhist - i, i + 1, -1 do
			local curspan = keyhist:byte(i, #keyhist)
			local cmpspan = keyhist:byte(j - i, j)
			if curspan == cmpspan then
				return keyhist:sub(j, i)
			end
		end
	end
	return ''
end

local function guess_macro2()
	local keyhist = vim.b.keyhist
	for i = #keyhist, math.floor(#keyhist / 2), -1 do
		local curspan = keyhist:byte(i, #keyhist)
		local cmpspan = keyhist:byte(2 * i - #keyhist, i + 1)
		if curspan == cmpspan then
			return keyhist:sub(i, #keyhist)
		end
	end
	return ''
end

local function record_macro(_, typed)
	if typed:upper() ~= dmacro_key:upper() then
		vim.b.keyhist = vim.b.keyhist .. typed
		macro = ''
	end
end

local function play_macro()
	if macro == '' then
		macro = guess_macro1()
		if macro == '' then
			macro = guess_macro2()
		end
	end
	if macro ~= '' then vim.fn.feedkeys(macro) end
end

vim.on_key(record_macro)
vim.keymap.set({ 'i', 'n' }, dmacro_key, play_macro)
