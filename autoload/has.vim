if exists('g:has_colorscheme')
    finish
endif
let g:has_colorscheme = 1

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! has#colorscheme(name) abort
    let pat = 'colors/'.a:name.'.vim'
    return !empty(globpath(&runtimepath, pat))
endfunction

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save

