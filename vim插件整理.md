

vim配置（win+mac+Ubuntu三平台）
---------------
[TOC]

本人是一名大二的学生， 使用vim有一年半了， 整理的这些配置， 有一些是之前学长留下的， 有一些是我自己上网查重新配置的。
适合人群：**使用c++/java 刷题、做OJ题目的人。以及ACM竞赛选手。**  
本文不会介绍如何使用vim。 
主要是介绍vimrc中具体配置。 

## macOS 
mac中的vim有在终端里的vim和GUI界面的macvim。 对应的就有`vimrc`和`gvimrc`两个配置文件。 大部分配置都是通用的，  有一些不通用的配置在之后的文中我会注明。
首先我们要知道的几点：

1. `vimrc`比`gvimrc`先编译， 即使你在使用`macvim`， 系统也会读取`vimrc`的配置（插件部分会受到这个的影响）。
2. `gvimrc`的配置会覆盖`vimrc`.


### 基础部分
这一部分主要是一些默认配置， 主要是有一些是学长留下来的， 我也没有具体再去研究。
vimrc和gvimrc通用（不通用后面有标注）。

``` vim
set backspace=indent,eol,start
set nu ai ci si sts=4 ts=4 sw=4 mouse=a " 缩进设置
set number " 显示行号
set ruler 
set scrolloff=3 " 光标移动到buffer的顶部和底部时保持3行距离
colorscheme desert " 设置主题, 个人很喜欢这个主题

set lines=35 "窗口多长，下为多宽
set columns= 80

" 语言以及编码设置 当时一股脑复制进来的，解决win中代码打开乱码问题。
set langmenu=zh_CN.UTF-8
scriptencoding utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set laststatus=2  " 命令行（在状态行下）的高度，默认为1，这里是2
set guifont=Menlo:h15  "字体和大小

set transparency=10 
"透明度 这个只能在gvimrc中配置，macvim中可以使用。在vimrc里配置会报错，终端中不可用。
set cursorline " 突出显示当前行

```

``` vim
:cd /Users/zong/code/vimcode    " 初始化保存路径， 不配置这个的话默认保存在home中。
" 可以通过 pwd命令查看当前路径  和cd命令修改路径
```
因为在终端中无法使用快捷键全选复制粘贴， y和p也不能和系统剪贴板共享， 所以就需要再加几行配置来解决。

```vim
"复制粘贴控制 
nmap<C-A> ggvG
vmap<C-C> "*y
nmap <C-v> c<ESC>"+p 
imap <C-v> <ESC>"+pa
```
基本设置就是这些了， 重要的部分是一键编译。
### 一键编译
&#160; &#160; 一键编译我在`vimrc`和`gvimrc`中是有一些区别的， 主要原因是：
在终端中， 当我们编译的时候， 会从vim返回到bash中取执行， 在终端中接着之前的显示, 终端之前的残留信息个人感觉会影响阅读。而在macvim中， 我们编译的时候， 是直接在最下面显示的， 每次编译运行都只有这一次的信息。这里我研究了有一阵子， 所以打算详说说这一部分。
#### vimrc一键编译
```vim

nmap<F3> : vs %<.in <CR> 
"自动生成并打开.in文件， 方便放入输入数据。
nmap<F4> : !clear && time ./%< < %<.in <CR>  
"直接运行c++程序并读入.in中的数据
nmap<F5> : !clear && time java %< < %<.in <CR>
"直读入.in中的数据并运行java程序并读入.in中的数据
nmap<F6> : vs %<.out <CR>
" 打开.out

map <F9> :call InitCompile()<CR>   "识别代码种类并编译
func! InitCompile()
	if &filetype == 'c'
		exec "!clear && g++ % -o %<"
	elseif &filetype == 'cpp'
		exec "!clear && g++ % -o %<"
	elseif &filetype == 'java' 
		exec "!javac %" 
	elseif &filetype == 'sh'
		:!./%
	endif
endfunc


map <F10> :call CompileRunGcc()<CR> "识别代码种类并运行"
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

```
这里要说的就是 配置中有`clear ` 和 `time`这两个功能。
1. `clear` 是清空终端中之前的显示， 我个人觉着这样看编译结果以及答案的时候方便一些。
2. `time` 用来显示程序运行的时间。

