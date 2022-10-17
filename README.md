# 🎃 denops-shared-server

This is a helper Vim plugin to install/uninstall [denops.vim][]'s shared server.

[denops.vim]: https://github.com/vim-denops/denops.vim

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
