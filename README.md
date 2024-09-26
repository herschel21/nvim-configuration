## Features

- Modern and intuitive user interface
- Syntax highlighting and intelligent code completion
- Integrated file explorer and fuzzy finder

## Prerequisites

- Neovim (version 0.5 or later)
- Git
- Wget or curl

## Installation

You can install this Neovim configuration easily with the following command:

```bash
bash -c "$(wget https://raw.githubusercontent.com/herschel21/dotfiles/main/install.sh -O -)"
```

This command downloads and runs the installation script, which will set up the Neovim configuration for you.

## Removal

You can uninstall this Neovim configuration and revert back easily with this following command:

```bash
bash -c "$(wget https://raw.githubusercontent.com/herschel21/dotfiles/main/uninstall.sh -O -)"
```

## Usage

After installation, simply run `nvim` to start Neovim with the new configuration. Here are some key features and how to use them:

## Neovim Keymaps

## General

- Leader key: `<Space>`
- Exit insert mode: `jk` or `kj`
- Save file: `<Ctrl-s>`
- Save file without auto-formatting: `<Space>sn`
- Quit file: `<Ctrl-q>`
- Clear search highlights: `<Esc>`
- Toggle Transparency: `<Space>z`

## Navigation

- Move through wrapped lines: `j` and `k` (in normal mode)
- Scroll down and center: `<Ctrl-d>`
- Scroll up and center: `<Ctrl-u>`
- Find next and center: `n`
- Find previous and center: `N`
- Next buffer: `<Tab>`
- Previous buffer: `<Shift-Tab>`

## Window Management

- Split window vertically: `<Space>v`
- Split window horizontally: `<Space>h`
- Make split windows equal size: `<Space>se`
- Close current split window: `<Space>xs`
- Navigate between splits: 
  - Up: `<Ctrl-k>`
  - Down: `<Ctrl-j>`
  - Left: `<Ctrl-h>`
  - Right: `<Ctrl-l>`
- Resize windows:
  - Decrease height: `<Ctrl-Up>`
  - Increase height: `<Ctrl-Down>`
  - Decrease width: `<Ctrl-Right>`
  - Increase width: `<Ctrl-Left>`

## Tab Management

- Open new tab: `<Space>to`
- Close current tab: `<Space>tx`
- Go to next tab: `<Space>tn`
- Go to previous tab: `<Space>tp`

## Buffer Management

- Close buffer: `<Space>x`
- New buffer: `<Space>b`

## Text Manipulation

- Delete single character without copying: `x`
- Increment number: `<Space>+`
- Decrement number: `<Space>-`
- Stay in indent mode (Visual mode): `<` and `>`
- Move text up (Visual mode): `<Alt-k>`
- Move text down (Visual mode): `<Alt-j>`
- Keep last yanked when pasting (Visual mode): `p`
- Replace word under cursor: `<Space>j`
- Yank to system clipboard: 
- Normal and Visual mode: `<Space>y`
- Entire line (Normal mode): `<Space>Y`

## Misc

- Toggle line wrapping: `<Space>lw`
- Toggle diagnostics: `<Space>do`
- Save session: `<Space>ss`
- Load session: `<Space>sl`

