let s:file = expand('<sfile>:p')
let s:name = "denops-shared-server"
let s:xml_file = expand(printf('~\AppData\Local\denops\%s.xml', s:name))
let s:exe_file = expand(printf('~\AppData\Local\denops\%s.exe', s:name))
let s:service_file = printf('%s\WinSW.NET461.exe', fnamemodify(s:file, ':h'))
let s:template_file = printf('%s\winsw.template', fnamemodify(s:file, ':h'))

function! denops_shared_server#winsw#install(options) abort
  let content = denops_shared_server#_render(readfile(s:template_file, 'b'), {
        \ 'path': escape(expand('$PATH'), '\'),
        \ 'home': escape(expand('$HOME'), '\'),
        \ 'deno': a:options.deno,
        \ 'script': a:options.script,
        \ 'hostname': a:options.hostname,
        \ 'port': a:options.port,
        \})
  call denops#util#info(printf('create the xml file `%s`', s:xml_file))
  call mkdir(fnamemodify(s:xml_file, ':h'), 'p')
  call writefile(content, s:xml_file, 'b')

  call denops#util#info(printf('copy the binary file `%s`', s:exe_file))
  call writefile(readfile(s:service_file, 'b'), s:exe_file, 'b')

  call denops#util#info('install the service')
  echo system(printf('%s install', s:exe_file))

  call denops#util#info('start the service')
  echo system(printf('%s start', s:exe_file))
endfunction

function! denops_shared_server#winsw#uninstall() abort
  call denops#util#info('stop the service')
  echo system(printf('%s stop', s:exe_file))

  call denops#util#info('uninstall the service')
  echo system(printf('%s uninstall', s:exe_file))

  call denops#util#info(printf('delete the xml file `%s`', s:xml_file))
  call delete(s:xml_file)

  call denops#util#info(printf('delete the exe file `%s`', s:exe_file))
  call delete(s:exe_file)
endfunction
