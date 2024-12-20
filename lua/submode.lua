M = {}

---@param str string
---@return string
local function make_uniq(str)
	return '<Plug>(' .. str .. ')'
end

---@class FolOpts

---@class Follower
---@field key string
---@field callback (fun(): string)?
---@field opts FolOpts?

---@param mode string|string[]
---@param leader string
---@param followers Follower[]
function M.set_submode_keymap(mode, leader, followers)
	local uniqid = make_uniq(leader)
	local uniqprefix = uniqid .. leader
	vim.keymap.set(mode, uniqprefix, '', { remap = true })
	for _, follower in ipairs(followers) do
		local key = leader .. follower.key
		local callback = follower.callback

		if callback then
			local cb = function() return (callback() or '') .. uniqprefix end
			vim.keymap.set(mode, key, cb, { expr = true, remap = true })
			vim.keymap.set(mode, uniqprefix .. follower.key, cb, { expr = true, remap = true })
		else
			vim.keymap.set(mode, key, key .. uniqprefix, { remap = true })
			vim.keymap.set(mode, uniqprefix .. follower.key, key .. uniqprefix, { remap = true })
		end
	end
end

---@class AccOpts
---@field base number?
---@field thre number?

---@param mode string|string[]
---@param key string
---@param opts AccOpts?
function M.acceleration_key(mode, key, opts)
	local uniqid = make_uniq(key)
	local count ---@type number
	local base = opts and opts.base or 2
	local thre = opts and opts.thre or 3

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
