" undo�t�@�C����backup�t�@�C���̃f�B���N�g���w��
set undodir=C:\Users\m4-maruyama\var\vim\undo
set backupdir=C:\Users\m4-maruyama\var\vim\backup


"��{�ݒ�i��Œ��ׂ�j
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

" colorscheme�ݒ�
colorscheme lyla

set nocompatible
filetype off            " for NeoBundle


" vim�N�����̂�runtimepath��neobundle.vim��ǉ�
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" neobundle.vim�̏����� 
" NeoBundle���X�V���邽�߂̐ݒ�
call neobundle#begin(expand('~/.vim/bundle'))
" �������� NeoBundle �Ńv���O�C����ݒ肵�܂�
NeoBundleFetch 'Shougo/neobundle.vim'
" NeoBundle �ŊǗ�����v���O�C����ǉ����܂��B
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
"�C���T�[�g���[�h�ŊJ�n
let g:unite_enable_start_insert = 1
"�ŋߊJ�����t�@�C�������̕ۑ���
let g:unite_source_file_mru_limit = 50

"file_mru�̕\���t�H�[�}�b�g���w��B��ɂ���ƕ\���X�s�[�h�������������
let g:unite_source_file_mru_filename_format = ''

"���݊J���Ă���t�@�C���̃f�B���N�g�����̃t�@�C���ꗗ�B
"�J���Ă��Ȃ��ꍇ�̓J�����g�f�B���N�g��
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"nnoremap <silent> ff :<C-u>VimFiler<CR>
"�V�K�t�@�C���쐬
nnoremap <silent> [unite]n :<C-u>UniteWithBufferDir file file/new -buffer-name=file<CR>
"�V�K�f�B���N�g���쐬
noremap <silent> [unite]d :<C-u>Unite directory/new<CR>
"�o�b�t�@�ꗗ
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"���W�X�^�ꗗ
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"�ŋߎg�p�����t�@�C���ꗗ
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
"�u�b�N�}�[�N�ꗗ
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
"�u�b�N�}�[�N�ɒǉ�
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"unite.vim���J���Ă���Ԃ̃L�[�}�b�s���O
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    "ESC��unite���I��
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction
" �ǂݍ��񂾃v���O�C�����܂߁A�t�@�C���^�C�v�̌��o�A�t�@�C���^�C�v�ʃv���O�C��/�C���f���g��L��������
filetype plugin indent on

" �C���X�g�[���̃`�F�b�N
NeoBundleCheck
