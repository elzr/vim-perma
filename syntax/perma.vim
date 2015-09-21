" Vim syntax file
"
" Language:	Perma
" Maintainer:	Eli Parra <eli@elzr.com>
" Started:  3jan2014
"
"
syntax clear

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'perma'
endif

syn case match
syn sync minlines=50
syn sync maxlines=1
set synmaxcol=3000

syn match permaSymbol '&rarr;' contained conceal cchar=→
syn match permaSymbol '&larr;' contained conceal cchar=←

syn match permaCap /\v<\u[^ []*>/
	syn cluster PermaCapCluster contains=permaCap

syn match permaUnit /[^( \t[]*#\?\d\+\([^ \)_\t;\]]*[^ ,.;*\)_?\t:\]]\)\?%\?/
	syn cluster PermaUnitCluster contains=permaUnit,permaUnitAlt,permaUnitExp,permaCurrency,permaDate
	syn match permaUnitAlt /\v\d|,|\.+/ containedin=@PermaUnitCluster contained
	syn match permaUnitExp /\d\zs\(e\d\+\)\|\(mil\)/ containedin=@PermaUnitCluster contained
	syn match permaDate /\v\c\S*(msi|min|day|week|month|year|epoch|jan|feb|mar|may|apr|jun|june|jul|aug|sep|oct|nov|dec|ene|feb|mar|abr|ago|dic|mon|tue|wed|thu|fri|sat|sun)[^ ,.*\)_\t]*/ containedin=@PermaUnitCluster contains=@PermaDateCluster contained
		syn cluster PermaDateCluster contains=permaDateAlt,permaDateTrailingPunctuation,permaDateEpoch,permaDateHour,permaDateDay
		syn match permaDateAlt /\v\d|\.+/ containedin=@permaDate contained
		syn match permaDateTrailingPunctuation /\v(\,|\.|\*)$/ containedin=@permaDate contained
		syn match permaDateEpoch /\v(-\d+epoch)|(epoch:\d+)/ containedin=@permaDate contained
		syn match permaDateDay /\v-\d{1,3}d-/ containedin=@permaDate contained
		syn match permaDateHour /\v\d{1,2}h\d{1,2}m\d{1,2}s\d{1,3}ms-?\dutc/ containedin=@permaDate contained
	syn match permaCurrency /\v\c\S*(\$|mxn|pesos?|gbp|aud|chf|btc|ltc|cny|czk|sek|eur|usd|jpy|thb)([^ ;*\)_\t\]!?]*[^ ,.;*\)_\t\]!?])?/ containedin=@PermaUnitCluster contains=@PermaCurrencyCluster contained
		syn cluster PermaCurrencyCluster contains=permaCurrencyAlt,permaCurrencyExp,permaCurrencyTrailingPunctuation
		syn match permaCurrencyExp /\(e\d\+\)\|\(mil\)/ containedin=@permaCurrency contained
		syn match permaCurrencyAlt /\v\d|,|\.+/ containedin=@permaCurrency contained
		syn match permaCurrencyTrailingPunctuation /\v(\,|\.)$/ containedin=@permaCurrency contained
	"syn match permaUnitNum /\d\zs\(\d\d\d\d\)\ze\(\d\d\d\d\)*\(\D\|\>\)/ containedin=@PermaUnitCluster contained

syn match permaCreditCard /\v<((\d{4}\s\d{4}\s\d{4}\s\d{4})|(\d{16}))>/ contains=permaCreditCardAlt
	syn match permaCreditCardAlt /\(\d\{4} \?\)\zs\d\{4}/ containedin=@permaCreditCard contained


