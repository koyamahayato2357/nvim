local fuzpath = require 'fuzpath'

local id = { name = 1, count = 2 }

---@param tbl table<string, number>[]
---@param val string
local function insert(tbl, val)
	table.insert(tbl, { val, 1 })
end

---@param rec1 table<string, number>
---@param rec2 table<string, number>
---@return boolean
local function compare(rec1, rec2)
	return rec1[id.count] > rec2[id.count]
end

---@param name string
---@return table<string, number>
local function readfile(name)
	local ret = {}
	local fp = io.open(name, 'r')
	if not fp then return {} end
	for line in fp:lines() do
		table.insert(ret, vim.split(line, ','))
	end
	fp:close()
	table.sort(ret, compare)
	return ret
end

local logfile = vim.fn.stdpath("data") .. '/cdtrack/dir.log'
local dirs_table = readfile(logfile)

---@param self table
---@param n number
---@return table
local function getcol(self, n)
	return vim.tbl_map(function(row)
		return row[n]
	end, self)
end

local cwd = vim.uv.cwd()
if not vim.tbl_contains(getcol(dirs_table, id.name), cwd) then
	insert(dirs_table, cwd)
end

---@param dirs table<string, number>[]
---@param dir string
---@return number?
local function finddirrecord(dirs, dir)
	for _, rec in ipairs(dirs) do
		if rec[id.name] == dir then
			return _
		end
	end
end

---@param dirs table<string, number>[]
---@param dir string
local function update_record(dirs, dir)
	local index = finddirrecord(dirs, dir)
	if index then
		dirs[index][id.count] = dirs[index][id.count] + 1
	else
		insert(dirs, dir)
	end
end

local function normalize_path(dir)
	local isrel = dir:sub(1, 1) ~= '/'
	local base = isrel and vim.uv.cwd() .. '/' or ''
	return vim.fs.normalize(base .. dir)
end

local function rm_nonexistpath(pathtbl)
	local i = 1
	while i <= #pathtbl do
		if vim.uv.fs_stat(pathtbl[i]) then
			i = i + 1
		else
			table.remove(pathtbl, i)
		end
	end
	return pathtbl
end

---@param trigger string
---@return string[]
local function findmatch(trigger)
	local matched = fuzpath.fuzpath(getcol(dirs_table, id.name), trigger)
	return rm_nonexistpath(matched)
end

---@param input string
local function cdtrack(input)
	local dir = normalize_path(input)

	if not vim.uv.fs_stat(dir) then
		local candidates = findmatch(input)

		if #candidates == 0 then
			print('No such directory ' .. dir)
			return
		end

		if #candidates == 1 then
			dir = candidates[1]
		else
			vim.ui.select(candidates, { prompt = 'Select Directory:' }, function(choise)
				dir = choise
			end)
		end
	end

	vim.cmd.cd(dir)
end

vim.api.nvim_create_user_command('Z', function(opts)
	cdtrack(opts.fargs[1])
end, { nargs = 1, bar = true, complete = findmatch })

vim.keymap.set('n', 'Zf', function()
	vim.ui.input({ prompt = 'cdtrack: ', complete = findmatch }, cdtrack)
end)

vim.api.nvim_create_autocmd('DirChanged', {
	callback = function()
		update_record(dirs_table, vim.uv.cwd())
	end
})

vim.api.nvim_create_autocmd('VimLeave', {
	callback = function()
		-- ensure directory exists
		if vim.fn.mkdir(vim.fn.fnamemodify(logfile, ':p:h'), 'p') ~= 1 then return end
		local buf = table.concat(vim.tbl_map(function(row)
			return table.concat(row, ',')
		end, dirs_table), '\n')
		local fp = io.open(logfile, 'w')
		if not fp then return end -- no one wants to see errors when leaving
		fp:write(buf)
		fp:close()
	end
})
