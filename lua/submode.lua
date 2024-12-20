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

---@class FolOpts

---@class Follower
---@field key string
---@field callback fun(): string??
---@field opts FolOpts?

---@class Autos
---@field entering (fun(): string?|string)?
---@field repeating (fun(): string?|string)?
---@field leaving (fun(): string?|string)?

---@param mode string|string[]
---@param leader string
---@param followers Follower[]
---@param run_when Autos?
function M.set_submode_keymap(mode, leader, followers, run_when)
	run_when = run_when or {}
	local uniqid = make_uniq(leader)
	local uniqprefix = uniqid .. leader
	for _, follower in ipairs(followers) do
		local key = leader .. follower.key
		local callback = follower.callback
		local rhs = not callback and key .. uniqprefix or function()
			return (callback() or '') .. uniqprefix
		end

		run_when.entering = run_when.entering or rhs
		run_when.repeating = run_when.repeating or rhs
		run_when.leaving = run_when.leaving or ''

		map(mode, key, run_when.entering, true)
		map(mode, uniqprefix .. follower.key, run_when.repeating, true)
	end

	map(mode, uniqprefix, run_when.leaving, true)
end

---@class AccOpts
---@field base number?
---@field thre number?

---@param mode string|string[]
---@param key string
---@param callback fun(): string??
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
			return speed .. (callback() or '') .. uniqid
		end

		return speed .. key .. uniqid
	end, { expr = true })

	vim.keymap.set(mode, uniqid, '<Nop>')
end

return M
