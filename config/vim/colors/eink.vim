" light theme tailored for the eink display
set background=light
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "eink"

" Base
hi Normal         guifg=#1F2937 guibg=#FFFFFF ctermfg=234 ctermbg=231
hi Cursor         guifg=#FFFFFF guibg=#2563EB ctermfg=231 ctermbg=27
hi CursorLine     guibg=#F4F8FC ctermbg=255
hi CursorColumn   guibg=#F4F8FC ctermbg=255
hi ColorColumn    guibg=#EEF4FA ctermbg=255
hi LineNr         guifg=#94A3B8 guibg=#FFFFFF ctermfg=246 ctermbg=231
hi CursorLineNr   guifg=#0F172A guibg=#F4F8FC gui=bold ctermfg=233 ctermbg=255 cterm=bold
hi SignColumn     guifg=#64748B guibg=#FFFFFF ctermfg=244 ctermbg=231
hi VertSplit      guifg=#D6E0EA guibg=#FFFFFF ctermfg=252 ctermbg=231
hi WinSeparator   guifg=#D6E0EA guibg=#FFFFFF ctermfg=252 ctermbg=231

" Status / tabs
hi StatusLine     guifg=#0F172A guibg=#EAF1F8 gui=bold ctermfg=233 ctermbg=255 cterm=bold
hi StatusLineNC   guifg=#64748B guibg=#F4F7FA ctermfg=244 ctermbg=255
hi TabLine        guifg=#475569 guibg=#F4F7FA ctermfg=239 ctermbg=255
hi TabLineSel     guifg=#0F172A guibg=#E2ECF7 gui=bold ctermfg=233 ctermbg=254 cterm=bold
hi TabLineFill    guibg=#F4F7FA ctermbg=255

" Popup / menu
hi Pmenu          guifg=#1E293B guibg=#F8FBFE ctermfg=234 ctermbg=231
hi PmenuSel       guifg=#0F172A guibg=#DCEBFA gui=bold ctermfg=233 ctermbg=153 cterm=bold
hi PmenuSbar      guibg=#E2E8F0 ctermbg=254
hi PmenuThumb     guibg=#CBD5E1 ctermbg=252

" Search / visual
hi Visual         guifg=NONE guibg=#DCEBFA ctermbg=153
hi Search         guifg=#0F172A guibg=#FFF3BF ctermfg=233 ctermbg=229
hi IncSearch      guifg=#FFFFFF guibg=#2563EB gui=bold ctermfg=231 ctermbg=27 cterm=bold
hi MatchParen     guifg=#0F172A guibg=#CFE3FA gui=bold ctermfg=233 ctermbg=153 cterm=bold

" Messages
hi ErrorMsg       guifg=#991B1B guibg=#FEF2F2 ctermfg=88 ctermbg=224
hi WarningMsg     guifg=#92400E guibg=#FFF7ED ctermfg=94 ctermbg=230
hi ModeMsg        guifg=#0F172A gui=bold ctermfg=233 cterm=bold
hi MoreMsg        guifg=#0F766E ctermfg=30
hi Question       guifg=#0F766E gui=bold ctermfg=30 cterm=bold

" Folds
hi Folded         guifg=#475569 guibg=#F4F7FA ctermfg=239 ctermbg=255
hi FoldColumn     guifg=#94A3B8 guibg=#FFFFFF ctermfg=246 ctermbg=231

" Diff
hi DiffAdd        guifg=#166534 guibg=#ECFDF3 ctermfg=22 ctermbg=194
hi DiffChange     guifg=#1D4ED8 guibg=#EFF6FF ctermfg=25 ctermbg=195
hi DiffDelete     guifg=#B91C1C guibg=#FEF2F2 ctermfg=124 ctermbg=224
hi DiffText       guifg=#1E3A8A guibg=#DBEAFE gui=bold ctermfg=18 ctermbg=153 cterm=bold

" Spelling
hi SpellBad       guisp=#DC2626 gui=undercurl cterm=underline
hi SpellCap       guisp=#2563EB gui=undercurl cterm=underline
hi SpellRare      guisp=#7C3AED gui=undercurl cterm=underline
hi SpellLocal     guisp=#0F766E gui=undercurl cterm=underline

" Syntax
hi Comment        guifg=#64748B gui=italic ctermfg=244
hi Constant       guifg=#7C3AED ctermfg=92
hi String         guifg=#0F766E ctermfg=30
hi Character      guifg=#0F766E ctermfg=30
hi Number         guifg=#9333EA ctermfg=92
hi Boolean        guifg=#9333EA gui=bold ctermfg=92 cterm=bold
hi Float          guifg=#9333EA ctermfg=92

hi Identifier     guifg=#0F172A ctermfg=233
hi Function       guifg=#1D4ED8 gui=bold ctermfg=25 cterm=bold

hi Statement      guifg=#1E40AF gui=bold ctermfg=19 cterm=bold
hi Conditional    guifg=#1E40AF gui=bold ctermfg=19 cterm=bold
hi Repeat         guifg=#1E40AF gui=bold ctermfg=19 cterm=bold
hi Label          guifg=#1E40AF ctermfg=19
hi Operator       guifg=#334155 ctermfg=239
hi Keyword        guifg=#1E40AF gui=bold ctermfg=19 cterm=bold
hi Exception      guifg=#BE123C gui=bold ctermfg=125 cterm=bold

hi PreProc        guifg=#C2410C ctermfg=166
hi Include        guifg=#C2410C ctermfg=166
hi Define         guifg=#C2410C ctermfg=166
hi Macro          guifg=#C2410C ctermfg=166
hi PreCondit      guifg=#C2410C ctermfg=166

hi Type           guifg=#0F3D66 gui=bold ctermfg=24 cterm=bold
hi StorageClass   guifg=#0F3D66 gui=bold ctermfg=24 cterm=bold
hi Structure      guifg=#0F3D66 gui=bold ctermfg=24 cterm=bold
hi Typedef        guifg=#0F3D66 gui=bold ctermfg=24 cterm=bold

hi Special        guifg=#BE185D ctermfg=125
hi SpecialChar    guifg=#BE185D ctermfg=125
hi Tag            guifg=#1D4ED8 ctermfg=25
hi Delimiter      guifg=#475569 ctermfg=239
hi SpecialComment guifg=#0F766E ctermfg=30
hi Debug          guifg=#B91C1C ctermfg=124

hi Underlined     guifg=#1D4ED8 gui=underline ctermfg=25 cterm=underline
hi Ignore         guifg=#94A3B8 ctermfg=246
hi Error          guifg=#991B1B guibg=#FEF2F2 gui=bold ctermfg=88 ctermbg=224 cterm=bold
hi Todo           guifg=#92400E guibg=#FEF3C7 gui=bold ctermfg=94 ctermbg=229 cterm=bold
