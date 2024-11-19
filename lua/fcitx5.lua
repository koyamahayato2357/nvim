local IM_cmd = "fcitx5-remote"
local toggle_IM = { IM_cmd, "-t" }
local was_IM_enabled = false            -- was im enabled in previous insert mode

if vim.fn.executable(IM_cmd) ~= 1 then  -- file not exists
	vim.notify('\'' .. IM_cmd .. '\' is not installed', vim.log.levels.ERROR)
	return
end

if vim.system({ IM_cmd, "--check" }):wait().code == 1 then  -- not running
	vim.system({ IM_cmd })                                  -- start
end

---@return boolean
local function get_IM_status()
	return vim.system({ IM_cmd }):wait().stdout:sub(1, 1) == '2'
end

local function toggle_IM_status()
	if was_IM_enabled then vim.system(toggle_IM) end
end

vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		toggle_IM_status()
	end
})

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		was_IM_enabled = get_IM_status()
		toggle_IM_status()
	end
})
