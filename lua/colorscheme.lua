vim.cmd 'highlight clear'
vim.cmd 'syntax reset'
-- vim.g.colors_name = 'melange'

local bg = vim.opt.background:get()

-- package.loaded['melange/palettes/' .. bg] = nil -- Only needed for development
-- local palette = require('melange/palettes/' .. bg)

Purple = "#8040ff"

A = {
	bg      = "#292522",
	float   = "#34302C",
	sel     = "#403A36",
	ui      = "#867462",
	com     = "#C1A78E",
	fg      = "#ECE1D7",
}
B = {
	red     = "#D47766",
	yellow  = "#EBC06D",
	green   = "#85B695",
	cyan    = "#89B3B6",
	blue    = "#A3A9CE",
	magenta = "#CF9BC2",
}
C = {
	red     = "#BD8183",
	yellow  = "#E49B5D",
	green   = "#78997A",
	cyan    = "#7B9695",
	blue    = "#7F91B2",
	magenta = "#B380B0",
}
D = {
	red     = "#7D2A2F",
	yellow  = "#8B7449",
	green   = "#233524",
	cyan    = "#253333",
	blue    = "#273142",
	magenta = "#422741",
}

local fv
fv = {
	bold = true,
	italic = true,
	underline = true,
	undercurl = true,
	strikethrough = true,
}

