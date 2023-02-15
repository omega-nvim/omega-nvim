local theme = require("omega.colors.themes." .. vim.g.colors_name)
local colors = theme.colors
local base16 = theme.base16
local config = require("omega.config")
colors.tele_bg = colors.telescope_bg or colors.darker_black
colors.tele_prompt = colors.telescope_prompt or colors.black2

local highlights = {
    ["Normal"] = { fg = base16.base05, bg = base16.base00 },
    ["Bold"] = { bold = true },
    ["Debug"] = { fg = base16.base08 },
    ["Directory"] = { fg = base16.base0D },
    ["Error"] = { fg = base16.base00, bg = base16.base08 },
    ["ErrorMsg"] = { fg = base16.base08, bg = base16.base00 },
    ["Exception"] = { fg = base16.base08 },
    ["FoldColumn"] = { fg = base16.base0C, bg = base16.base01 },
    ["CurSearch"] = { fg = base16.base01, bg = base16.base09 },
    ["Italic"] = { italic = true },
    ["Macro"] = { fg = base16.base08, italic = true },
    ["MatchParen"] = { bold = true },
    ["ModeMsg"] = { fg = base16.base0B },
    ["MoreMsg"] = { fg = base16.base0B },
    ["Question"] = { fg = base16.base0D },
    ["Substitute"] = { fg = base16.base01, bg = base16.base0A },
    ["SpecialKey"] = { fg = base16.base03 },
    ["TooLong"] = { fg = base16.base08 },
    ["Underlined"] = { fg = base16.base08 },
    ["Visual"] = { bg = base16.base02 },
    ["VisualNOS"] = { fg = base16.base08 },
    ["WarningMsg"] = { fg = base16.base08 },
    ["WildMenu"] = { fg = base16.base08, bg = base16.base0A },
    ["Title"] = { fg = base16.base0D },
    ["Conceal"] = {},
    ["Cursor"] = { fg = base16.base00, bg = base16.base05 },
    ["NonText"] = { fg = base16.base03 },
    ["NeorgMarkupVerbatim"] = { fg = base16.base03 },
    ["SignColumn"] = { fg = base16.base03 },
    ["StatusLine"] = { fg = base16.base04 },
    ["StatusLineNC"] = { fg = base16.base03 },
    ["ColorColumn"] = { bg = base16.base01 },
    ["CursorColumn"] = { bg = base16.base01 },
    ["CursorLine"] = { bg = base16.base01 },
    ["CursorLineNr"] = { fg = base16.base04 },
    ["QuickFixLine"] = { bg = base16.base01 },
    ["TabLine"] = { fg = base16.base03, bg = base16.base01 },
    ["TabLineFill"] = { fg = base16.base03, bg = base16.base01 },
    ["TabLineSel"] = { fg = base16.base0B, bg = base16.base01 },
    ["Boolean"] = { fg = base16.base09 },
    ["Character"] = { fg = base16.base08 },
    ["Conditional"] = { fg = base16.base0E, italic = true },
    ["Constant"] = { fg = base16.base09 },
    ["Define"] = { fg = base16.base0E },
    ["Delimiter"] = { fg = base16.base0F },
    ["Float"] = { fg = base16.base09 },
    ["Identifier"] = { fg = base16.base08 },
    ["Include"] = { fg = base16.base0D },
    ["Label"] = { fg = base16.base0A },
    ["Number"] = { fg = base16.base09 },
    ["Operator"] = { fg = base16.base05 },
    ["PreProc"] = { fg = base16.base0A },
    ["Repeat"] = { fg = base16.base0A },
    ["SpecialChar"] = { fg = base16.base0F },
    ["Statement"] = { fg = base16.base08 },
    ["StorageClass"] = { fg = base16.base0A },
    ["String"] = { fg = base16.base0B },
    ["Structure"] = { fg = base16.base0E },
    ["Tag"] = { fg = base16.base0A },
    ["Todo"] = { fg = base16.base0A, bg = base16.base01 },
    ["Type"] = { fg = base16.base0A },
    ["Typedef"] = { fg = base16.base0A },
    ["DiffDelete"] = { fg = base16.base08, bg = base16.base01 },
    ["DiffText"] = { fg = base16.base0D, bg = base16.base01 },
    ["DiffAdded"] = { fg = base16.base0B, bg = base16.base00 },
    ["DiffFile"] = { fg = base16.base08, bg = base16.base00 },
    ["DiffNewFile"] = { fg = base16.base0B, bg = base16.base00 },
    ["DiffLine"] = { fg = base16.base0D, bg = base16.base00 },
    ["DiffRemoved"] = { fg = base16.base08, bg = base16.base00 },
    ["gitcommitOverflow"] = { fg = base16.base08 },
    ["gitcommitSummary"] = { fg = base16.base0B },
    ["gitcommitComment"] = { fg = base16.base03 },
    ["gitcommitUntracked"] = { fg = base16.base03 },
    ["gitcommitDiscarded"] = { fg = base16.base03 },
    ["gitcommitSelected"] = { fg = base16.base03 },
    ["gitcommitHeader"] = { fg = base16.base0E },
    ["gitcommitSelectedType"] = { fg = base16.base0D },
    ["gitcommitUnmergedType"] = { fg = base16.base0D },
    ["gitcommitDiscardedType"] = { fg = base16.base0D },
    ["gitcommitBranch"] = { fg = base16.base09, bold = true },
    ["gitcommitUntrackedFile"] = { fg = base16.base0A },
    ["gitcommitUnmergedFile"] = { fg = base16.base08, bold = true },
    ["gitcommitDiscardedFile"] = { fg = base16.base08, bold = true },
    ["gitcommitSelectedFile"] = { fg = base16.base0B, bold = true },
    ["mailQuoted1"] = { fg = base16.base0A },
    ["mailQuoted2"] = { fg = base16.base0B },
    ["mailQuoted3"] = { fg = base16.base0E },
    ["mailQuoted4"] = { fg = base16.base0C },
    ["mailQuoted5"] = { fg = base16.base0D },
    ["mailQuoted6"] = { fg = base16.base0A },
    ["mailURL"] = { fg = base16.base0D },
    ["mailEmail"] = { fg = base16.base0D },
    ["SpellLocal"] = { undercurl = true, sp = base16.base0C },
    ["SpellCap"] = { undercurl = true, sp = base16.base0D },
    ["SpellRare"] = { undercurl = true, sp = base16.base0E },
    ["@comment"] = { fg = base16.base03, italic = true },
    ["@error"] = { fg = base16.base08 },
    ["@none"] = { fg = base16.base05 },
    ["@preproc"] = { fg = base16.base0A },
    ["@define"] = { fg = base16.base0A },
    ["@operator"] = { fg = base16.base05 },
    ["@punctuation.delimiter"] = { fg = base16.base0F },
    ["@puncuation.bracket"] = { fg = base16.base0D },
    ["@punctuation.special"] = { fg = base16.base05 },
    ["@string"] = { fg = base16.base0B },
    ["@string.regex"] = { fg = base16.base0C },
    ["@string.escape"] = { fg = base16.base0C },
    ["@string.special"] = { fg = base16.base0C },
    ["@character"] = { fg = base16.base08 },
    ["@character.special"] = { fg = base16.base0F },
    ["@boolean"] = { fg = base16.base09 },
    ["@number"] = { fg = base16.base09 },
    ["@float"] = { fg = base16.base09 },
    ["@function"] = { fg = base16.base0D, italic = true },
    ["@function.builtin"] = { fg = base16.base0D },
    ["@function.call"] = { fg = base16.base0D },
    ["@function.macro"] = { fg = base16.base08 },
    ["@method"] = { fg = base16.base0D, italic = true },
    ["@method.call"] = { fg = base16.base0D },
    ["@constructor"] = { fg = base16.base0C },
    ["@parameter"] = { fg = base16.base08 },
    ["@keyword"] = { fg = base16.base0E },
    ["@keyword.function"] = { fg = base16.base0E },
    ["@keyword.operator"] = { fg = base16.base0E },
    ["@keyword.return"] = { fg = base16.base0E },
    ["@conditional"] = { fg = base16.base0E, italic = true },
    ["@repeat"] = { fg = base16.base0A },
    ["@debug"] = { fg = base16.base08 },
    ["@label"] = { fg = base16.base0A },
    ["@include"] = { fg = base16.base0D },
    ["@exception"] = { fg = base16.base08 },
    ["@type"] = { fg = base16.base0A },
    ["@type.builtin"] = { fg = base16.base0A },
    ["@type.definition"] = { fg = base16.base0A },
    ["@type.qualifier"] = { fg = base16.base0A },
    ["@storageclass"] = { fg = base16.base0A },
    ["@attribute"] = { fg = base16.base0A },
    ["@field"] = { fg = base16.base08 },
    ["@property"] = { fg = base16.base08 },
    ["@variable"] = { fg = base16.base05 },
    ["@variable.builtin"] = { fg = base16.base09 },
    ["@constant"] = { fg = base16.base09 },
    ["@constant.builtin"] = { fg = base16.base09 },
    ["@constant.macro"] = { fg = base16.base08 },
    ["@namespace"] = { fg = base16.base08 },
    ["@symbol"] = { fg = base16.base0B },
    ["@text"] = { fg = base16.base05 },
    ["@text.strong"] = { bold = true },
    ["@text.emphasis"] = { fg = base16.base09, italic = true },
    ["@text.underline"] = { fg = base16.base05, underline = true },
    ["@text.strike"] = { fg = base16.base05, strikethrough = true },
    ["@text.title"] = { bold = true, underline = true },
    ["@text.literal"] = { fg = base16.base09 },
    ["@text.uri"] = { fg = base16.base09, underline = true },
    ["@text.math"] = { fg = base16.base0C },
    ["@text.environment"] = { fg = base16.base0D },
    ["@text.environment.name"] = { fg = base16.base05, italic = true },
    ["@text.reference"] = { fg = base16.base09 },
    ["@text.todo"] = { fg = base16.base0A, bg = base16.base01 },
    ["@text.note"] = { fg = base16.base0D, bg = base16.base01 },
    ["@text.warning"] = { fg = base16.base0A, bg = base16.base01 },
    ["@text.danger"] = { fg = base16.base0F, bg = base16.base01 },
    ["@text.diff.add"] = { fg = base16.base0B },
    ["@text.diff.delete"] = { fg = base16.base08 },
    ["@tag"] = { fg = base16.base0A },
    ["@tag.attribute"] = { fg = base16.base0A },
    ["@tag.delimiter"] = { fg = base16.base0F },
    ["@conceal"] = { fg = base16.base05 },
    ["@definition"] = { underline = true, sp = base16.base04 },
    ["@scope"] = { bold = true },
    ["TSAnnotation"] = { fg = base16.base0F },
    ["TSError"] = { fg = base16.base08 },
    ["TSParameterReference"] = { fg = base16.base05 },
    ["TSPunctDelimiter"] = { fg = base16.base0F },
    ["LspDiagnosticsDefaultError"] = { fg = base16.base08 },
    ["LspDiagnosticsDefaultWarning"] = { fg = base16.base0A },
    ["LspDiagnosticsDefaultWarn"] = { fg = base16.base0A },
    ["LspDiagnosticsDefaultInformation"] = { fg = base16.base0D },
    ["LspDiagnosticsDefaultInfo"] = { fg = base16.base0D },
    ["LspDiagnosticsDefaultHint"] = { fg = base16.base0C },
    ["TelescopeNormal"] = { fg = base16.base05, bg = base16.base00 },
    ["TelescopePreviewNormal"] = { fg = base16.base05, bg = base16.base00 },
    ["Keyword"] = { fg = base16.base0E, italic = true },
    ["PMenu"] = { fg = base16.base05, bg = base16.base00 },
    ["Special"] = { fg = base16.base0C, italic = true },
    ["markdownBold"] = { fg = base16.base0A, bold = true },
    ["@quantifier"] = { fg = base16.base0C, italic = true },
    ["@require_call"] = { fg = base16.base0E, italic = true },
    ["@utils"] = { fg = base16.base0D },
    ["@code"] = { fg = base16.base03 },
    ["@rust_path"] = { fg = base16.base0B },
    ["CodeActionAvailable"] = { fg = base16.base08 },

    Comment = { fg = colors.grey_fg, italic = true },
    TS_Context = { bg = colors.grey_fg },
    Yellow = { fg = colors.yellow },
    Red = { fg = colors.red },
    Green = { fg = colors.green },
    EndOfBuffer = { fg = colors.black },
    NormalFloat = {},

    DiagnosticWarn = { fg = colors.orange },
    DiagnosticError = { fg = colors.red },
    DiagnosticInfo = { fg = colors.yellow },
    DiagnosticHint = { fg = colors.blue },

    SpellBad = { undercurl = true, sp = colors.red },

    PmenuSbar = { bg = colors.one_bg2 },

    LineNr = { fg = colors.grey },
    NvimInternalError = { fg = colors.red },
    VertSplit = { fg = colors.one_bg2 },

    PmenuThumb = { bg = colors.white },
    WinSeparator = { fg = colors.one_bg2 },
    CmpDocumentationWindowBorder = { fg = colors.one_bg2 },

    NeorgCodeBlock = { bg = colors.darker_black },

    Folded = {},

    DashboardHeader = { fg = colors.grey_fg },
    DashboardFooter = { fg = colors.grey_fg },
    DashboardCenter = { fg = colors.grey_fg },
    DashboardShortcut = { fg = colors.grey_fg },

    DiffAdd = { fg = colors.nord_blue },
    DiffChange = { fg = colors.grey_fg },
    DiffModified = { fg = colors.nord_blue },

    IndentBlanklineChar = { fg = colors.line },

    LspDiagnosticsSignError = { fg = colors.red },
    LspDiagnosticsSignWarning = { fg = colors.yellow },
    LspDiagnosticsVirtualTextError = { fg = colors.red },
    LspDiagnosticsVirtualTextWarning = { fg = colors.yellow },

    LspDiagnosticsSignInformation = { fg = colors.green },
    LspDiagnosticsVirtualTextInformation = { fg = colors.green },
    LspDiagnosticsSignHint = { fg = colors.purple },
    LspDiagnosticsVirtualTextHint = { fg = colors.purple },
    NotifyERRORBorder = { fg = colors.red },
    NotifyERRORIcon = { fg = colors.red },
    NotifyERRORTitle = { fg = colors.red },
    NotifyWARNBorder = { fg = colors.orange },
    NotifyWARNIcon = { fg = colors.orange },
    NotifyWARNTitle = { fg = colors.orange },
    NotifyINFOBorder = { fg = colors.green },
    NotifyINFOIcon = { fg = colors.green },
    NotifyINFOTitle = { fg = colors.green },
    NotifyDEBUGBorder = { fg = colors.grey },
    NotifyDEBUGIcon = { fg = colors.grey },
    NotifyDEBUGTitle = { fg = colors.grey },
    NotifyTRACEBorder = { fg = colors.purple },
    NotifyTRACEIcon = { fg = colors.purple },
    NotifyTRACETitle = { fg = colors.purple },
    NvimTreeEmptyFolderName = { fg = colors.blue },
    NvimTreeEndOfBuffer = { fg = colors.darker_black },
    NvimTreeFolderIcon = { fg = colors.folder_bg },
    NvimTreeFolderName = { fg = colors.folder_bg },
    NvimTreeGitDirty = { fg = colors.red },
    NvimTreeIndentMarker = { fg = colors.one_bg2 },
    NvimTreeNormal = { bg = colors.darker_black },
    NvimTreeOpenedFolderName = { fg = colors.blue },
    NvimTreeRootFolder = { fg = colors.red, underline = true },
    NvimTreeStatuslineNc = { fg = colors.darker_black, bg = colors.darker_black },
    NvimTreeVertSplit = { fg = colors.darker_black, bg = colors.darker_black },
    NvimTreeWindowPicker = { fg = colors.red, bg = colors.tele_prompt },

    Search = { bg = colors.yellow },
    IncSearch = { bg = colors.red },

    TelescopeBorder = { fg = colors.folder_bg },

    LspReferenceRead = { link = "Visual" },
    LspReferenceText = { link = "Visual" },
    LspReferenceWrite = { link = "Visual" },

    LightspeedLabel = { fg = "#7DB000" },
    LightspeedShortcut = { bg = "#7DB000" },
    LightspeedOneCharMatch = { bg = "#7DB000" },
    LightspeedUniqueChar = { fg = "#FF6000" },
    LightspeedUnlabeledMatch = { fg = "#FF6000" },

    Definition = { fg = colors.white, bg = colors.darker_black },
    FloatBorder = { fg = colors.light_grey, bg = colors.black },

    PmenuSel = { fg = colors.blue, bg = colors.light_grey },

    LspSignatureActiveParameter = { bold = true, italic = true },

    NoicePopup = { bg = colors.darker_black },
    LazyH1 = {
        bg = colors.green,
        fg = colors.black,
    },

    LazyButton = {
        bg = colors.one_bg,
        fg = require("omega.utils.colors").lighten_color(colors.light_grey, 10),
    },

    LazyH2 = {
        fg = colors.red,
        bold = true,
        underline = true,
    },

    LazyReasonPlugin = { fg = colors.red },
    LazyValue = { fg = colors.teal },
    LazyDir = { fg = base16.base05 },
    LazyUrl = { fg = base16.base05 },
    LazyCommit = { fg = colors.green },
    LazyNoCond = { fg = colors.red },
    LazySpecial = { fg = colors.blue },
    LazyReasonFt = { fg = colors.purple },
    LazyOperator = { fg = colors.white },
    LazyReasonKeys = { fg = colors.teal },
    LazyTaskOutput = { fg = colors.white },
    LazyCommitIssue = { fg = colors.pink },
    LazyReasonEvent = { fg = colors.yellow },
    LazyReasonStart = { fg = colors.white },
    LazyReasonRuntime = { fg = colors.nord_blue },
    LazyReasonCmd = { fg = colors.sun },
    LazyReasonSource = { fg = colors.cyan },
    LazyReasonImport = { fg = colors.white },
    LazyProgressDone = { fg = colors.green },
}