"Date/Time variants
	syn match permaDateYear /\v-?<(18|19|20)\d{2}s?>/
	syn match permaDateHour /\v<\d{1,2}:\d{2}(:\d{2})?>/ contains=@PermaDateCluster
	syn match permaDateHourAmPm /\v-?\~?<\d{1,2}(am|pm)(\d{2})?>/ contains=@PermaDateCluster
	syn match permaDateHourHM /\v-?\~?<\d{1,2}(h|m)(\d{2}m?)?>/ contains=@PermaDateCluster
	syn match permaDateSlashed /\v<\d{1,2}\/\d{1,4}(\/\d{2,4})?>/ contains=@PermaDateCluster
	syn match permaDateDayMonthPhrase /\v\c(\d{1,2} (de )?)<(enero|febrero|marzo|abril|mayo|junio|julio|agosto|septiembre|octubre|noviembre|diciembre|aniversario|january|february|march|may|june|july|august|september|october|november|december)>( del )?( <(18|19|20)\d{2}>)?/ contains=@PermaDateCluster
	syn match permaDateAgo /\v\c\d{1,2}\s*(year|month|day|hour|second)s? ago/ contains=@PermaDateCluster
	syn match permaDateYearMonth /\v\c<(18|19|20)\d{2}> <(enero|febrero|marzo|abril|mayo|junio|julio|agosto|septiembre|octubre|noviembre|diciembre|january|february|march|april|may|june|july|august|september|october|november|december|jan|feb|mar|apr|jun|jul|aug|sep|nov|dec|ago)>/ contains=@PermaDateCluster
	syn match permaDateMonthYear /\v\c<(enero|febrero|marzo|abril|mayo|junio|julio|agosto|septiembre|octubre|noviembre|diciembre|january|february|march|april|may|june|july|august|september|october|november|december|jan|feb|mar|apr|jun|jul|aug|sep|nov|dec|ago)> <(18|19|20)\d{2}>/ contains=@PermaDateCluster
	syn match permaDateMonthDay /\v\c<(enero|febrero|marzo|abril|mayo|junio|julio|agosto|septiembre|octubre|noviembre|diciembre|january|february|march|april|may|june|july|august|september|october|november|december|jan|feb|mar|apr|jun|jul|aug|sep|sept|nov|dec|ago)>\.? <\d{1,2}(th|st)?>(,? <(18|19|20)\d{2}>)?/ contains=@PermaDateCluster
	syn match permaDateTime /\v<\d{4}\-\d{2}[\d:+-\u]+>/ contains=@PermaDateCluster "example: 2014-12-04T23:12:02+00:00
		
"camelCaseLinks
syn match permaInLink /\(\<\d*\l\+\u[0-9A-Za-zñÑ]\+\)/
		"forget about inlinks that start with an uppercase, they're probably
		"noise \|\(\<\u\+\l\+\u\w\+\)
	syn cluster PermaInLinkCluster contains=permaInLink
	"exceptions
	syn match permaInLinkNo /\v(iPhone|iOS|iMac|iTunes|iLife|iMac|iBook|iPad|eBay|iPod)/ containedin=@PermaInLinkCluster contained
	syn match permaInLinkAlt /\l\+\zs\(\u\|\d\)\(\l\+\|\u\+\)/ containedin=@PermaInLinkCluster contained
	syn match permaInLinkAlt /\C\l\+\zs\(A\|I\|Y\)\ze\u\+/ containedin=@PermaInLinkCluster contained
	syn match permaInLinkAlt /\d\+/ containedin=@PermaInLinkCluster contained
	syn match permaInLinkAlt /\C\(A\|I\|Y\)\zs\u\l\+/ containedin=@PermaInLinkCluster contained
syn match permaHashtag `\(\_^\|\s*\)\zs#\a\w\+` contains=@PermaHashtagCluster
	syn cluster PermaHashtagCluster contains=permaHashtagAlt
		syn match permaHashtagAlt /[^#]/ containedin=@PermaHashtagCluster contained

					
syn match permaPar /\(([^\)]\+)\)/ contains=@PermaFormatTags
syn match permaPar /\-\-[^.]\{-1,}\(\(\-\-\)\|\.\|?\)/ contains=@PermaFormatTags
syn match permaPar /\s\+-[^\d-][^.]\{-1,}\(\(-\s\+\)\|\.\|?\)/ contains=@PermaFormatTags
syn match permaPar /\s\+–[^\d–][^.]\{-1,}\(\(–\s\+\)\|\.\|?\)/ contains=@PermaFormatTags "another special kind of dash
syn match permaPar /\<\w\+\zs\.\l\+\>/ contains=@PermaFormatTags "filetype lowlighting
"syn match permaPar /\s\+-[^\d*_.][^.*_]\{-1,}[^.:!?]$/ contains=@PermaFormatTags "for quotes ending in -author
syn match permaPar /\s\+(—|–)\D[^.]\{-1,}\(\(—\s\+\)\|\.\|?\)/ contains=@PermaFormatTags "special kind of dash char
	syn cluster PermaParCluster contains=permaPar
	syn match permaParAlt /(\|)\|—\|\-/ containedin=@PermaParCluster contained
