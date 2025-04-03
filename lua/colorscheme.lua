local NITSC = {
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
hi("CursorLine", { bg = "none" })
hi("CursorLineNR", { fg = NITSC.red, bg = "none", bold = true })
hi("CursorLineNC", { bg = "none" })
hi("LineNr", { fg = NITSC.navy, bg = "none" })
hi("StatusLine", { bg = "none" })
hi("StatusLineNC", { bg = "none" })
hi('LspInlayHint', { fg = 'DarkCyan' })
hi("Visual", { bg = NITSC.blue })
hi("PmenuSel", { fg = NITSC.gold, bg = NITSC.blue })
hi("Search", { fg = NITSC.cream })
hi("CurSearch", { fg = NITSC.forest, bg = NITSC.cream })
hi("Substitute", { fg = NITSC.cream })
hi("WinSeparator", { fg = NITSC.blue })

hi("Boolean", { fg = NITSC.blue })
hi("Comment", { fg = NITSC.gray })
hi("Constant", { fg = NITSC.bush })
hi("Statement", { fg = NITSC.green, bold = true })
hi("KeyWord", { fg = NITSC.cream, bold = true })
hi("PreProc", { fg = NITSC.brick })
hi("Identifier", { fg = NITSC.greenyellow, bold = true })
hi("Special", { fg = NITSC.blue })
hi("String", { fg = NITSC.cherry })
hi("Type", { fg = NITSC.blue, bold = true })
hi("Number", { fg = NITSC.gold })
hi("Todo", { fg = NITSC.navy, bg = NITSC.cream, bold = true })
hi("Operator", { fg = NITSC.cream })
hi("Function", { fg = NITSC.gold })
hi("SpecialChar", { fg = NITSC.bush })
hi("Delimiter", { fg = NITSC.cream })

hi("@variable", { fg = NITSC.electriclime })
hi("@variable.parameter", { italic = true })
