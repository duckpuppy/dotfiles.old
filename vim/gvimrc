" OS Specific configuration
if has("gui_macvim") " MacOS
	" Replace default Cmd-T mapping with CommandT
	macmenu &File.New\ Tab key=<nop>
	map <D-t> :CommandT<CR>
elseif has("gui_gtk2") " Gnome
elseif has("x11") " X11
elseif has("gui_win32") " Windows
end

" General
set anti " Antialias fonts

" Default size of window
set lines=50
set columns=100

set guifont=Consolas
set mousehide

" Toggle menu and toolbar
map <silent> <C-F2> :if &guioptions =~# 'T' <Bar> set guioptions-=T <Bar> set guioptions-=m <Bar> else <Bar> set guioptions+=T <Bar> set guioptions+=m <Bar> endif<CR>
