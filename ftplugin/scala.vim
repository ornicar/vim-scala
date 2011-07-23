" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal textwidth=140
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal formatoptions=tcqr

" Operator notation: transforms a.b(c) to a b c
nmap <leader>s. f.r<space>f(ds(i <esc>