local kind_highlights = {
    Class = base16.base08,
    Color = base16.base08,
    Constant = base16.base09,
    Constructor = base16.base08,
    Enum = base16.base08,
    EnumMember = base16.base08,
    Event = base16.base0D,
    Field = base16.base08,
    File = base16.base09,
    Folder = base16.base09,
    Function = base16.base0D,
    Interface = base16.base0D,
    Keyword = base16.base0E,
    Method = base16.base08,
    Module = base16.base08,
    Operator = base16.base08,
    Property = base16.base0A,
    Reference = base16.base08,
    Snippet = base16.base0C,
    Struct = base16.base08,
    Text = base16.base0B,
    TypeParameter = base16.base08,
    Type = base16.base0A,
    Unit = base16.base08,
    Value = base16.base08,
    Variable = base16.base0E,
    Structure = base16.base0E,
    Identifier = base16.base08,
}
local color_utils = require("omega.utils.colors")
for kind_name, hl in pairs(kind_highlights) do
    highlights[("CmpItemKind%s"):format(kind_name)] = {
        fg = hl,
        bg = color_utils.blend_colors(hl, base16.base00, 0.15),
    }
    highlights[("CmpItemKindMenu%s"):format(kind_name)] = { fg = hl }
    highlights[("CmpItemKindBlock%s"):format(kind_name)] = { fg = color_utils.blend_colors(hl, base16.base00, 0.15) }