syn match permaMath /\(:\|+\|\*\|=\|<\|>\|-\|\(=!\)\|\(\~=\)\|\(=\~\)\|\/\)\(\s\|$\)/
syn match permaSeparator /|/

syn match permaQuote /\(“[^”]\+”\)\|\("[^"]\+"\)/ contains=@PermaFormatTags
	syn cluster PermaQuoteCluster contains=permaQuote
	syn match permaQuoteAlt /"\|“\|”/ containedin=@PermaQuoteCluster contained
syn region permaFold start=/[^\t]\@<=\t\+[^\t]/ end=/$/ display oneline
syn cluster PermaFormatTags contains=permaLink,permaImage,permaEm,permaStrong,permaItalic,permaBold,permaCode,permaSubtext,permaSupertext,permaCitation,permaSection,permaInserted,permaSpan,permaNoPerma,permaGlyph,permaAcronym,permaHtml,permaInLink,permaPar,permaHashtag,permaAtAddress,permaQuote,permaUnit,permaDateYear,permaDateHour,permaDateHourAmPm,permaDateHourHM,permaDateSlashed,permaDateDayMonthPhrase,permaDateYearMonth,permaDateAgo,permaDateMonthYear,permaDateMonthDay,permaDateTime,permaFootnote
syn cluster PermaTabs contains=permaTab1,permaTab2,permaTab3,permaTab4,permaTab5,permaTab6,permaTab7
syn cluster PermaEmTags contains=permaEm,permaItalic

syn region permaEm oneline matchgroup=PermaWhatever start=/\w\@<!_\s\@!/ end=/\s\@<!_\w\@!/ concealends
	syn cluster PermaEmCluster contains=permaEm
	syn match permaEmAlt /\(:\||\|-\|–\)\s\+\S[^._||]\+/ containedin=@PermaEmCluster contained
	syn match permaEmAlt /([^\)]\+)/ containedin=@PermaEmCluster contained
syn region permaItalic oneline matchgroup=PermaWhatever start=/\w\@<!__\s\@!/ end=/\s\@<!__\w\@!/ concealends

