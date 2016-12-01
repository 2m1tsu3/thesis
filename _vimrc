" undoファイルとbackupファイルのディレクトリ指定
set undodir=C:\Users\m4-maruyama\var\vim\undo
set backupdir=C:\Users\m4-maruyama\var\vim\backup


"基本設定（後で調べる）
set number
set ruler
set cmdheight=1
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set title
set wildmenu
set showcmd
set hlsearch
set list
set listchars=tab:>\ ,extends:<
set showmatch
set autoindent
set smartindent
set hidden
highlight LineNr ctermfg=cyan
set cursorline
hi clear cursorline
hi cursorlinenr term=bold cterm=bold ctermfg=cyan ctermbg=NONE
highlight CursorLine ctermbg=237

" colorscheme設定
colorscheme lyla

set nocompatible
filetype off            " for NeoBundle


" vim起動時のみruntimepathにneobundle.vimを追加
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" neobundle.vimの初期化 
" NeoBundleを更新するための設定
call neobundle#begin(expand('~/.vim/bundle'))
" ここから NeoBundle でプラグインを設定します
NeoBundleFetch 'Shougo/neobundle.vim'
" NeoBundle で管理するプラグインを追加します。
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'mattn/emmet-vim'
call neobundle#end()

let g:indent_guides_enable_on_vim_startup = 1

command Tn tabnew

nnoremap f <Nop>
nnoremap fj <C-w>j
nnoremap fk <C-w>k
nnoremap fl <C-w>l
nnoremap fh <C-w>h
nnoremap fJ <C-w>J
nnoremap fK <C-w>K
nnoremap fL <C-w>L
nnoremap fH <C-w>H
nnoremap tl gt
nnoremap th gT

"unite prefix key.
nnoremap [unite] <Nop>
"nmap <Space>f [unite]
nmap f [unite]

"unite general settings
"インサートモードで開始
let g:unite_enable_start_insert = 1
"最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 50

"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"nnoremap <silent> ff :<C-u>VimFiler<CR>
"新規ファイル作成
nnoremap <silent> [unite]n :<C-u>UniteWithBufferDir file file/new -buffer-name=file<CR>
"新規ディレクトリ作成
noremap <silent> [unite]d :<C-u>Unite directory/new<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    "ESCでuniteを終了
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction
" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化する
filetype plugin indent on

" インストールのチェック
NeoBundleCheck
