setlocal textwidth=140
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal formatoptions=tcqr
setlocal formatprg=~/scalariver/scalariver\ --url=http://localhost\:8098\ --stdin\ --stdout\ -f\ +rewriteArrowSymbols\ +alignSingleLineCaseStatements\ +compactControlReadability\ +doubleIndentClassDeclaration\ +preserveDanglingCloseParenthesis
" setlocal formatprg=~/scalariver/scalariver\ --url=http://river.scalex.org\ --stdin\ --stdout\ -f\ +rewriteArrowSymbols\ +alignSingleLineCaseStatements\ +compactControlReadability\ +doubleIndentClassDeclaration\ +preserveDanglingCloseParenthesis
setlocal commentstring=//%s
let &l:include = '^\s*import'
let &l:includeexpr = 'substitute(v:fname,"\\.","/","g")'
setlocal path+=src/main/scala,src/test/scala
setlocal suffixesadd=.scala

" Operator notation: transforms a.b(c) to a b c
nmap <buffer> <leader>s. f.r<space>f(ds(i <esc>

" Triple quotes: transforms "abc" to """abc"""
nmap <buffer> <leader>s" ysi""lysi""

" Sort imports, format with scalariver then save
nmap <buffer> <leader>i :nohl<cr>mygggqG'y:SortScalaImports<cr>:w<cr>
