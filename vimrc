behave xterm

let java_allow_cpp_keywords=1
let java_highlight_java_lang_ids=1
let java_minlines = 50
let loaded_matchparen = 0
syntax on
source ~/.vim/vimrc
:filetype plugin on

set viminfo='50,\"1000,:100,f0 "see :help viminfo for explanation
set tags=~/.tags

set makeprg=ant\ -find\ build.xml\ compile
set efm=%A\ %#[javac]\ %f:%l:\ %m,%C\ %#[javac]\ symbol\ \ :\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#

set wildmode=list,full

let html_wrong_comments=1
set gp=grep\ -n\ $*
set noexpandtab
set selectmode=mouse
set tabstop=4 report=1
set shiftwidth=4
set visualbell
set incsearch
set noaw ai nows showmode noeb noic nohlsearch nosm wrap

map <M-F1> a => 
map! <M-F1> a<BS> => 
map gg 1G
map gn 1Gn
map r[[ ?def 
map r]] /def 
map <D-j> :e $PR/public/javascripts/application.js
map ß :e $PR/public/stylesheets/tiki.css
map = :e#
map + :e!#
map <D-m> :Rmodel
map <D-c> :Rcontroller
map <D-F1> :Rstylesheet tiki
map <S-F1> ^d0>>j
map <S-F2> ^d0>>>>j
map <S-F3> ^d0>>>>>>j
map <S-F4> ^d0>>>>>>>>j
map <S-F5> ^d0>>>>>>>>>>j
map <S-F6> ^d0>>>>>>>>>>>>j
map <S-F7> ^d0>>>>>>>>>>>>>>j
map N ?
map n /
map <F2> "Ayy
map  0i<!--- A -->j
map <F12> :cn
map  :tabnew
map <D-r> :e $PR/

function! AllBuffer (command)
	let i = 1
	while i <= bufnr("$")
		if bufexists(i)
			execute 'buffer ' . i
			execute a:command
			:w!
		endif
		let i = i + 1
	endwhile
endfunction

command! -nargs=+ -complete=command AllBuffer call AllBuffer(<q-args>)
command! -nargs=+ -complete=command AB call AllBuffer(<q-args>)


vnoremap _> :call CommentifyAutomatic(1)<cr>
vnoremap _< :call CommentifyAutomatic(0)<cr>

function! CommentifyAutomatic(b_comment) range
	" check for c++ like comments first
	"
	echo "suffix = " &ft 

	if "c" == &ft || "cpp" == &ft || "yy" == $ft || "msidl" == &ft  || "java" == &ft || "javascript" == &ft
		let opencomm  = "// "
		let closecomm = "// "
		let midcomm   = "// "
	"elseif "ruby" == &ft
		"let opencomm = "/* "
		"let midcomm = " "
		"let opencomm = "*/ "
	elseif "fortran" == &ft
		" fortran comments
		"
		let opencomm  = "C "
		let closecomm = "C "
		let midcomm   = "C "
	elseif "vim" == &ft
		let opencomm  = "\" "
		let closecomm = "\" "
		let midcomm   = "\" "
	elseif "sql" == &ft
		let opencomm  = "-- "
		let closecomm = "-- "
		let midcomm   = "-- "
	elseif "tex" == &ft
		let opencomm  = "% "
		let closecomm = "% "
		let midcomm   = "% "
	elseif "html" == &ft || "xml" == &ft || "entity" == &ft || "ant" == &ft || "dtd" == &ft
		let opencomm  = "<!--  "
		let closecomm = "  -->"
		let midcomm   = "      "
	elseif "cfm" == &ft
		let opencomm  = "<!---  "
		let closecomm = "  --->"
		let midcomm   = "	"
	"elseif "automake" == &ft || "cfg" == &ft || "sh" == &ft || "conf" == &ft
		"let opencomm  = "# "
		"let closecomm = "# "
		"let midcomm   = "# "
	elseif "dosbatch" == &ft
		let opencomm  = "rem "
		let closecomm = "rem "
		let midcomm   = "rem "
	elseif "config" == &ft
		let opencomm  = "dnl "
		let closecomm = "dnl "
		let midcomm   = "dnl "
	else
		" default is a shell like comment
		" note that this works also for
		" tclsh ...
		"
		let opencomm  = "# "
		let closecomm = "# "
		let midcomm   = "# "
		"let opencomm  = "<!--- "
		"let closecomm = "---> "
		"let midcomm   = "     "
	endif

	call Commentify(a:b_comment, opencomm, closecomm, midcomm, a:firstline, a:lastline)

