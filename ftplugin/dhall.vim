if exists('b:dhall_ftplugin')
	finish
endif
let b:dhall_ftplugin = 1

setlocal commentstring=--\ %s

set smarttab

function! StripTrailingWhitespace()
    let myline=line('.')
    let mycolumn = col('.')
    exec 'silent %s/  *$//'
    call cursor(myline, mycolumn)
endfunction

function! DhallFormat()
    let cursor = getpos('.')
    exec 'normal! gg'
    exec 'silent !dhall format --inplace ' . expand('%')
    exec 'e'
    call setpos('.', cursor)
endfunction

augroup dhall
    autocmd! dhall

    if exists('g:dhall_use_ctags')
        if g:dhall_use_ctags == 1
            autocmd BufWritePost *.dhall silent !ctags -R .
        endif
    endif

    if exists('g:dhall_strip_whitespace')
        if g:dhall_strip_whitespace == 1
            autocmd BufWritePre *.dhall silent! call StripTrailingWhitespace()
        endif
    endif

    if exists('g:dhall_format')
        if g:dhall_format == 1
            autocmd BufWritePost *.dhall call DhallFormat()
        endif
    endif

    autocmd BufNewFile,BufRead *.dhall setl shiftwidth=2
augroup END