syn region permaStrong oneline matchgroup=PermaWhatever start=/\w\@<!\*\s\@!/ end=/\s\@<!\*\w\@!/ concealends contains=@PermaFormatTags
	syn cluster PermaStrongCluster contains=permaStrong
	syn match permaStrongAlt /:\zs\s\+\S[^.*]\+\ze[")]?/ containedin=@PermaStrongCluster contained contains=@PermaEmTags
	syn match permaStrongAlt /([^\)]\+)/ containedin=@PermaStrongCluster contained
	syn match permaStrongAlt /\[[^\]]\+\]/ containedin=@PermaStrongCluster contained
	syn match permaStrongHigh /\(\"\|“\)[^\"”*]\+\(\"\|”\)/ containedin=@PermaStrongCluster contained
	syn match permaStrongAlt /\-\-[^.]\{-1,}\(\(\-\-\)\|\.\|?\)/ containedin=@PermaStrongCluster contained "copied from permaPar
		syn match permaStrongAlt /\s\+-[^.]\{-1,}\(\(-\s\+\)\|\.\|?\)/ containedin=@PermaStrongCluster contained
		syn match permaStrongAlt /\s\+–[^\d–][^.]\{-1,}\(\(–\s\+\)\|\.\|?\)/ containedin=@PermaStrongCluster contained "another special kind of dash
		syn match permaStrongAlt /\s\+-[^*_.-]\{-1,}[^.!?]\ze[*_]*$/ containedin=@PermaStrongCluster contained "for quotes ending in -author
syn region permaBold oneline matchgroup=PermaWhatever start=/\w\@<!\*\*\s\@!/ end=/\s\@<!\*\*\w\@!/ concealends  contains=@PermaFormatTags
	syn cluster PermaBoldCluster contains=permaBold
	syn match permaBoldAlt /:\zs\s\+\S[^.]\+\ze[")]?/ containedin=@PermaBoldCluster contained contains=@PermaEmTags
	syn match permaBoldAlt /([^\)]\+)/ containedin=@PermaBoldCluster contained
	syn match permaBoldAlt /\[[^\]]\+\]/ containedin=@PermaBoldCluster contained
	syn match permaBoldHigh /\(\"\|“\)[^\"”*]\+\(\"\|”\)/ containedin=@PermaBoldCluster contained
	syn match permaBoldAlt /\-\-[^.]\{-1,}\(\(\-\-\)\|\.\|?\)/ containedin=@PermaBoldCluster contained "copied from permaPar
		syn match permaBoldAlt /\s\+-[^.]\{-1,}\(\(-\s\+\)\|\.\|?\)/ containedin=@PermaBoldCluster contained
		syn match permaBoldAlt /\s\+–[^.–]\{-1,}\(\(–\s\+\)\|\.\|?\)/ containedin=@PermaBoldCluster contained  "another special kind of dash
		syn match permaBoldAlt /\s\+-[^*._]\{-1,}[^.!?]\ze[*_]*$/ containedin=@PermaBoldCluster contained "for quotes ending in -author

syn region permaCode oneline matchgroup=permaFormatTag start=/\w\@<!@\s\@!/ end=/\s\@<!@\w\@!/
syn region permaSubtext oneline matchgroup=permaFormatTag start=/\w\@<!\~\s\@!/ end=/\s\@<!\~\w\@!/
syn region permaSupertext oneline matchgroup=permaFormatTag start=/\w\@<!\^\s\@!/ end=/\s\@<!\^\w\@!/
syn region permaCitation oneline matchgroup=permaFormatTag start=/\w\@<!??\s\@!/ end=/\s\@<!??\w\@!/
syn region permaInserted oneline matchgroup=permaFormatTag start=/\w\@<!+\s\@!/ end=/\s\@<!+\w\@!/

syn region permaTeg oneline matchgroup=permaFormatTag start=/\w\@<!\[\[\s\@!/ end=/\s\@<!\]\]\w\@!/ contains=@PermaFormatTags
syn match permaHtml /<\/\=\w[^>]*>/
syn match permaHtml /&\w\+;/

syn region permaNoPerma matchgroup=permaTag start="<noperma>" end="</noperma>"
syn region permaNoPerma oneline matchgroup=PermaWhatever start=/`/ end=/`/

syn match permaTab /\n\n\n\s*\S*/ contains=@PermaFormatTags

" vortoj
" syn match permaVortoj /^.\{-1,}\ze (/
" syn match permaParenthesis /(\zs.\{-1,}\ze)/

" perma
" The default highlighting.
if version >= 508 || !exists("did_perma_syn_inits")
" don't use standard HiLink, it will not work with included syntax files
	if version < 508
		command! -nargs=+ PermaHiLink hi link <args>
	else
		command! -nargs=+ PermaHiLink hi def link <args>
	endif

  if version < 508
    let did_perma_syn_inits = 1
  endif
  
  PermaHiLink permaTag Statement
  "PermaHiLink permaFormatTag Normal
  "PermaHiLink permaNoPerma Normal
  
  PermaHiLink permaEm Em
  PermaHiLink permaItalic Italic
  PermaHiLink permaStrong Strong
  PermaHiLink permaBold Bold
  PermaHiLink permaTeg Teg

  PermaHiLink permaMath permaSymbol
  PermaHiLink permaDefinedAlt permaSymbol

  PermaHiLink permaEmail permaLink
  PermaHiLink permaAtAddress permaLink
  PermaHiLink permaHashtag permaInLink
  PermaHiLink permaShortLink permaLink

  PermaHiLink permaShortLinkAlt permaLinkAlt
  PermaHiLink permaEmailAlt permaLinkAlt
  PermaHiLink permaHashtagAlt permaInLinkAlt
  PermaHiLink permaAtAddressAlt permaLinkAlt

  PermaHiLink permaVortoj Bold
  PermaHiLink permaParenthesis Italic

  PermaHiLink permaFootnote permaPar

  PermaHiLink permaCode Identifier
  PermaHiLink permaSection Section
  PermaHiLink permaFrag Frag
  PermaHiLink permaTab Tab

  PermaHiLink permaSubtext String
  PermaHiLink permaSupertext String
  PermaHiLink permaCitation String
  PermaHiLink permaInserted permaUnderline

  PermaHiLink permaNote Note
  PermaHiLink permaTest Test
  
  "PermaHiLink permaSpan Normal
  PermaHiLink permaFormatTagSpan permaTag

  PermaHiLink permaH Title
  PermaHiLink permaHTag permaTag
  PermaHiLink permaP Normal
  PermaHiLink permaPTag permaTag
  PermaHiLink permaBQ Normal
  PermaHiLink permaBQTag permaTag
  PermaHiLink permaListDot Special
  "PermaHiLink permaTable Normal
  PermaHiLink permaTableTag permaTag

  PermaHiLink permaKeyword Special
  PermaHiLink permaArg Type
  PermaHiLink permaClass Statement
  PermaHiLink permaLang String
  PermaHiLink permaIndent String
  PermaHiLink permaArgError Error
  PermaHiLink permaBrace Special
  PermaHiLink permaRestOfBlock Number

  PermaHiLink permaDateDayMonthPhrase permaDate
  PermaHiLink permaDateSlashed permaDate
  PermaHiLink permaDateHour permaDate
  PermaHiLink permaDateHourAmPm permaDate
  PermaHiLink permaDateHourHM permaDate
  PermaHiLink permaDateYearMonth permaDate
  PermaHiLink permaDateAgo permaDate
  PermaHiLink permaDateMonthYear permaDate
  PermaHiLink permaDateMonthDay permaDate
  PermaHiLink permaDateTime permaDate
  PermaHiLink permaDateYear permaDateAlt

  "PermaHiLink permaLink Underlined
  PermaHiLink permaLinkName String
  PermaHiLink permaLinkColon permaBrace
  PermaHiLink permaLinkURL Underlined
  PermaHiLink permaLinkFile permaLink

  PermaHiLink permaLinkLastPath permaLinkPageTitle


  PermaHiLink permaImage Statement
  PermaHiLink permaImageURL permaLink
  PermaHiLink permaImageTitle String

	PermaHiLink permaGlyph Special
	PermaHiLink permaHR Title
	PermaHiLink permaAcronym String
	PermaHiLink permaAcronymTag Special

	PermaHiLink permaHtml Special

  
  if !exists("html_no_rendering")
    if !exists("perma_my_rendering")
      hi def permaMakeBold            term=bold cterm=bold gui=underline
      hi def permaBoldUnderline       term=bold,underline cterm=bold,underline gui=bold,underline
      hi def permaBoldItalic          term=bold,italic cterm=bold,italic gui=bold,italic
      hi def permaBoldUnderlineItalic term=bold,italic,underline cterm=bold,italic,underline gui=bold,italic,underline
      hi def permaUnderline           term=underline cterm=underline gui=underline
      hi def permaUnderlineItalic     term=italic,underline cterm=italic,underline gui=italic,underline
      hi def permaMakeItalic          term=italic cterm=italic gui=italic
    endif
  endif

endif

let b:current_syntax = "perma"

if main_syntax == 'perma'
  unlet main_syntax
endif

" indenthl.vim: hilights each indent level in different colors.
" Author: Dane Summers
" Date: Feb 15, 2007
" Version: 2

syn match permaTab1 /^\t/
syn match permaTab2 /\(^\t\)\@<=\t/
syn match permaTab3 /\(^\t\{2}\)\@<=\t/
syn match permaTab4 /\(^\t\{3}\)\@<=\t/
syn match permaTab5 /\(^\t\{4}\)\@<=\t/
syn match permaTab6 /\(^\t\{5}\)\@<=\t/
syn match permaTab7 /\(^\t\{6}\)\@<=\t\+/

"syn region permaListField1 oneline start=/^/ end=/[^\|]\+\ze|/
"syn region permaListField2 oneline start=/\(^[^\|]\+|\)\@<=/ end=/[^\|\t]\+\ze|/

command! -nargs=+ HiLink hi def <args>

syn match permaBough1 /^[^:.]\{1,200}\ze\:$/ contains=@PermaFormatTags
"trying to extend it to decimals in digits
"/\([^:.]\)\|\([^:.]*\d\.[ \d]?[^:.]*\)\ze\:/"
syn match permaBough2 /^\t[^:.\t]\{1,200}\ze\:$/ contains=@PermaFormatTags
syn match permaBough3 /^\t\{2}[^:.\t]\+\ze\:$/ contains=@PermaFormatTags
syn match permaBough4 /^\t\{3}[^:.\t]\+\ze\:$/ contains=@PermaFormatTags

"HiLink permaListField1 gui=bold guifg=#f59600
"HiLink permaListField2 guifg=#e4ca19
HiLink permaFold guifg=gray60

"cool line color fading but unfortunately it seems to slow things too much
"syn match permaAfterTab2 /\(^\t\{2}\)\@<=[^\t].*$/
"syn match permaAfterTab3 /\(^\t\{3}\)\@<=[^\t].*$/
"syn match permaAfterTab4 /\(^\t\{4}\)\@<=[^\t].*$/
"syn match permaAfterTab5 /\(^\t\{5}\)\@<=[^\t].*$/
"syn match permaAfterTab6 /\(^\t\{6}\)\@<=[^\t].*$/
"syn match permaAfterTab7 /\(^\t\{7,}\)\@<=[^\t].*$/
"HiLink permaAfterTab2 guifg=gray90
"HiLink permaAfterTab3 guifg=gray80
"HiLink permaAfterTab4 guifg=gray70
"HiLink permaAfterTab5 guifg=gray60
"HiLink permaAfterTab6 guifg=gray50
"HiLink permaAfterTab7 guifg=gray40

syn match permaDate /\/\d\{10}$/

"Sections
syn region permaSection oneline matchgroup=permaFormatTag contains=@PermaInLinkCluster start=/^\s*;/ end=/$/
syn region permaH1 oneline matchgroup=permaFormatTag contains=@PermaInLinkCluster start=/^\s*#\s\+/ end=/$/
syn region permaH2 oneline matchgroup=permaFormatTag contains=@PermaInLinkCluster start=/^\s*##\s\+/ end=/$/
syn region permaH3 oneline matchgroup=permaFormatTag contains=@PermaInLinkCluster start=/^\s*###\s\+/ end=/$/

syn match permaBlockQuote /^\s*>.*/ contains=@PermaFormatTags
syn match permaNote /\[[^\]]\+\]/ contains=@PermaFormatTags
	syn cluster PermaNoteCluster contains=permaNote
	syn match permaNoteAlt />\|\[\|\]/ containedin=@PermaNoteCluster contained
