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

| OS      | Method                                             |
| ------- | -------------------------------------------------- |
| Windows | Bundled [WinSW v2](https://github.com/winsw/winsw) |
| macOS   | System's `launchctl` (launchd)                     |
| Linux   | System's `systemctl` (systemd)                     |

Note that Windows user requires .NET Framework 4.6.1 (preinstalled since Windows 10 November Update version 1511).

## License

The code follows MIT license written in [LICENSE](./LICENSE). Contributors need
to agree that any modifications sent in this repository follow the license.
