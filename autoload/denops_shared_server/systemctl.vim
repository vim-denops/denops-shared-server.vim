let s:file = expand('<sfile>:p')
let s:name = "denops-shared-server"
let s:unit_file = expand(printf('~/.config/systemd/user/%s.service', s:name))
let s:template_file = printf('%s/systemctl.template', fnamemodify(s:file, ':h'))

function! denops_shared_server#systemctl#install(options) abort
  let content = denops_shared_server#_render(readfile(s:template_file, 'b'), {
        \ 'deno': a:options.deno,
        \ 'script': a:options.script,
        \ 'hostname': a:options.hostname,
        \ 'port': a:options.port,
        \})
  call denops_shared_server#util#info(printf('create the unit file `%s`', s:unit_file))
  call mkdir(fnamemodify(s:unit_file, ':h'), 'p')
  call writefile(content, s:unit_file, 'b')

  call denops_shared_server#util#info(printf('enable the unit `%s`', s:name))
  echo system(printf('systemctl --user enable %s.service', s:name))

  call denops_shared_server#util#info(printf('start the unit `%s`', s:name))
  echo system(printf('systemctl --user start %s.service', s:name))
endfunction

function! denops_shared_server#systemctl#uninstall() abort
  call denops_shared_server#util#info(printf('stop the unit `%s`', s:name))
  echo system(printf('systemctl --user stop %s.service', s:name))

  call denops_shared_server#util#info(printf('disable the unit `%s`', s:name))
  echo system(printf('systemctl --user disable %s.service', s:name))

  call denops_shared_server#util#info(printf('delete the unit file `%s`', s:unit_file))
  call delete(s:unit_file)

  call denops_shared_server#util#info('daemon reload')
  echo system('systemctl --user daemon-reload')

  call denops_shared_server#util#info('reset failed')
  echo system('systemctl --user reset-failed')
endfunction
