setlocal textwidth=140
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal formatoptions=tcqr
setlocal formatprg=~/scalariver/scalariver\ --url=http://localhost\:8098\ --stdin\ --stdout\ -f\ +alignSingleLineCaseStatements\ +compactControlReadability\ +doubleIndentClassDeclaration\ +preserveDanglingCloseParenthesis\ +spacesAroundMultiImports\ --danglingCloseParenthesis=Preserve
" setlocal formatprg=~/scalariver/scalariver\ --url=http://localhost\:8098\ --stdin\ --stdout\ -f\ +rewriteArrowSymbols\ +alignSingleLineCaseStatements\ +compactControlReadability\ +doubleIndentClassDeclaration\ +preserveDanglingCloseParenthesis
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
nmap <buffer> <leader>i :nohl<cr>mygggqG'y:delm y<cr>:w<cr>:SortScalaImports<cr>:w<cr>
"
" TagBar
"
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'kinds'     : [
      \ 'p:packages:1',
      \ 'V:values',
      \ 'v:variables',
      \ 'T:types',
      \ 't:traits',
      \ 'o:objects',
      \ 'a:aclasses',
      \ 'c:classes',
      \ 'r:cclasses',
      \ 'm:methods'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'T' : 'type',
        \ 't' : 'trait',
        \ 'o' : 'object',
        \ 'a' : 'abstract class',
        \ 'c' : 'class',
        \ 'r' : 'case class'
    \ },
    \ 'scope2kind' : {
      \ 'type' : 'T',
      \ 'trait' : 't',
      \ 'object' : 'o',
      \ 'abstract class' : 'a',
      \ 'class' : 'c',
      \ 'case class' : 'r'
    \ }
\ }

function! s:CreateOrExpression(keywords)
  return '('.join(a:keywords, '|').')'
endfunction

function! s:NextSection(backwards)
  if a:backwards
    let dir = '?'
  else
    let dir = '/'
  endif
  let keywords = [ 'def', 'class', 'trait', 'object' ]
  let keywordsOrExpression = s:CreateOrExpression(keywords)

  let modifiers = [ 'public', 'private', 'private\[\w*\]', 'protected', 'abstract', 'case', 'override', 'implicit', 'final', 'sealed']
  let modifierOrExpression = s:CreateOrExpression(modifiers)

  let regex = '^ *('.modifierOrExpression.' )* *'.keywordsOrExpression."\r"
  execute 'silent normal! ' . dir . '\v'.regex
endfunction

noremap <script> <buffer> <silent> ]] :call <SID>NextSection(0)<cr>

noremap <script> <buffer> <silent> [[ :call <SID>NextSection(1)<cr>