endfunction

fu! InsertLine ( linenum, linestring )
	exe 'normal' . ":" . a:linenum . "insert\<CR>" . a:linestring . "\<CR>.\<CR>"
endf

fu! AppendLine ( linenum, linestring )
	exe 'normal' . ":" . a:linenum . "append\<CR>" . a:linestring . "\<CR>.\<CR>"
endf

fu! SubstLine ( linenum, pat, rep, flags )
	let thislineStr = getline( a:linenum )
	let thislineStr = substitute( thislineStr, a:pat, a:rep, a:flags )
	call setline( a:linenum, thislineStr )
endf

fu! Commentify ( b_comment, opencomm, closecomm, midcomm, firstln, lastln )
	if a:b_comment
		let midline = a:firstln
		while midline <= a:lastln
			call SubstLine ( midline, '^.*$', a:midcomm . '&', "" )
			let midline = midline + 1
		endwhile
		call InsertLine ( a:firstln, a:opencomm )
		let lastln = a:lastln + 1
		call AppendLine ( lastln, a:closecomm )
	else
		let opencommMatch = escape ( a:opencomm, '*.' )
		let closecommMatch = escape ( a:closecomm, '*.' )
		let midcommMatch = escape ( a:midcomm, '*.' )

		let firstlnStr = getline(a:firstln)
		if ( firstlnStr =~ '^\s*' . opencommMatch . '\s*$' )
			" We're at the top of a block. Remove the line.
			exe 'normal dd'
			let firstline = a:firstln
			let lastline = a:lastln - 1
		elseif ( firstlnStr =~ '^\s*' . midcommMatch )
			" We're in the middle of a block. Add a block-end above and uncomment
			" this line.
			call InsertLine ( a:firstln, a:closecomm )
			call SubstLine ( a:firstln + 1,  '^' . midcommMatch, "", "" )
			let firstline = a:firstln + 2
			let lastline = a:lastln + 1
		else
			" Something weird. Abort.
			echohl Warning Msg | echo "Couldn't apply uncomment." | echohl None
			return -1
		endif

		if ( a:firstln == a:lastln )
			call AppendLine ( lastline, a:opencomm )
			return 0
		else
			let midline = firstline
			while midline < lastline
				call SubstLine ( midline, '^' . midcommMatch, "", "" )
				let midline = midline + 1
			endwhile
		endif

		let lastlnStr = getline(lastline)
		if ( lastlnStr =~ '^\s*' . closecommMatch . '\s*$' )
			" We're at the end of a block. Remove the line.
			exe 'normal' . lastline . 'G'
			exe 'normal dd'
		elseif ( lastlnStr =~ '^\s*' . midcommMatch )
			" We're in the middle of a block. Add a block-start below and uncomment
			" this line.
			call AppendLine ( lastline, a:opencomm )
			call SubstLine ( midline, '^' . midcommMatch, "", "" )
		else
			" Proly the user went past the end of the commented block.
			let midline = firstline
			while midline < lastline
				let midlnStr = getline(midline)
				if ( midlnStr =~ '^\s*' . closecommMatch . '\s*$' )
					" We're at the end of a block. Remove the line.
					exe 'normal' . midline . 'G'
					exe 'normal dd'
					" exe "echo 'line" . line(".") . "removed'"
					return 0
				endif
				let midline = midline + 1
			endwhile
		endif
	endif
endf
