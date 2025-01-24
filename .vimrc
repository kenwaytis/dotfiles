set mouse=v
set nocompatible "禁用 Vi 兼容模式
set encoding=utf-8
set autoread "当文件在外部被修改时自动重新加载
set cursorline "高亮当前行
set scrolloff=5 "光标距离顶部/底部时保留 5 行
set laststatus=2 "总是显示状态栏
set title
set incsearch "实时高亮搜索结果
set hlsearch "高亮搜索结果
set ignorecase "忽略大小写匹配
set smartcase "自动忽略大小写。如果搜索模式中有大写则区分，否则不区分
set expandtab "将 Tab 转换为空格
set tabstop=4
set shiftwidth=4 "自动缩进时使用 4 个空格
set sidescrolloff=5 "光标距离左右边缘时保留 5 列
"set number 行号
filetype on
filetype indent on
:filetype plugin on
:syntax on
set autoindent "继承上一行缩进

nnoremap <C-s> :w<CR> "Ctrl+S 保存文件
inoremap <C-s> <Esc>:w<CR> "Ctrl+S 保存文件（插入模式）
" 更智能的方向键（处理换行）
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" 快速跳转行首行尾
noremap H ^
noremap L $

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" STATUS LINE
" Clear status line when vimrc is reloaded.
set statusline=
" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R
" Use a divider to separate the left side from the right side.
set statusline+=%=
" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
" Show the status on the second to last line.
set laststatus=2
