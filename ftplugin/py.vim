set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79 	
set expandtab 	
set autoindent 	
set fileformat=unix

" This makes the flake quickfix window close automatically when wq, x, or q on
" a file
function NoShow()
    let g:flake8_show_quickfix=0
    wq
endfunction
cnoreabbrev <expr> wq getcmdtype() == ":" && getcmdline() == 'wq' ? 'call NoShow()' : 'wq'
cnoreabbrev <expr> q winnr("$") > 1 && getcmdtype() == ":" && getcmdline() == 'q' ? 'ccl <BAR> q' : 'q'
cnoreabbrev <expr> x winnr("$") > 1 && getcmdtype() == ":" && getcmdline() == 'x' ? 'ccl <BAR> x' : 'x'
