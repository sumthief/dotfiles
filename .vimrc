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
