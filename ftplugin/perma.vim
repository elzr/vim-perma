" Language:	Perma
" Maintainer:	Eli Parra <eli@elzr.com>
" Started:  3jan2014

" folding
set nocursorline
function! PermaCloseFold()
	let b:saveIndent = indent('.')
	let b:saveLine = line('.')
	let b:saveCursor = getpos(".")
	let b:range = 1
	while b:saveIndent < indent(b:saveLine + b:range)
	   let b:range = b:range + 1
	endwhile
	if b:range > 1 
		exec (b:saveLine+1).'s/\(\t\+\)/\1\t/g '.(b:range-1)
		exec 'normal '.(b:saveLine).'G'
		exec 'normal '.(b:range).'gJ'
	else
		echo 'Nothing to fold!'
	endif

	normal ^
	call setpos('.', b:saveCursor)
	unlet b:saveIndent b:saveLine b:range
endfunction

function! PermaOpenFold()
	let b:saveCursor = getpos(".")
	"exec 's/\([^\t]\)\t/\1\r/g'
ruby <<EOF
	l= VIM::evaluate("getline('.')")
	l =~ /^(\t+)/
	rc = ($1 ? $1.count("\t") : 0)+1
	l = ("\t"*(rc-1))+l.sub(/^\t+/,'').gsub(/\t+/) do |tabs|
		c = tabs.count("\t")
		if (c <= rc) or (c-1 == rc)
			rc = c
			tabs.sub(/\t/,"\r")
		else
			tabs.sub(/\t$/,'')
		end
	end
	b = VIM::Buffer.current
	b.line = l
EOF
	exec 'silent! s//\r/g'
	echo 'Open Sesame!'
	call setpos('.', b:saveCursor)
endfunction

function! Clip(line)
	if	a:line <= v:foldend
		return substitute(substitute(getline(a:line),'^\(.\{20\}\)\(.\+\)$','\1...', 'g'), '\t','','g').' | '
	else
		return ''
	end
endfunction

function! PermaFoldText()
	return substitute(v:folddashes,'-','    ','g').'['.(v:foldend-v:foldstart+1).'] '.Clip(v:foldstart).Clip(v:foldstart+1).Clip(v:foldstart+2).Clip(v:foldstart+3).Clip(v:foldstart+4).'... | '.substitute(Clip(v:foldend),' | $','','g')
endfunction

function! SelectFold()
	let b:saveIndent = indent('.')
	let b:saveLine = line('.')
	let b:saveCursor = getpos(".")
	let b:start = 1
	let b:end = 1

	while ((indent(b:saveLine + b:end) - b:saveIndent > -1) || (getline(b:saveLine + b:end) =~ '^$'))
		let b:end = b:end + 1
	endwhile
	while ((indent(b:saveLine - b:start) - b:saveIndent > -1) || (getline(b:saveLine - b:start) =~ '^$'))
		let b:start = b:start + 1
	endwhile

	if getline(b:saveLine + b:end - 1) =~ '^$'
		let b:end = b:end - 1
	endif
	if getline(b:saveLine - b:start) =~ '^$'
		let b:start = b:start - 1
	endif

	if (b:start + b:end) > 1
		exec 'normal '.(b:saveLine + b:end - 1).'G'
		exec 'normal V'.(b:saveLine - b:start).'G'
	else
		echo 'Nothing to fold!'
	endif
	
	unlet b:saveIndent b:saveLine b:start b:end
endfunction
function! ListCWord()
	let b:cWORD = expand('<cWORD>')
	exec "vim /".b:cWORD."/ %"
