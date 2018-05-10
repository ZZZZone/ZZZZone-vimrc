if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif


set backspace=indent,eol,start
set nu ai ci si sts=4 ts=4 sw=4 mouse=a

nmap<F3> : vs %<.in <CR>
"
nmap<F4> : !clear && time ./%< < %<.in  <CR>
"
nmap<F5> : !clear && time java %< < %<.in  <CR>
"
nmap<F6> : vs %<.out <CR>

nmap w,  :vertical resize -5<CR>
nmap w.  :vertical resize +5<CR>



map <F9> :call InitCompile()<CR>
func! InitCompile()
	if &filetype == 'c'
		exec "!clear && g++ % -o %<"
	elseif &filetype == 'cpp'
		exec "!clear && g++ % -o %<"
	elseif &filetype == 'java' 
		exec "!clear && javac %" 
	elseif &filetype == 'sh'
		:!./%
	endif
endfunc

map <F10> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!time ./%<"
	elseif &filetype == 'java' 
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!./%
	endif
endfunc

:cd /media/zzzzone/F盘又在卖萌了/vimcode

syntax on 
syntax enable
set mouse=a
set mousehide
set encoding=utf-8
scriptencoding utf-8
set backup "undo?
set number
set ruler
colorscheme desert
"set background=dark
set backspace=2
" set autoindent "自动缩进
" set smartindent "智能缩进
" set cindent "C系列缩进
 set softtabstop=4 "缩进长度
 set shiftwidth=4 "缩进长度
 set tabstop=4 "tab键长度
" set expandtab "tab设为空格
 set softtabstop=4 "缩进长度
   

vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>
" 括号自动生成

"
	

"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'


""""""""""""""""""""""""
""实用设置
""""""""""""""""""""""""
"set transparency=10 "透明度
set lines=55 "窗口多长，下为多宽
set columns=100
set scrolloff=3 " 光标移动到buffer的顶部和底部时保持3行距离
set langmenu=zh_CN.UTF-8
set helplang=cn

" 语言设置
"gvim内部编码
set encoding=utf-8 
"设置终端编码为gvim内部编码encoding
let &termencoding=&encoding
"当前编辑的文件编码
set fileencoding=utf-8
"gvim打开支持编码的文件
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set langmenu=zh_CN.UTF-8
"解决consle输出乱码
language messages zh_cn.utf-8   
"菜单栏中文
source $VIMRUNTIME/delmenu.vim 
source $VIMRUNTIME/menu.vim
set helplang=cn


autocmd BufWritePost $MYVIMRC source $MYVIMRC 
" 让配置变更立即生效

" colorscheme solarized
"配色沙漠 还有: torte, solarized, molokai, phd, ron, evening  等经典配色
" set guifont = Source_Code_Pro:h15
" 设置字体为  字体：大小
"set guifont=Menlo\ 16
set guifont=Monospace\ 14
"字体和大小
set laststatus=2
" 命令行（在状态行下）的高度，默认为1，这里是2
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
let Tlist_Use_Right_Window = 1
"在右侧窗口中显示taglist窗口
 set showmatch
"自动匹配
set wildmenu 
" vim 自身命令行模式智能补全
set nobackup
set noswapfile
"禁止生成临时文件

"复制粘贴控制 
nmap<C-A> ggvG
vmap<C-C> "+y
nmap <C-v> c<ESC>"+p 
imap <C-v> <ESC>"+pa


" 树形目录 
nmap <F12> :NERDTreeToggle<cr>


"按<F2>自动生成代码设置
if !exists("*SetTitlea")
map <F2> :call SetTitlea()<CR>
func SetTitlea()
let l = 0
let l = l + 1 | call setline(l,'/********************************************')
let l = l + 1 | call setline(l,' *Author*        :ZZZZone')
let l = l + 1 | call setline(l,' *Created Time*  : '.strftime('%c'))
let l = l + 1 | call setline(l,'')
"let l = l + 1 | call setline(l,'**Problem**:')
"let l = l + 1 | call setline(l,'**Analyse**:')
"let l = l + 1 | call setline(l,'**Get**:')
"let l = l + 1 | call setline(l,'**Code**:')
let l = l + 1 | call setline(l,'*********************************************/')
let l = l + 1 | call setline(l,'')
let l = l + 1 | call setline(l,'#include <cstdio>')
let l = l + 1 | call setline(l,'#include <cstring>')
let l = l + 1 | call setline(l,'#include <iostream>')
let l = l + 1 | call setline(l,'#include <algorithm>')
let l = l + 1 | call setline(l,'#include <vector>')
let l = l + 1 | call setline(l,'#include <queue>')
let l = l + 1 | call setline(l,'#include <set>')
let l = l + 1 | call setline(l,'#include <map>')
let l = l + 1 | call setline(l,'#include <string>')
let l = l + 1 | call setline(l,'#include <cmath>')
let l = l + 1 | call setline(l,'#include <cstdlib>')
let l = l + 1 | call setline(l,'#include <ctime>')
let l = l + 1 | call setline(l,'#include <stack>')
let l = l + 1 | call setline(l,'using namespace std;')
let l = l + 1 | call setline(l,'#define debug(x) std::cerr << #x << " = " << (x) << std::endl')
let l = l + 1 | call setline(l,'typedef pair<int, int> PII;')
let l = l + 1 | call setline(l,'typedef long long LL;')
let l = l + 1 | call setline(l,'typedef unsigned long long ULL;')
let l = l + 1 | call setline(l,'')
let l = l + 1 | call setline(l,'inline void OPEN(string s){')
let l = l + 1 | call setline(l,'	freopen((s + ".in").c_str(), "r", stdin);')
let l = l + 1 | call setline(l,'	freopen((s + ".out").c_str(), "w", stdout);')
let l = l + 1 | call setline(l,'}')
let l = l + 1 | call setline(l,'')
let l = l + 1 | call setline(l,'int main()')
let l = l + 1 | call setline(l,'{')
let l = l + 1 | call setline(l,'    return 0;')
let l = l + 1 | call setline(l,'}')
endfunc
endif


"完成时间
if !exists("*FinishT")
map<F1> : call FinishT()<CR>
func FinishT()
let l = 4 | call setline(l,' * Ended  Time*  : '.strftime('%c'))
endfunc
endif


" 设置当文件被改动时自动载入
" set autoread

" set backspace=” (Vi compatible)


