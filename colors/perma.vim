" Vim color file
"
" Language:	Perma
" Maintainer:	Eli Parra <eli@elzr.com>
" Started:  3jan2014
"
" Based on vim's default desert color scheme

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="perma"

hi Normal	guifg=White guibg=Black

"group perma
hi Tab	  			guibg=gray19
hi permaBlockquote guifg=#f1ffa0
hi Note	  			guifg=#f1ffa0 guibg=gray35
	hi permaNoteAlt	guifg=#838a57 gui=bold
hi Section			guibg=#FFD100 guifg=Black

hi permaH1			guibg=#DD58B8 guifg=White
hi permaH2			guibg=#BA489B guifg=White
hi permaH3			guibg=#953A7C guifg=White

hi permaBough1	guifg=white gui=reverse
hi permaBough2 guifg=white gui=reverse
hi permaBough3 guifg=gray70 gui=reverse
hi permaBough4 guifg=gray50 gui=reverse

" to make colors slightly darker at each level (in gui)
hi permaTab7 guibg=gray10
hi permaTab6 guibg=gray15
hi permaTab5 guibg=gray20
hi permaTab4 guibg=gray25
hi permaTab3 guibg=gray30
hi permaTab2 guibg=gray35
hi permaTab1 guibg=gray50

hi permaSeparator guifg=gray40

hi Strong				guifg=#C64646
hi permaStrongAlt		guifg=#793C0B
hi permaStrongHigh	guifg=#C67650
hi Bold					guifg=#FFA0A0
hi permaBoldAlt		guifg=#9B6363
hi permaBoldHigh		guifg=#C67650

hi Em					gui=italic guifg=#F0E68C
hi permaEmAlt		gui=italic guifg=#999449
hi Italic			gui=italic guifg=#A29C48
hi Teg				gui=bold guifg=#5CD121

hi permaNextAction	guifg=#B08E5F
	hi permaNextActionAlt	guifg=#CF7F0E gui=bold
	hi permaNextActionSymbol	guifg=#694E29
hi permaDoneAction	guifg=gray60
	hi permaDoneActionAlt	guifg=gray30 gui=bold
	hi permaDoneActionSymbol	guifg=gray80
hi permaInLink		guifg=#4B7F00 gui=reverse
	hi permaInLinkAlt		guifg=#7db232 gui=reverse 
	"original a2d25e
hi permaCap			guifg=#87d4cb
	hi permaFirstCap			gui=bold guifg=#83c1d4
hi permaQuote			guifg=#e2d2a2
	hi permaQuoteAlt	gui=bold guifg=#9b906f
hi permaPar			guifg=gray60
	hi permaParAlt	guifg=gray30 gui=bold
hi permaParagraphDefined		guifg=gray60
hi permaDefined		gui=underline,bold
	hi permaDefinedAlt		gui=bold
hi permaSymbol			guifg=#ffb69e gui=bold
hi permaUnit			guifg=#7852AF  gui=reverse
	hi permaUnitAlt		guifg=#B6A7DD  gui=standout
	hi permaUnitExp		guifg=#9375bf  gui=standout
	hi permaUnitCreditCard guifg=white  gui=standout
	hi permaDate		guifg=#147380 gui=reverse
		hi permaDateAlt		guifg=#1EAFC2 gui=standout
		hi permaDateEpoch		guifg=#07373D
		hi permaDateDay		guifg=#0D707E
		hi permaDateHour		guifg=#07373D gui=reverse
	hi permaCurrency		guifg=#954CAF gui=reverse
		hi permaCurrencyAlt		guifg=#DDA0DD gui=standout
		hi permaCurrencyExp		guifg=#aa6ec0 gui=reverse
	hi permaCreditCard		guifg=#923854 gui=reverse
	hi permaCreditCardAlt		guifg=#FF6295 gui=reverse
hi permaLocalLink		gui=underline guifg=#C2DFEF
hi permaLink			guifg=#59659F gui=reverse
	hi permaLinkAlt	guifg=#7bc3fb gui=reverse
	hi permaSubReddit	guifg=#7C91EA gui=reverse
	hi permaSubDomain	guifg=#7C91EA gui=reverse
	hi permaPageTitle	guifg=#057CAB  gui=reverse
	hi permaPageClutter	guifg=#057CAB  guibg=#057CAB gui=reverse
hi Conceal guifg=#59659F guibg=Black
hi permaNoPerma guifg=black guibg=white

"endgroup

" highlight groups
hi Cursor	guibg=khaki guifg=slategrey
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
hi VertSplit	guibg=#c2bfa5 guifg=grey50
hi Date	guifg=grey30
hi FoldColumn	guibg=grey30 guifg=tan
hi Folded	guibg=#000000 guifg=grey60
hi IncSearch	guifg=slategrey guibg=khaki
"hi LineNr
hi ModeMsg	guifg=goldenrod
hi MoreMsg	guifg=SeaGreen
hi NonText	guifg=LightBlue guibg=grey30
hi Question	guifg=springgreen
hi Search	guibg=peru guifg=wheat
hi SpecialKey	guifg=yellowgreen
hi StatusLine	guibg=#c2bfa5 guifg=black
hi StatusLineNC	guibg=#c2bfa5 guifg=grey50
hi Title	guifg=indianred
hi Visual	guifg=khaki guibg=olivedrab
"hi VisualNOS
hi WarningMsg	guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip

" mods meant for Javascript -Eli
hi Label	guifg=palegreen
hi Comment	guifg=skyblue
hi Conditional	guifg=#A29C48
"hi Function	guifg=gray60

" syntax highlighting groups
hi Constant	guifg=#ffa0a0
hi Identifier	guifg=palegreen
hi Statement	guifg=khaki
hi PreProc	guifg=indianred
hi Type		guifg=darkkhaki
hi Special	guifg=navajowhite
"hi Underlined
hi Ignore	guifg=grey40
"hi Error
hi Todo		guifg=orangered guibg=yellow2

" color terminal definitions
hi SpecialKey	ctermfg=darkgreen
hi NonText	cterm=bold ctermfg=darkblue
hi Directory	ctermfg=darkcyan
hi ErrorMsg	cterm=bold ctermfg=7 ctermbg=1
hi IncSearch	cterm=NONE ctermfg=yellow ctermbg=green
hi Search	cterm=NONE ctermfg=grey ctermbg=blue
hi MoreMsg	ctermfg=darkgreen
hi ModeMsg	cterm=NONE ctermfg=brown
hi LineNr	ctermfg=3
hi Question	ctermfg=green
hi StatusLine	cterm=bold,reverse
hi StatusLineNC cterm=reverse
hi VertSplit	cterm=reverse
hi Title	ctermfg=5
hi Visual	cterm=reverse
hi VisualNOS	cterm=bold,underline
hi WarningMsg	ctermfg=1
hi WildMenu	ctermfg=0 ctermbg=3
hi DiffAdd	ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=bold ctermfg=4 ctermbg=6
hi DiffText	cterm=bold ctermbg=1
hi Comment	ctermfg=darkcyan
hi Constant	ctermfg=brown
hi Special	ctermfg=5
hi Identifier	ctermfg=6
hi Statement	ctermfg=3
hi PreProc	ctermfg=5
hi Type		ctermfg=2
hi Underlined	cterm=underline ctermfg=5
hi Ignore	cterm=bold ctermfg=7
hi Ignore	ctermfg=darkgrey
hi Error	cterm=bold ctermfg=7 ctermbg=1

"vim: sw=4
