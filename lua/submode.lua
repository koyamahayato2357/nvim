M = {}

---@class KeyMapInfo
---@field key string
---@field callback fun(): nil|string
---@field opts table?

---@param mode string|table
---@param leader string
---@param keymaps KeyMapInfo[]
---@param on_enter fun(): nil?
function M.set_submode_keymap(mode, leader, keymaps, on_enter)
	local stash = {}

	table.insert(keymaps, {
		key = '<Esc>',
		-- pop prev keymaps
		callback = function()
			for _, keymap in ipairs(keymaps) do
				if vim.tbl_isempty(stash[keymap.key]) then
					vim.keymap.del(mode, keymap.key)
				else
					vim.fn.mapset(stash[keymap.key])
				end
			end
		end
	})

	vim.keymap.set(mode, leader, function()
		on_enter()

		for _, keymap in ipairs(keymaps) do
			-- stash prev keymaps
			stash[keymap.key] = vim.fn.maparg(keymap.key, mode, false, true)
			vim.keymap.set(mode, keymap.key, keymap.callback, keymap.opts)
		end
	end)
end

return M