endfunction
function! BetterDoubleClick()
	let b:cWORD = fnameescape(expand('<cWORD>'))
	if b:cWORD =~ '^http'
		"fnameescape was overescaping symbols
		exec "silent ! open '". shellescape(b:cWORD) . "'"
	elseif b:cWORD =~ '^\(\/\|\~\/\)'
		exec "silent ! qlmanage -p '". b:cWORD."'"
	elseif b:cWORD =~ '^\$\/'
		exec "silent ! qlmanage -p '". substitute(b:cWORD, '^\$', '/Users/sam/projects/else/petra','') ."'"
	elseif b:cWORD =~ '^@\S'
		exec "silent ! open https://twitter.com/'" . substitute(b:cWORD, '@', '', '') . "'"
	elseif b:cWORD =~ '\S@\S'
		exec "silent ! open -a /Applications/Google\\ Chrome.app 'mailto:". b:cWORD."'"
	elseif b:cWORD =~ '\.\(\(co\)\|\(net\)\|\(org\)\|\(gov\)\|\(fm\)\|\(mx\)\|\(fr\)\|\(uk\)\)'
		exec "silent ! open -a /Applications/Google\\ Chrome.app '". shellescape(b:cWORD)."'"
	elseif b:cWORD =~ '\(\<\l\+\(\u\|\d\)\S\+\>\)\|\(\<\u\+\l\+\u\S\+\>\)\|\(#\)'
		exec "normal! " . search('\C' . substitute(b:cWORD, '\(s$\)\|[,.?.:;]', '', 'i')) . "g"
		normal zz
	elseif getline('.')[col('.') - 1] =~ '\t'
		exec "silent call SelectFold()"
	elseif b:cWORD =~ '^(\|)\|{\|}\|\[\|\]$'
		exec 'normal v%'
	else
		normal viw
	endif
	unlet b:cWORD
endfunction
function! OldMiddleClick()
	let b:cWORD = expand('<cWORD>')
	if b:cWORD =~ '\(\<\l\+\(\u\|\d\)\S\+\>\)\|\(\<\u\+\l\+\u\S\+\>\)'
		execute "normal \<C-W>w"
		exec "normal! " . search('\C' . substitute(b:cWORD, 's$', '', 'i')) . "g"
		normal zz
		execute "normal \<C-W>p"
	endif
	unlet b:cWORD
endfunction
function! OpenInGoogle()
	let b:cLINE = getline('.')
	exec "silent ! open -a /Applications/Google\\ Chrome.app 'http://www.google.com/search?q=". substitute(b:cLINE,' ','+','') ."'"
	unlet b:cLINE
endfunction
map <buffer> <2-LeftMouse> :call BetterDoubleClick()<CR>

"LEADER commands
map <leader>k :call BetterDoubleClick()<CR>
map <leader>g :call OpenInGoogle()<CR>
nmap <buffer> <leader>o :call PermaOpenFold()<CR>
nmap <buffer> <leader>c :call PermaCloseFold()<CR>
"search for a pattern at the beginning of a line ignoring special symbols like ;_*
map <Leader><Space> /^;*#*_*\**\s*
map <leader>c :call ListCWord()<CR>
nmap <leader>s :set noscb<CR>:set nowrap<CR>0<C-W>v<C-W>lz+:set scb<CR><C-W>h:set scb<CR><C-W>lM
nmap <Leader>q :syn off<CR>:syn on<CR>

" initial marking
" delete initial @s
"nmap <leader>1 mzV:s/^\t*\zs@\+ \+//<CR>`z
nmap <leader>1 mz^dw`z
" prepend @ with space
nmap <leader>2 mzI@ <Esc>`z
" prepend # with space
nmap <leader>3 mzI# <Esc>`z
" dupicate an initial char 
nmap <leader>4 mz^ylp<Esc>`z

" pasting that doesn't move you all the way to the right when pasting long
" strings
nmap <leader>v mz"*p<Esc>`z

"nmap <leader>. :cope 40<CR>
"map <leader>, :vimgrep /\c/ %<left><left><left>
"imap <Leader>, <Esc>viW<Esc>dBxgEa

" misc
"set foldtext=PermaFoldText()

"normal zR
set showbreak=\ \ \ \ 
setlocal fillchars=
map <BS> viW<Esc>dBxgE

"setlocal foldmethod=indent
au BufWinLeave <buffer> mkview
au BufWinEnter <buffer> silent loadview
set cole=2

nmap <D-Left> <C-W>t
nmap <D-Right> <C-W><Right>

"nmap <D-1> <C-W>t
"nmap <D-2> <C-W><Right>
"nmap <D-3> <C-W>b
"nmap <D-0> <C-W>b
"stop annoying K from calling up the manual:
map K k 

set nonumber "no number lines

"CommandT settings
lcd ~/Dropbox/prjcts/tools/perma
colors perma

"show folder besides filename (if folder adds to pwd) in tab
set guitablabel=%f
