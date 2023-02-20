Plug 'stephpy/vim-php-cs-fixer'

let g:php_cs_fixer_config_file = '.php-cs-fixer.dist.php'

nnoremap <silent><leader>cf :call PhpCsFixerFixFile()<CR>

" autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
