" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal formatoptions=tcqr
setlocal formatprg=~/.scripts/scalariform\ --stdin
setlocal commentstring=//%s

" Compile and show errors in quickfix window
if filereadable('conf/routes')
  setlocal makeprg=play\ -Dsbt.log.noformat=true\ compile
else
  setlocal makeprg=sbt\ -Dsbt.log.noformat=true\ compile
endif

setlocal errorformat=%E\ %#[error]\ %f:%l:\ %m,%C\ %#[error]\ %p^,%-C%.%#,%Z,
  \%W\ %#[warn]\ %f:%l:\ %m,%C\ %#[warn]\ %p^,%-C%.%#,%Z,
  \%-G%.%#

" Compile and open quickfix window
nmap <silent> <buffer> <leader>sM :make<cr>:copen<cr>

" Operator notation: transforms a.b(c) to a b c
nmap <buffer> <leader>s. f.r<space>f(ds(i <esc>

" Triple quotes: transforms "abc" to """abc"""
nmap <buffer> <leader>s" ysi""lysi""

" Format with scalariform then save
nmap <buffer> <leader>i :nohl<cr>:w<cr>mygggqG'y
