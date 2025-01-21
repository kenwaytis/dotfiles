set mouse=v
set nocompatible "禁用 Vi 兼容模式
set encoding=utf-8
set autoread "当文件在外部被修改时自动重新加载
set cursorline "高亮当前行
set scrolloff=5 "光标距离顶部/底部时保留 5 行
set laststatus=2 "总是显示状态栏
set title
set hlsearch "高亮搜索结果
set expandtab "将 Tab 转换为空格
nnoremap <C-s> :w<CR> "Ctrl+S 保存文件
inoremap <C-s> <Esc>:w<CR> "Ctrl+S 保存文件（插入模式）
set shiftwidth=4 "自动缩进时使用 4 个空格
set sidescrolloff=5 "光标距离左右边缘时保留 5 列
"set number
:filetype plugin on
:syntax on