#### gvimrc一键编译
对应的gvimrc中就不需要`clear`了， 其他的基本相同。

``` vim
nmap<F3> : vs %<.in <CR>
nmap<F4> :call XX() <CR>
func! XX()
    exec "w"
	exec "!time ./%< < %<.in"
endfunc
nmap<F5> : !time java %< < %<.in <CR>
nmap<F6> : vs %<.out <CR>

map <F9> :call InitCompile()<CR>
func! InitCompile()
	if &filetype == 'c'
		exec "!g++ % -o %<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
	elseif &filetype == 'java' 
		exec "!javac %" 
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

```

## windows
### 基础部分

```vim
syntax on
set backspace=indent,eol,start
set nu si ci ai mouse=a sw=4 sts=4 ts=4
set hlsearch incsearch
colorscheme desert " 主题
set guifont=Consolas:h14 " 字体
set report=0 showmatch cursorline
set guioptions-=m
set guioptions-=T

set lines=40 "窗口多长，下为多宽
set columns=100
set scrolloff=3 " 光标移动到buffer的顶部和底部时保持3行距离

:cd E:\vimcode " 初始化路径， 自行修改
set autoindent "自动缩进
set smartindent "智能缩进
" 这两个不知道有没有用， 没有实际感受。
```
因为在win下面编码模式默认是GBK编码， 为了解决有时候UTF-8的乱码问题， 需要修改编码模式。

```vim
"语言设置
set encoding=utf-8  
set termencoding=utf-8   
language messages zh_cn.utf-8   
```

快捷键复制粘贴

```vim
"复制粘贴控制 
nmap<C-A> ggvG
vmap<C-C> "*y
vmap <C-x> "+c 
vmap <C-v> c<ESC>"+p 
imap <C-v> <ESC>"+pa
```
一键编译
windows平台`time`命令就没用了， 所以还没有找到显示时间的方法。 

```vim
nmap<F3> : vs %<.in <CR>   " 自动创建并打开.in文件方便放入input数据.
nmap<F4> : ! %< < %<.in <CR> " 运行c++程序并读入.in中的数据
nmap<F5> : ! java %< < %<.in <CR> " 运行java程序并读入.中的数据
nmap<F6> : vs %<.out <CR> " 打开.out

map <F9> :call InitCompile()<CR> " 识别文件类型并且编译
func! InitCompile()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
	elseif &filetype == 'java' 
		exec "!javac %" 
	elseif &filetype == 'sh'
		:!./%
	endif
endfunc

map <F10> :call CompileRunGcc()<CR>  " 识别文件类型并运行程序
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "! %<"
	elseif &filetype == 'cpp'
		exec "! %<"
	elseif &filetype == 'java' 
		exec "! java %<"
	elseif &filetype == 'sh'
		:!./%
	endif
endfunc
```

### Ubuntu
Ubuntu的配置跟mac的vimrc就大同小异了， 基本是完全相同的。  读者可以自行修改尝试。 而且我刚使用Ubuntu没多长时间， 以后再慢慢更新。



## 偷懒必备
就是一键头文件， 平时做题的时候很方便。  我配置到F2键和F1键， F2是开始时间， F1用来记录结束时间。


```vim
"按<F2>自动生成代码设置
if !exists("*SetTitlea")
map <F2> :call SetTitlea()<CR>
func SetTitlea()
let l = 0
let l = l + 1 | call setline(l,'/**********************************************')
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
if !exists("*FinishTime")
map<F1> : call FinishTime()<CR>
func FinishTime()
let l = 4 | call setline(l,' *Ended  Time*  : '.strftime('%c'))
endfunc
endif

```




