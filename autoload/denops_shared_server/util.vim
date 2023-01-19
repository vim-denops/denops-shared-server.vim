function! denops_shared_server#util#script_path(path) abort
  try
    " Denops v4 or later
    return denops#_internal#path#script([a:path])
  catch /^Vim\%((\a\+)\)\=:E117:/
    " Denops v3 or prior
    return denops#util#script_path(a:path)
  endtry
endfunction

function! denops_shared_server#util#info(...) abort
  call s:echomsg('None', a:000)
endfunction

function! denops_shared_server#util#error(...) abort
  call s:echomsg('ErrorMsg', a:000)
endfunction

function! s:echomsg(hl, msg) abort
  execute printf('echohl %s', a:hl)
  for l:line in split(join(a:msg), '\n')
    echomsg printf('[denops-shared-server] %s', l:line)
  endfor
  echohl None
endfunction
