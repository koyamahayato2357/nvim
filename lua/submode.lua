M = {}

---@param mode string|string[]
---@param leader string
---@param followers string[]
function M.set_submode_keymap(mode, leader, followers)
	local uniqid = '<Plug>(' .. leader .. ')'
	local uniqprefix = uniqid .. leader
	vim.keymap.set(mode, uniqprefix, '', { remap = true })
	for _, follower in ipairs(followers) do
		local key = leader .. follower
		vim.keymap.set(mode, key, key .. uniqprefix, { remap = true })
		vim.keymap.set(mode, uniqprefix .. follower, key .. uniqprefix, { remap = true })
	end
end

---@param mode string|string[]
---@param key string
---@param base number?
---@param thre number?
function M.acceleration_key(mode, key, base, thre)
	local uniqid = '<Plug>(' .. key .. ')'
	local count ---@type number
	base = base or 2
	thre = thre or 3

	vim.keymap.set(mode, key, function()
		if vim.v.count > 0 then
			return key
		end

		count = 1
		return key .. uniqid
	end, { expr = true })

	vim.keymap.set(mode, uniqid .. key, function()
		local speed = math.pow(base, math.floor(count / thre))
		count = count + 1
		return speed .. key .. uniqid
	end, { expr = true })

	vim.keymap.set(mode, uniqid, '<Nop>')
end

return M
