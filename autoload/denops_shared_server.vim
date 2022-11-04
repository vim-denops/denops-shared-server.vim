function! denops_shared_server#install() abort
  if !exists('g:denops_server_addr')
    call denops#util#error('No denops shared server address (g:denops_server_addr) is given.')
    return
  endif
  let [hostname, port] = s:parse_server_addr(g:denops_server_addr)
  let options = {
        \ 'deno': exepath(g:denops#deno),
        \ 'script': denops#util#script_path('@denops-private/cli.ts'),
        \ 'hostname': hostname,
        \ 'port': port,
        \}
  if has('win32') && executable('powershell.exe')
    call denops_shared_server#runtray#install(options)
  elseif executable('launchctl')
    call denops_shared_server#launchctl#install(options)
  elseif executable('systemctl')
    call denops_shared_server#systemctl#install(options)
  else
    call denops#util#error('This platform is not supported. Please configure denops-shared-server manually.')
    return
  endif
  call denops#util#info('wait 5 second for the shared server startup...')
  sleep 5
  call denops#util#info('connect to the shared server')
  call denops#server#connect()
  call denops#util#info('stop the local server')
  call denops#server#stop()
endfunction

function! denops_shared_server#uninstall() abort
  if has('win32') && executable('powershell.exe')
    call denops_shared_server#runtray#uninstall()
  elseif executable('launchctl')
    call denops_shared_server#launchctl#uninstall()
  elseif executable('systemctl')
    call denops_shared_server#systemctl#uninstall()
  else
    call denops#util#error('This platform is not supported. Please configure denops-shared-server manually.')
    return
  endif
endfunction

function! denops_shared_server#_render(template, context) abort
  let content = join(a:template, "\n")
  for [key, value] in items(a:context)
    let content = substitute(content, printf('{{%s}}', key), escape(value, '\'), 'g')
  endfor
  return split(content, "\n", v:true)
endfunction

function! s:parse_server_addr(addr) abort
  let parts = split(a:addr, ':', v:true)
  if len(parts) isnot# 2
    throw printf('[denops-shared-server] Server address must follow `{hostname}:{port}` format but `%s` is given', a:addr)
  endif
  return [parts[0], parts[1]]
endfunction
