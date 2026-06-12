# Flutter Tools backup for Arch migration

This folder stores the local `flutter-tools.nvim` changes that were made outside the main Neovim config repo, so they can be restored safely on a new machine.

## Git source of truth

Use this Neovim config repo as the single git source of truth:

- repo: `git@github.com:srayleighdk/nvim-kickstart.git`
- branch: `main`

Everything needed for the Flutter inspector workaround is backed up here.

## Backed up files

### Config repo file

- `lua/custom/plugins/flutter-tools.lua`

### Patched plugin files from lazy.nvim checkout

Original plugin checkout path on old machine:

- `~/.local/share/nvim/lazy/flutter-tools.nvim`

Patched files:

- `files/dev_tools.lua`
- `files/debugger_runner.lua`

### Patch file

- `flutter-tools.nvim-local.patch`

Plugin base commit used to create the patch:

- `7d1acfd139215e02d2784733af69a61aaebe06e8`

## What changed

### In config

`lua/custom/plugins/flutter-tools.lua`

- added `FlutterLspReset`
- added `FlutterInspectReconnect`
- tuned Dart LSP attach behavior and safer highlight handling

### In flutter-tools.nvim plugin

`lua/flutter-tools/dev_tools.lua`

- added `get_vm_service_uri()` helper

`lua/flutter-tools/runners/debugger_runner.lua`

- cached last `vmServiceUri`
- added VM service reconnect helper for widget inspector
- reconnects inspector path when DAP is alive but VM service socket is dead
- added `DebuggerRunner.reconnect_inspector()`

## Restore on Arch Linux

1. Clone this Neovim config repo:

   ```bash
   git clone git@github.com:srayleighdk/nvim-kickstart.git ~/.config/nvim
   ```

2. Start Neovim and install plugins normally.

3. Reapply the plugin patch:

   ```bash
   git -C ~/.local/share/nvim/lazy/flutter-tools.nvim apply ~/.config/nvim/backup/flutter-tools/flutter-tools.nvim-local.patch
   ```

4. If patch apply fails, restore the raw files manually:

   ```bash
   cp ~/.config/nvim/backup/flutter-tools/files/dev_tools.lua \
     ~/.local/share/nvim/lazy/flutter-tools.nvim/lua/flutter-tools/dev_tools.lua

   cp ~/.config/nvim/backup/flutter-tools/files/debugger_runner.lua \
     ~/.local/share/nvim/lazy/flutter-tools.nvim/lua/flutter-tools/runners/debugger_runner.lua
   ```

5. Restart Neovim.

## Verification

Inside Neovim:

```vim
:FlutterDebug
:FlutterInspectReconnect
:lua print('dap=', require('dap').session() ~= nil)
:lua print('vm=', require('flutter-tools.vm_service').is_connected())
```

Expected after reconnect:

- `dap = true`
- `vm = true`

## Note

Because the plugin files live under `lazy/`, plugin updates can overwrite them. Keep this backup folder in git and reapply the patch after reinstalling or updating the plugin.
