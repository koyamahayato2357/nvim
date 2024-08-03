local sendai = {
	green = "#07d101",
	blue = "#00bfff",
	cream = "#edf0e0",
	bush = "#f584c6",
	red = "#f85624",
	brick = "#d8916e",
	navy = "#0047ab",
	gray = "#c0c0c0",
	greenyellow = "#adff2f",
	electriclime = "#ccff00",
	forest = "#228b22",
	cherry = "#ffb7c5",
	gold = "#ffd700",
}

---@param group string
---@param opts table
local function hi(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

hi("Normal", { bg = "None" })
hi("NormalNC", { bg = "None" })
hi("SignColumn", { bg = "None" })
hi("ErrMsg", { bg = "None" })
hi("DiagnosticError", { fg = "Red", bg = "None", bold = true })
hi("DiagnosticLineNrError", { fg = "Red", bg = "None", bold = true })
hi("DiagnosticWarn", { fg = "Yellow", bg = "None", bold = true })
hi("DiagnosticLineNrWarn", { fg = "Yellow", bg = "None", bold = true })
hi("DiagnosticHint", { fg = "Yellow", bg = "None", bold = true })
hi("DiagnosticLineNrHint", { fg = "Yellow", bg = "None", bold = true })
hi("DiagnosticInfo", { fg = "Yellow", bg = "None", bold = true })
hi("DiagnosticLineNrInfo", { fg = "Yellow", bg = "None", bold = true })
hi("CursorLine", { bg = "none" })
hi("CursorLineNR", { fg = sendai.red, bg = "none", bold = true })
hi("CursorLineNC", { bg = "none" })
hi("LineNr", { fg = sendai.navy, bg = "none" })
hi("StatusLine", { bg = "none" })
hi('LspInlayHint', { fg = 'DarkCyan' })
hi("Visual", { bg = sendai.blue })
hi("PmenuSel", { fg = sendai.gold, bg = sendai.blue })
hi("Search", { fg = sendai.cream })
hi("CurSearch", { fg = sendai.forest, bg = sendai.cream })
hi("Substitute", { fg = sendai.cream })

hi("Boolean", { fg = sendai.blue })
hi("Comment", { fg = sendai.gray })
hi("Constant", { fg = sendai.bush })
hi("Statement", { fg = sendai.green, bold = true })
hi("KeyWord", { fg = "white", bold = true })
hi("PreProc", { fg = sendai.brick })
hi("Identifier", { fg = sendai.greenyellow, bold = true })
hi("Special", { fg = sendai.blue })
hi("String", { fg = sendai.cherry })
hi("Type", { fg = sendai.blue, bold = true })
hi("Number", { fg = sendai.gold })
hi("Todo", { fg = sendai.navy, bg = sendai.cream, bold = true })
hi("Operator", { fg = sendai.cream })
hi("Function", { fg = sendai.gold })
hi("SpecialChar", { fg = sendai.bush })
hi("Delimiter", { fg = sendai.forest })

hi("@variable", { fg = sendai.electriclime })
hi("@variable.parameter", { italic = true })
