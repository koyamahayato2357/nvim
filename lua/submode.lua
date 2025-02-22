M = {}

---@param str string
---@return string
local function make_uniq(str)
	return '<Plug>(' .. str .. ')'
end

local function isfun(any)
	return type(any) == 'function'
end

local function map(mode, lhs, rhs, remap)
	vim.keymap.set(mode, lhs, rhs, { expr = isfun(rhs), remap = remap })
end

---@class Autos
---@field entering (fun(): string?|string)?
---@field repeating (fun(): string?|string)?
---@field leaving (fun(): string?|string)? (reserved)

---@class Follower
---@field key string
---@field run_when Autos?

---@param mode string|string[]
---@param leader string
---@param followers Follower[]
function M.set_submode_keymap(mode, leader, followers)
	local uniqid = make_uniq(leader)
	local uniqprefix = uniqid .. leader
	for _, follower in ipairs(followers) do
		local key = leader .. follower.key
		local run_when = follower.run_when or {}

		local get_rhs = function(any)
			if not any then
				return key .. uniqprefix
			elseif type(any) == 'string' then
				return any .. uniqprefix
			elseif isfun(any) then
				return function()
					return (any() or '') .. uniqprefix
				end
			end
		end

		map(mode, key, get_rhs(run_when.entering), true)
		map(mode, uniqprefix .. follower.key, get_rhs(run_when.repeating), true)
	end

	map(mode, uniqprefix, '', true)
end

---@class AccOpts
---@field base number?
---@field thre number?

---@param mode string|string[]
---@param key string
---@param callback (fun(): string?)?
---@param opts AccOpts?
function M.acceleration_key(mode, key, callback, opts)
	local uniqid = make_uniq(key)
	local count ---@type number
	local base = opts and opts.base or 2
	local thre = opts and opts.thre or 3

	vim.keymap.set(mode, key, function()
		if vim.v.count > 0 then
			return key
		end

		count = 1

		if callback then
			return (callback() or '') .. uniqid
		end

		return key .. uniqid
	end, { expr = true })

	vim.keymap.set(mode, uniqid .. key, function()
		local speed = math.pow(base, math.floor(count / thre))
		count = count + 1

		if callback then
			return speed .. (callback() or key) .. uniqid
		end

		return speed .. key .. uniqid
	end, { expr = true })

	vim.keymap.set(mode, uniqid, '<Nop>')
end

return M