syn match permaFootnote /\[\d\+\]/

syn region permaLocalLink oneline contains=@PermaTabs start=`\(^\|\t\+\)\(/\S\|\~\/\|\$\/\)` end=/\ze \|$/
syn region permaLocalLink oneline start=` \zs\(/\{1}\|\~\/\|\$\/\)` end=/\ze \|$/

syn match permaLink /\w\@<!https\?:\/\/\S\+\v(\/|\a|\d|\?|\=|\#|\&|\!)\ze(\s|\_$|\))/ contains=@PermaLinkCluster
	syn cluster PermaLinkCluster contains=permaLinkAlt,permaStartLink,permaMiddleLink,permaEndLink,permaSubReddit,permaSubDomain,permaLinkTrailingSlash
		syn match permaMiddleLink /\v(\/r\/[^\/]+)?\zs\/[^ \t\.]*\ze\/[^ \_$]/ containedin=@PermaLinkCluster transparent conceal
			syn match permaSubReddit /\/r\/\zs[^\/]\+\ze\// containedin=@PermaLinkCluster contained
		syn match permaLinkAlt `\v(\w|-)+\ze((\.((com?)|net|org|gov|edu|ac|info|me|name)(\.\a\a)?)|(\.\a\a))( |\_$|/)` containedin=@PermaLinkCluster contained
		syn match permaSubDomain /\v[^.\/ ]+\ze\.[^.\/ ]+\./ containedin=@PermaLinkCluster contained
		"syn match permaLinkTrailingSlash /\/\ze\(.*\/\)\@!.*$/ containedin=@PermaLinkCluster contained transparent conceal
			"had to resort to a lot of complexity to really get the last slash! http://stackoverflow.com/questions/13302500/how-to-go-to-the-last-match-of-a-vim-search-pattern
		syn match permaStartLink /\v([^\/ ]+\/\/)|(www\.)/ containedin=@PermaLinkCluster transparent conceal contained
		syn match permaEndLink /\/\zs[^\/ \t]\+\ze\/\?\(\_$\|\>\)/ containedin=@PermaLinkCluster transparent contains=@PermaPageCluster contained
			syn cluster PermaPageCluster contains=permaPageParam,permaPageTitle,permaPageClutter,permaPageSpace,permaPageExtension,permaPageTrailingSlash
				"syn match permaPageSpace /[-_+]/ containedin=@PermaPageCluster contained
				syn match permaPageClutter /[^a-zA-Z0-9\/]/ containedin=@PermaPageCluster contained
				syn match permaPageParam /[\/]\zs?.\+/ containedin=@PermaPageCluster contained conceal cchar=?
				syn match permaPageExtension /\.\a\+/ containedin=@PermaPageCluster transparent contained conceal
				syn match permaPageTitle `\v\w+\/?` containedin=@PermaPageCluster contained
syn match permaLinkFile /\v<[^\/ ]+\.(jpg|png|gif|mov)>/

syn match permaShortLink `[\w\_]\@<!\v[^/\@ \t_][^/\@ \t]*\.((com?)|net|org|gov|edu|ac)(\.\a\a)?[^, \t]*` contains=@PermaLinkCluster
syn match permaEmail `\S\+\w@\w\+\.\w\S\+` contains=@PermaEmailCluster
	syn cluster PermaEmailCluster contains=permaEmailAlt
		syn match permaEmailAlt /\S\+\ze@/ containedin=@PermaEmailCluster contained
syn match permaAtAddress `\(\_^\|\s*\)\zs@\w\+` contains=@PermaAtAddressCluster
	syn cluster PermaAtAddressCluster contains=permaAtAddressAlt
		syn match permaAtAddressAlt /[^@]/ containedin=@PermaAtAddressCluster contained

syn match permaNextAction /@ \S.*$/ contains=@PermaNextActionCluster
	syn cluster PermaNextActionCluster contains=permaNextAction
	syn match permaNextActionAlt /@ \S\+/ containedin=@PermaNextActionCluster contained
syn match permaDoneAction /@@ \S.*$/ contains=@PermaDoneActionCluster
	syn cluster PermaDoneActionCluster contains=permaDoneAction
	syn match permaDoneActionAlt /@@ \S\+/ containedin=@PermaDoneActionCluster contained

syn match permaParagraphDefined /\(:\)\s\S[^.:]\+\(\.\|?\|$\|!\)/ contains=@PermaFormatTags
"syn match permaDefined /\v[^.:\=_\t@ ]{-1,}\s*(\:|\=)(\s|$)/ contains=@PermaFormatTags
	"syn cluster PermaDefinedCluster contains=permaDefined
	"syn match permaDefinedAlt /\v \ze(\:|\=)/ containedin=@PermaDefinedCluster contained
