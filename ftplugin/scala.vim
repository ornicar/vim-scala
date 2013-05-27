setlocal textwidth=140
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal formatoptions=tcqr
setlocal formatprg=~/.scripts/scalariform\ --stdin
setlocal commentstring=//%s

" Compile and show errors in quickfix window
if filereadable('conf/routes')
  setlocal makeprg=bin/play\ -Dsbt.log.noformat=true\ compile
else
  setlocal makeprg=sbt\ -Dsbt.log.noformat=true\ compile
endif

set efm=%E\ %#[error]\ %f:%l:\ %m,%C\ %#[error]\ %p^,%-C%.%#,%Z,
       \%W\ %#[warn]\ %f:%l:\ %m,%C\ %#[warn]\ %p^,%-C%.%#,%Z,
       \%-G%.%#

setlocal errorformat=%E\ %#[error]\ %f:%l:\ %m,%C\ %#[error]\ %p^,%-C%.%#,%Z,
  \%W\ %#[warn]\ %f:%l:\ %m,%C\ %#[warn]\ %p^,%-C%.%#,%Z,
  \%-G%.%#

" Compile and open quickfix window
nmap <silent> <buffer> <leader>sM :make<cr>:copen<cr>

" Operator notation: transforms a.b(c) to a b c
nmap <buffer> <leader>s. f.r<space>f(ds(i <esc>

" Triple quotes: transforms "abc" to """abc"""
nmap <buffer> <leader>s" ysi""lysi""

" Sort imports, format with scalariform then save
nmap <buffer> <leader>i :nohl<cr>mygggqG'y:SortScalaImports<cr>:w<cr>