end

highlights.TelescopeSelectionCaret = { fg = colors.blue, bg = colors.light_grey }
highlights.TelescopeSelection = { fg = colors.blue, bg = colors.light_grey }

highlights.TelescopePreviewLine = { bg = colors.light_grey }

highlights.TelescopePromptPrefix = { fg = colors.red }

if config.ui.telescope.titles == "blocks" then
    highlights.TelescopeResultsTitle = { fg = colors.black, bg = colors.blue }
    highlights.TelescopePromptTitle = { fg = colors.black, bg = colors.red }
    highlights.TelescopePreviewTitle = { fg = colors.black, bg = colors.green }
elseif config.ui.telescope.titles == "no_bg" then
end

if config.ui.telescope.borders then
    highlights.TelescopeBorder = { fg = colors.light_grey, bg = colors.black }
    highlights.TelescopePromptBorder = { fg = colors.light_grey, bg = colors.black }
    highlights.TelescopePreviewBorder = { fg = colors.light_grey, bg = colors.black }
    highlights.TelescopeResultsBorder = { fg = colors.light_grey, bg = colors.black }

    highlights.TelescopePromptNormal = { fg = colors.white }
    highlights.TelescopePreviewNormal = { bg = colors.black }

    highlights.TelescopeNormal = { bg = colors.black }
else
    highlights.TelescopeBorder = { fg = colors.tele_bg, bg = colors.tele_bg }
    highlights.TelescopePreviewBorder = { fg = colors.tele_bg, bg = colors.tele_bg }
    highlights.TelescopeResultsBorder = { fg = colors.tele_bg, bg = colors.tele_bg }
    highlights.TelescopePromptBorder = { fg = colors.tele_prompt, bg = colors.tele_prompt }

    highlights.TelescopePromptNormal = { fg = colors.white, bg = colors.tele_prompt }
    highlights.TelescopePreviewNormal = { bg = colors.tele_bg }

    highlights.TelescopeNormal = { bg = colors.tele_bg }
end

return highlights
