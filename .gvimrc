
" Remove highlight after search by entering CR
nnoremap <CR> :noh<CR><CR>

" Vundle related config part
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Snippets
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
" NERDTree
Bundle 'scrooloose/nerdtree'
" NERDCommenter
Bundle 'scrooloose/nerdcommenter'

call vundle#end()
filetype plugin indent on
" End Vundle related config part

" Don't work by default.
let mapleader = "\\"
set hidden
let NERDTreeMinimalUI=1

" Mappings for NERDTree plugin.
nmap <A-1> :NERDTreeToggle<CR>
imap <A-1> <ESC>:NERDTreeToggle<CR>
map <A-1> :NERDTreeToggle<CR>

" Mappings for NERDComment plugin.
nmap <A-c> :call NERDComment(0, 'toggle')<CR>
vmap <A-c> :call NERDComment(0, 'toggle')<CR>
imap <A-c> <ESC> :call NERDComment(0, 'toggle')<CR>

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.php call UpdateTags()
