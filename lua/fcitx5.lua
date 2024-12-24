local IM_cmd = "fcitx5-remote"
local toggle_IM = { IM_cmd, "-t" }
local was_IM_enabled = false            -- was im enabled in previous insert mode

---@return boolean
local function get_IM_status()
	return vim.system({ IM_cmd }):wait().stdout:sub(1, 1) == '2'
end

local function toggle_IM_status()
	if was_IM_enabled then vim.system(toggle_IM) end
end

vim.api.nvim_create_autocmd("InsertEnter", { callback = toggle_IM_status })

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		was_IM_enabled = get_IM_status()
		toggle_IM_status()
	end
})
