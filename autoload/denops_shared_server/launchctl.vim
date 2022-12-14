let s:file = expand('<sfile>:p')
let s:name = "io.github.vim-denops.LaunchAtLogin"
let s:plist_file = expand(printf('~/Library/LaunchAgents/%s.plist', s:name))
let s:template_file = printf('%s/launchctl.template', fnamemodify(s:file, ':h'))

function! denops_shared_server#launchctl#install(options) abort
  let content = denops_shared_server#_render(readfile(s:template_file, 'b'), {
        \ 'name': s:name,
        \ 'home': expand('~'),
        \ 'deno': a:options.deno,
        \ 'script': a:options.script,
        \ 'hostname': a:options.hostname,
        \ 'port': a:options.port,
        \})
  call denops#util#info(printf('create the plist `%s`', s:plist_file))
  call mkdir(fnamemodify(s:plist_file, ':h'), 'p')
  call writefile(content, s:plist_file, 'b')

  call denops#util#info(printf('unload the plist `%s`', s:plist_file))
  call system(printf('launchctl unload %s', s:plist_file))

  call denops#util#info(printf('load the plist `%s`', s:plist_file))
  echo system(printf('launchctl load -w %s', s:plist_file))
endfunction

function! denops_shared_server#launchctl#uninstall() abort
  call denops#util#info(printf('unload the plist `%s`', s:plist_file))
  echo system(printf('launchctl unload %s', s:plist_file))

  call denops#util#info(printf('delete the plist `%s`', s:plist_file))
  call delete(s:plist_file)
endfunction
