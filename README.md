# 🎃 denops-shared-server

[![Denops.vim 7.0.0 or above]][Denops.vim-v7.0.0]

This is a helper Vim plugin to install/uninstall [Denops.vim][]'s shared server.

[Denops.vim]: https://github.com/vim-denops/denops.vim
[Denops.vim-v7.0.0]: https://github.com/vim-denops/denops.vim/releases/tag/v7.0.0
[Denops.vim 7.0.0 or above]: https://img.shields.io/badge/Denops.vim-Support%207.0.0-yellowgreen.svg

## Usage

Call `denops_shared_server#install()` function to install denops-shared-server
on the system like

```vim
:call denops_shared_server#install()
```

And uninstall the server with `denops_shared_server#uninstall()` like

```vim
:call denops_shared_server#uninstall()
```

This plugin uses the following methods to install the shared server on the system.

| OS      | Method                                       |
| ------- | -------------------------------------------- |
| Windows | System's `powershell.exe` and [runtray-ps][] |
| macOS   | System's `launchctl` (launchd)               |
| Linux   | System's `systemctl` (systemd)               |

Note that Windows user requires PowerShell 3.0 (preinstalled since Windows 8).
[runtray-ps][]'s script file is automatically downloaded.

[runtray-ps]: https://github.com/Milly/runtray-ps

## License

The code follows MIT license written in [LICENSE](./LICENSE). Contributors need
to agree that any modifications sent in this repository follow the license.
