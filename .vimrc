" 文字コード設定
set encoding=utf-8
scriptencoding utf-8

" s:plug.is_installed
let s:plug = {
      \ "plugs": get(g:, 'plugs', {})
      \ }

function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'           " カラースキーム
Plug 'scrooloose/nerdtree'      " ディレクトリツリー
Plug 'jistr/vim-nerdtree-tabs'  " nerdtreeをタブ間で共有
Plug 'itchyny/lightline.vim'    " ステータスラインをいい感じに
Plug 'itchyny/vim-gitbranch'    " ステータスラインにbranchを表示
Plug 'bronson/vim-trailing-whitespace'  " 末尾の不要文字をハイライト
Plug 'Yggdroot/indentLine'      " インデントを見やすく
Plug 'cohama/lexima.vim'        " 対応する括弧等を自動補完
Plug 'Shougo/unite.vim'         " Unite
Plug 'mattn/emmet-vim'          " HTML等の入力を補助 <C-y>,
Plug 'w0rp/ale'                 " lint
Plug 'ConradIrwin/vim-bracketed-paste'  " paste時にautoindentを無効にする
Plug 'airblade/vim-gitgutter'   " HEADとの差分を表示
Plug 'Shougo/unite.vim'         " Unite
Plug 'kmnk/vim-unite-giti'      " Unite git plugin
Plug 'tpope/vim-fugitive'       " vimからgitを使う
if has('lua')
    Plug 'Shougo/neocomplete.vim'      " コードの自動補完
    Plug 'Shougo/neosnippet'           " スニペットの自動補完
    Plug 'Shougo/neosnippet-snippets'  " スニペット集

    "----------------------------------------------------------
    " neocomplete・neosnippetの設定
    "----------------------------------------------------------

    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 2文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 2
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplete#smart_close_popup() . "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()

    " for snippets
    let g:neosnippet#snippets_directory = "~/.vim/snippets"
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
endif

call plug#end()

" plugin設定

" 行末でのみ括弧を補完する
call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '{', 'input': '{'})
call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '(', 'input': '('})
call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '[', 'input': '['})
call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '"', 'input': '"'})
call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': "'", 'input': "'" })
" Tabキーで括弧を抜ける
" call lexima#add_rule({'char': '<TAB>', 'at': '\%#)', 'leave': 1})
" call lexima#add_rule({'char': '<TAB>', 'at': '\%#"', 'leave': 1})
" call lexima#add_rule({'char': '<TAB>', 'at': '\%#''', 'leave': 1})
" call lexima#add_rule({'char': '<TAB>', 'at': '\%#]', 'leave': 1})
" call lexima#add_rule({'char': '<TAB>', 'at': '\%#}', 'leave': 1})

" 末尾スペースのハイライトを無視
let g:extra_whitespace_ignored_filetypes = ['unite', 'gitcommit']

" unite設定
nnoremap <silent> <C-i>g :<C-u>Unite giti<CR>
nnoremap <silent> <C-i><C-g>g :<C-u>Unite giti/grep<CR>
nnoremap <silent> <C-i><C-g>b :<C-u>Unite giti/branch<CR>
nnoremap <silent> <C-i><C-g>s :<C-u>Unite giti/status<CR>
nnoremap <silent> <C-i><C-g>l :<C-u>Unite giti/log<CR>

" INSERTモードでC-[hjkl]で移動できるようにする
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" statusline設定
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示する

colorscheme molokai " カラースキームにmolokaiを設定する
set t_Co=256 " iTerm2など既に256色環境なら無くても良い
syntax enable " 構文に色を付ける

" Ctrl-eでNERDTreeを開閉
nnoremap <silent><C-e> :NERDTreeTabsToggle<CR>
" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set updatetime=100  " vim-gitgutterの更新間隔

set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決
set nocompatible " 方向キーでアルファベットが入力されないようにする

set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅

set hlsearch " 検索結果をハイライト
" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

set number " 行番号を表示
set cursorline " カーソルラインをハイライト

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する
set backspace=indent,eol,start " backspaceが効かない問題

set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

" マウスでのカーソル移動等を可能にする
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

" ペースト時の自動インデントを無効に
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" 存在しないディレクトリなら保存時に作成する
augroup vimrc-auto-mkdir  " {{{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)  " {{{
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}
augroup END  " }}}
