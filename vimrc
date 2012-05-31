filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" set nocompatible " Set nocompatible mode on

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

syntax on " Turn on syntax highlighting

" Indent automatically depending on filetype
filetype plugin indent on
set autoindent
set smartindent
set cindent

set ruler " Turn on the ruler
set nu " Turn on line numbering.  Turn it off with "set nonu"
set ic " Case insensitive search
set hls " Highlight search
set incsearch " Show incremental search results
set scs " Smart search - override 'ic' when pattern has uppercase characters
set showcmd " Show incomplete commands in the status area
set showmode " Show current mode in the status area
set lbr " Wrap text instead of being on one line
set tabstop=4 " Number of spaces for tab character
set shiftwidth=4 " Number of spaces for autoindent
set noexpandtab " Don't expand tabs into spaces
set novisualbell " Turn off the visual bell
set ttyfast " Smoother changes
set wrap " wrap lines
set anti " Antialias fonts
set selectmode=mouse,key " Use the mouse for selectmode
set selection=exclusive " Don't include the last character in the selection
set keymodel=startsel,stopsel
set completeopt=longest,menuone " Make completion menu match the longest common text
set switchbuf=usetab,useopen " Make vim open existing tabs/windows if a file is already open rather than opening a new one
set confirm " Prompt to save on destroying buffer with unsaved changes
set updatetime=100 " Set update time to 1/10 second
set wildmenu
set wildmode=list:longest,full
set showbreak=->

set tags=./tags;

" OS Specific
if has("unix")
	" Configuration for both Cygwin and Linux
	set shellcmdflag=-ic " Use an interactive shell for bang(!)
	let g:vimhome = $HOME . "/.vim"
	if has("win32unix")
		" Configuration for Cygwin only
	else
		" Configuration for Linux only
	endif
elseif has("win32")
	" Configuration for Windows-native vim
	"	source $VIMRUNTIME/mswin.vim
	let g:vimhome = $HOME . "/vimfiles"
else
	echoerr "Unknown OS"
endif

" Set mapleader
let mapleader = ";"

" Set statusline
set laststatus=2

set statusline=%f
set statusline+=[%{&ff}]
set statusline+=%{fugitive#statusline()}
set statusline+=%{exists('g:loaded_rvm')?rvm#statusline():''}
set statusline+=%h
set statusline+=%y
set statusline+=%r
set statusline+=%m
set statusline+=%=
set statusline+=%c,
set statusline+=%l/%L
set statusline+=\ %P

let g:netrw_liststyle = 3
let g:jah_Quickfix_Win_Height = 10
let g:ragtag_global_maps = 1

" toggles the quickfix window.
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
	if exists("g:qfix_win") && a:forced == 0
		cclose
	else
		execute "copen " . g:jah_Quickfix_Win_Height
	endif
endfunction

" Jekyll config
let g:jekyll_path = "~/Development/duckpuppy_blog"
let g:jekyll_post_suffix = "md"
let g:jekyll_post_published = "false"

" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
   if &wrap
      return "g" . a:movement
   else
      return a:movement
   endif
endfunction
onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")

if has("autocmd")
	augroup vimrc
		autocmd!
		au FileType ruby setlocal nocindent
		au FileType java setlocal omnifunc=javacomplete#Complete
		au FileType java setlocal completefunc=javacomplete#CompleteParamsInfo
		au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))
		au BufRead,BufNewFile pom.xml set filetype=xml.maven
		" Configure omnicomplete to use syntax completion if no other omnifunc exists
		au FileType *
					\ if &omnifunc == "" |
					\ 	setlocal omnifunc=syntaxcomplete#Complete |
					\ endif
	augroup END

	" used to track the quickfix window
	augroup QFixToggle
		autocmd!
		autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
		autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
	augroup END

endif

" Configure taglist
let Tlist_Show_One_File = 1

"Configure tagbar
let g:tagbar_autofocus = 1
let g:tagbar_expand = 1

" Configure UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="normal"
let g:UltiSnipsSnippetsDir=g:vimhome . "/after/UltiSnips"

" Configure Ruby completion
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
" let g:rubycomplete_rails = 1

" re-indent file
nnoremap <silent> <F4> :call <SID>ReindentFile()<CR>
function! <SID>ReindentFile()
	" Save cursor position
	let l = line(".")
	let c = col(".")

	" Reindent file
	let cmd = "normal!" . "gg=G"
	execute cmd

	" Move cursor back to saved position
	call cursor(l, c)
endfunction

" Key Mappings

" Jekyll
map <leader>jb :JekyllBuild<CR>
map <leader>jn :JekyllPost<CR>
map <leader>jl :JekyllList<CR>

" Make <CTRL>-L hide search hilights
nnoremap <silent> <C-L> :noh<CR><C-L>

" Insert mode cursor movement
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l

" Make <tab> work more intuitively in visual mode
vmap <tab> >g
vmap <s-tab> <gv

" Change the working directory of this buffer to the location of the file in
" the buffer
map <Leader>cd :cd %:p:h<CR>:pwd<CR>

" QuickFix window
nmap <silent> <leader>` :QFix<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>

" Taglist
nnoremap <silent> <F8> :TlistToggle<CR>

" TagBar
nnoremap <silent> <F9> :TagbarToggle<CR>

" Copy filename to the clipboard
if has('win32')
	nmap <silent> ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>:echo '<C-R>*'<CR>
	nmap <silent> ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>:echo '<C-R>*'<CR>
	nmap <silent> ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>:echo '<C-R>*'<CR>
else
	" These copy to both the Gnome and X Server clipboard
	nmap <silent> ,cs :let @*=expand("%")<CR>:echo '<C-R>*'<CR> \| :let @+=expand("%")<CR>
	nmap <silent> ,cl :let @*=expand("%:p")<CR>:echo '<C-R>*'<CR> \| :let @+=expand("%:p")<CR>
endif

nnoremap <C-o> :FufFile<CR>
nnoremap <C-b> :FufBuffer<CR>
nnoremap <silent> <C-e> :NERDTreeToggle<CR>

" Gtags mapping
map <C-\>] :GtagsCursor<CR>

" Capture the output of a command to a new tab
function! Capture (cmd)
	redir => message
	silent execute a:cmd
	redir END
	tabnew
	silent put=message
	set nomodified
endfunction
command! -nargs=+ -complete=command Capture call Capture(<q-args>)

inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" AutoComplPop Configuration
let g:acp_enableAtStartup = 0

" Abbreviations

" Change colorscheme from default to vilight
colorscheme railscasts