for name, attrs in pairs {
	---- :help highlight-default -------------------------------

	Normal = { bg = "none" },
	NormalFloat = { bg = A.float },
	-- NormalNC = {},

	-- Cursor = {},
	-- lCursor = {},
	-- CursorIM = {},
	-- TermCursor = {},
	TermCursorNC = { bg = A.sel },

	ColorColumn = { bg = A.float },
	CursorColumn = 'ColorColumn',
	CursorLine = { bg = "none" },
	VertSplit = { fg = A.ui },
	WinSeparator = { fg = A.ui },

	LineNr = { fg = "#83866c", bg = "none" },
	CursorLineNr = { fg = "#c5d6b9" },

	Folded = { bg = "none" },
	FoldColumn = 'LineNr',
	SignColumn = 'LineNr',

	Pmenu = 'none',
	PmenuSel = { bg = A.sel },
	PmenuSbar = 'Pmenu',
	PmenuThumb = 'PmenuSel',

	StatusLine = { bg = "none" },
	StatusLineNC = { fg = A.com, bg = A.float },
	WildMenu = 'NormalFloat',

	TabLine = 'StatusLineNC',
	TabLineFill = 'StatusLine',
	TabLineSel = { bg = A.float, bold = fv.bold },

	MatchParen = { fg = B.yellow, bg = A.sel, bold = fv.bold },
	Search = { fg = A.bg, bg = D.yellow, bold = fv.bold },
	Substitute = { bg = D.red, bold = fv.bold },
	-- QuickFixLine = {},
	-- IncSearch = {},
	Visual = { bg = Purple },
	-- VisualNOS = {},

	Conceal = { fg = A.com },
	Whitespace = { fg = A.ui },
	EndOfBuffer = { bg = "none" },
	NonText = { bg = 'none', fg = 'black' },
	SpecialKey = 'Whitespace',

	Directory = { fg = C.cyan },
	Title = { fg = C.yellow },
	ErrorMsg = { bg = D.red },
	ModeMsg = { fg = A.com },
	-- MsgArea = {},
	-- MsgSeparator = {},
	MoreMsg = { fg = C.green, bold = fv.bold },
	WarningMsg = { fg = C.red },
	Question = 'MoreMsg',

	---- :help :diff -------------------------------------------

	DiffAdd = { bg = D.green },
	DiffChange = { bg = D.magenta },
	DiffDelete = { bg = D.red },
	DiffText = { bg = D.blue },

	DiffAdded = 'DiffAdd',
	DiffRemoved = 'DiffDelete',

	---- :help spell -------------------------------------------

	SpellBad = { fg = C.red, undercurl = fv.undercurl },
	SpellCap = { fg = C.blue, undercurl = fv.undercurl },
	SpellLocal = { fg = C.yellow, undercurl = fv.undercurl },
	SpellRare = { fg = B.yellow, undercurl = fv.undercurl },

	---- :help group-name --------------------------------------

	Comment = { fg = A.com },
	GitLens = { fg = A.com, italic = fv.italic },
	Identifier = { fg = A.fg },
	Function = { fg = B.yellow },
	Constant = { fg = C.magenta },
	String = { fg = B.blue, italic = fv.italic },
	Character = { fg = C.blue },
	Number = { fg = B.magenta },
	Boolean = 'Number',
	-- Float = {},

	Statement = { fg = C.yellow },
	-- Conditional = {},
	-- Repeat = {},
	-- Label = {},
	Operator = { fg = B.red },
	-- Keyword = {},
	-- Exception = {},

	PreProc = { fg = B.green },
	-- Include = {},
	-- Define = {},
	-- Macro = {},
	-- PreCondit = {},

	Type = { fg = C.cyan },
	-- StorageClass = {},
	-- Structure = {},
	-- Typedef = {},

	Special = { fg = B.yellow },
	-- SpecialChar = {},
	-- Tag = {},
	Delimiter = { fg = D.yellow },
	-- SpecialComment = {},
	-- Debug = {},

	Underlined = { underline = fv.underline },
	Bold = { bold = fv.bold },
	Italic = { italic = fv.italic },

	Ignore = { fg = A.ui },
	Error = { bg = D.red },
	Todo = { fg = "#000000", bg = "#ffffff", bold = fv.bold },

	---- :help nvim-treesitter-highlights (external plugin) ----

	-- ['@boolean'] = {},
	-- ['@number'] = {},
	-- ['@number.float'] = {},

	-- ['@character'] = {},
	-- ['@character.special'] = {},
	-- ['@string'] = {},
	['@string.documentation'] = { fg = B.blue, nocombine = true },
	['@string.escape'] = { fg = C.blue },
	['@string.regexp'] = { fg = B.blue },
	['@string.special'] = { fg = B.cyan },
	['@string.special.symbol'] = { fg = A.fg, italic = fv.italic },
	['@string.special.path'] = { fg = C.blue },
	['@string.special.url'] = '@string.special.path',

	-- ['@keyword'] = {},
	-- ['@keyword.conditional'] = {},
	-- ['@keyword.conditional.ternary'] = {},
	-- ['@keyword.coroutine'] = {},
	-- ['@keyword.debug'] = {},
	['@keyword.directive'] = 'PreProc',
	-- ['@keyword.directive.define'] = {},
	-- ['@keyword.exception'] = {},
	['@keyword.function'] = 'PreProc',
	['@keyword.import'] = 'PreProc',
	-- ['@keyword.operator'] = {},
	-- ['@keyword.repeat'] = {},
	-- ['@keyword.return'] = {},
	-- ['@keyword.storage'] = {},

	--- NOTE: Queries for these highlight groups are really hacky.
	--- Inaccurate syntax highlighting is worse than no highlighting at all,
	['@constant'] = 'Identifier',
	['@constant.builtin'] = 'Constant',
	['@constant.macro'] = 'Constant',
	['@module'] = 'Identifier',
	['@module.builtin'] = '@module',
	['@label'] = { fg = B.cyan },
	['@variable'] = 'Identifier',
	['@variable.builtin'] = '@string.special.symbol',
	-- ['@variable.parameter'] = {},
	-- ['@variable.member'] = {},

	-- ['@type'] = {},
	-- ['@type.builtin'] = {},
	-- ['@type.definition'] = {},
	['@type.qualifier'] = 'Statement',
	-- ['@attribute'] = {},
	-- ['@property'] = {},

	-- ['@function'] = {},
	-- ['@function.builtin'] = {},
	-- ['@function.macro'] = {},
	-- ['@function.method'] = {},
	-- ['@constructor'] = {},

	-- ['@punctuation.bracket'] = {},
	['@punctuation.delimiter'] = { fg = C.red },
	-- ['@punctuation.special'] = {},

	-- ['@comment'] = {},
	['@comment.documentation'] = { fg = A.com, nocombine = true },
	['@comment.error'] = 'Todo',
	['@comment.note'] = 'Todo',
	['@comment.todo'] = 'Todo',
	['@comment.warning'] = 'Todo',

	-- ['@markup'] = {},
	['@markup.heading'] = 'Title',
	['@markup.italic'] = { italic = fv.italic },
	['@markup.strong'] = { bold = fv.bold },
	['@markup.strike'] = { strikethrough = fv.strikethrough },
	['@markup.underline'] = { underline = fv.underline },
	['@markup.quote'] = 'Comment',
	['@markup.math'] = { fg = "#000000", bg = "#ffffff" }, -- TODO
	-- ['@markup.environment'] = {},
	['@markup.link'] = { underline = fv.underline },
	-- ['@markup.link.label'] = {},
	['@markup.link.url'] = '@string.special.url',
	['@markup.raw'] = { fg = A.com },
	-- ['@markup.raw.block'] = {},
	['@markup.list'] = 'Delimiter',
	-- ['@markup.list.checked'] = {},
	-- ['@markup.list.unchecked'] = {},

	['@diff.plus'] = 'DiffAdd',
	['@diff.minus'] = 'DiffDelete',
	['@diff.delta'] = 'DiffChange',

	-- ['@tag'] = {},
	['@tag.attribute'] = '@label',
	['@tag.delimiter'] = 'Delimiter',

	---- :help diagnostic-highlight ----------------------------

	DiagnosticError = { fg = C.red },
	DiagnosticWarn = { fg = B.yellow },
	DiagnosticInfo = { fg = C.blue },
	DiagnosticHint = { fg = C.cyan },
	DiagnosticOk = { fg = C.green },
	DiagnosticUnderlineError = { undercurl = fv.undercurl, sp = C.red },
	DiagnosticUnderlineWarn = { undercurl = fv.undercurl, sp = B.yellow },
	DiagnosticUnderlineInfo = { undercurl = fv.undercurl, sp = C.blue },
	DiagnosticUnderlineHint = { undercurl = fv.undercurl, sp = C.cyan },
	DiagnosticUnderlineOk = { undercurl = fv.undercurl, sp = C.green },
	-- DiagnosticVirtualTextError = {},
	-- DiagnosticVirtualTextWarn = {},
	-- DiagnosticVirtualTextInfo = {},
	-- DiagnosticVirtualTextHint = {},
	-- DiagnosticVirtualTextOk = {},
	-- DiagnosticFloatingError = {},
	-- DiagnosticFloatingWarn = {},
	-- DiagnosticFloatingInfo = {},
	-- DiagnosticFloatingHint = {},
	-- DiagnosticFloatingOk = {},
	-- DiagnosticSignError = {},
	-- DiagnosticSignWarn = {},
	-- DiagnosticSignInfo = {},
	-- DiagnosticSignHint = {},
	-- DiagnosticSignOk = {},

	DiagnosticDeprecated = { DiagnosticUnderlineError },
	DiagnosticUnnecessary = { fg = A.com, undercurl = fv.undercurl },

	---- :help lsp-highlight -----------------------------------

	-- LspReferenceText = 'Visual',
	-- LspReferenceRead = 'Visual',
	-- LspReferenceWrite = 'Visual',

	-- TODO: lsp-highlight-codelens

	---- :help lsp-semantic-highlight --------------------------

	-- ['@lsp.type.class'] = 'Structure',
	-- ['@lsp.type.comment'] = 'Comment',
	-- ['@lsp.type.decorator'] = 'Function',
	-- ['@lsp.type.enum'] = 'Structure',
	-- ['@lsp.type.enumMember'] = 'Constant',
	-- ['@lsp.type.function'] = 'Function',
	-- ['@lsp.type.interface'] = 'Structure',
	['@lsp.type.macro'] = 'Function',
	-- ['@lsp.type.method'] = 'Function',
	['@lsp.type.namespace'] = { fg = C.green },
	['@lsp.type.parameter'] = { fg = A.fg, bold = fv.bold },
	-- ['@lsp.type.property'] = 'Identifier',
	-- ['@lsp.type.struct'] = 'Structure',
	-- ['@lsp.type.type'] = 'Type',
	-- ['@lsp.type.typeParameter'] = 'TypeDef',
	['@lsp.type.variable'] = 'Identifier',

	---- :help vimtex-syntax-reference (external plugin) -------

	texOptSep = '@punctuation.delimiter',
	texOptEqual = 'Operator',
	texFileArg = 'Constant',
	texTitleArg = { bold = fv.bold },
	texRefArg = 'Constant',

	texMathCmd = 'Function',
	texMathSymbol = 'Operator',
	texMathZone = 'TSMath',
	texMathDelimZone = 'TSPunctDelimiter',
	texMathDelim = 'Delimiter',
	texMathEnvArgName = 'PreProc',

	--- neo-tree highlights  :help neo-tree-highlights ---

	NeoTreeNormal = 'NormalFloat',
	NeoTreeNormalNC = 'NeoTreeNormal',
	NeoTreeVertSplit = { bg = A.bg, fg = A.bg },
	NeoTreeWinSeparator = 'NeoTreeVertSplit',

	NeoTreeCursorLine = { bg = A.sel },

	--- netrw: there's no comprehensive list of highlights... --

	netrwClassify = 'Delimiter',
	netrwTreeBar = 'Delimiter',
	netrwExe = { fg = C.red },
	netrwSymLink = { fg = C.magenta },

	---- :h gitsigns (external plugin) -------------------------

	GitSignsAdd = { fg = C.green },
	GitSignsChange = { fg = C.magenta },
	GitSignsDelete = { fg = C.red },
	GitSignsCurrentLineBlame = { fg = C.blue },

	SignifySignAdd = 'GitSignsAdd',
	SignifySignChange = 'GitSignsChange',
	SignifySignDelete = 'GitSignsDelete',

	---- :h ibl.highlights (external plugin) -------------------
	IblIndent = { fg = A.sel, nocombine = true },
	IblWhitespace = 'IblIndent',
	IndentBlanklineChar = 'IblIndent', -- Deprecated?
	IndentBlanklineSpaceChar = 'IndentBlanklineChar',
	IndentBlanklineSpaceCharBlankline = 'IndentBlanklineChar',
} do
if type(attrs) == 'table' then
	vim.api.nvim_set_hl(0, name, attrs)
else
	vim.api.nvim_set_hl(0, name, { link = attrs })
end
end

-- See https://github.com/neovim/neovim/pull/7406
vim.g.terminal_color_0 = A.float
vim.g.terminal_color_1 = C.red
vim.g.terminal_color_2 = C.green
vim.g.terminal_color_3 = C.yellow
vim.g.terminal_color_4 = C.blue
vim.g.terminal_color_5 = C.magenta
vim.g.terminal_color_6 = C.cyan
vim.g.terminal_color_7 = A.com
vim.g.terminal_color_8 = A.ui
vim.g.terminal_color_9 = B.red
vim.g.terminal_color_10 = B.green
vim.g.terminal_color_11 = B.yellow
vim.g.terminal_color_12 = B.blue
vim.g.terminal_color_13 = B.magenta
vim.g.terminal_color_14 = B.cyan
vim.g.terminal_color_15 = A.fg

-- vi:nowrap
