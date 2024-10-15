# 🚀 My Neovim Configuration

## 🛠️ Installation

You can install this Neovim configuration easily with the following command:

```bash
bash -c "$(wget https://raw.githubusercontent.com/herschel21/dotfiles/main/install.sh -O -)"
```

This command downloads and runs the installation script, which will set up the Neovim configuration for you.

## 🗑️ Removal

To uninstall this Neovim configuration and revert back to your previous setup, use:

```bash
bash -c "$(wget https://raw.githubusercontent.com/herschel21/dotfiles/main/uninstall.sh -O -)"
```

## 🚀 Usage

After installation, simply run `nvim` to start Neovim with the new configuration.

## ⌨️ Keymaps

# Neovim Keymaps

## General

| Keymap | Mode | Action |
|--------|------|--------|
| `<Space>` | Normal | Leader key |
| `jk` or `kj` | Insert | Exit insert mode |
| `<Ctrl-s>` | Normal | Save file |
| `<Space>sn` | Normal | Save file without auto-formatting |
| `<Ctrl-q>` | Normal | Quit file |
| `<Esc>` | Normal | Clear search highlights |
| `<Space>z` | Normal | Toggle Transparency |

## Navigation

| Keymap | Mode | Action |
|--------|------|--------|
| `j` and `k` | Normal | Move through wrapped lines |
| `<Ctrl-d>` | Normal | Scroll down and center |
| `<Ctrl-u>` | Normal | Scroll up and center |
| `n` | Normal | Find next and center |
| `N` | Normal | Find previous and center |
| `<Tab>` | Normal | Next buffer |
| `<Shift-Tab>` | Normal | Previous buffer |

## Window Management

| Keymap | Mode | Action |
|--------|------|--------|
| `<Space>v` | Normal | Split window vertically |
| `<Space>h` | Normal | Split window horizontally |
| `<Space>se` | Normal | Make split windows equal size |
| `<Space>xs` | Normal | Close current split window |
| `<Ctrl-k>` | Normal | Navigate to split above |
| `<Ctrl-j>` | Normal | Navigate to split below |
| `<Ctrl-h>` | Normal | Navigate to left split |
| `<Ctrl-l>` | Normal | Navigate to right split |
| `<Ctrl-Up>` | Normal | Decrease window height |
| `<Ctrl-Down>` | Normal | Increase window height |
| `<Ctrl-Left>` | Normal | Decrease window width |
| `<Ctrl-Right>` | Normal | Increase window width |

## Tab Management

| Keymap | Mode | Action |
|--------|------|--------|
| `<Space>to` | Normal | Open new tab |
| `<Space>tx` | Normal | Close current tab |
| `<Space>tn` | Normal | Go to next tab |
| `<Space>tp` | Normal | Go to previous tab |

## Buffer Management

| Keymap | Mode | Action |
|--------|------|--------|
| `<Space>x` | Normal | Close buffer |
| `<Space>b` | Normal | New buffer |

## Text Manipulation

| Keymap | Mode | Action |
|--------|------|--------|
| `x` | Normal | Delete single character without copying |
| `<Space>+` | Normal | Increment number |
| `<Space>-` | Normal | Decrement number |
| `<` and `>` | Visual | Stay in indent mode |
| `<Alt-k>` | Visual | Move text up |
| `<Alt-j>` | Visual | Move text down |
| `p` | Visual | Keep last yanked when pasting |
| `<Space>j` | Normal | Replace word under cursor |
| `<Space>y` | Normal, Visual | Yank to system clipboard |
| `<Space>Y` | Normal | Yank entire line to system clipboard |

## Misc

| Keymap | Mode | Action |
|--------|------|--------|
| `<Space>lw` | Normal | Toggle line wrapping |
| `<Space>do` | Normal | Toggle diagnostics |
| `<Space>ss` | Normal | Save session |
| `<Space>sl` | Normal | Load session |

## Autocompletion (nvim-cmp)

| Keymap | Mode | Action |
|--------|------|--------|
| `<C-j>` | Insert | Select next item |
| `<C-k>` | Insert | Select previous item |
| `<CR>` | Insert | Confirm completion |
| `<C-c>` | Insert | Trigger completion manually |
| `<C-l>` | Insert, Select | Expand or jump forward in snippet |
| `<C-h>` | Insert, Select | Jump backward in snippet |
| `<Tab>` | Insert, Select | Select next item or expand/jump in snippet |
| `<S-Tab>` | Insert, Select | Select previous item or jump backward in snippet |

## File Explorer (Neo-tree)

| Keymap | Mode | Action |
|--------|------|--------|
| `\` | Normal | Reveal current file in Neo-tree |
| `<leader>e` | Normal | Toggle Neo-tree |

## Commenting (Comment.nvim)

| Keymap | Mode | Action |
|--------|------|--------|
| `<C-_>` | Normal | Toggle comment for current line |
| `<C-c>` | Normal | Toggle comment for current line |
| `<C-/>` | Normal | Toggle comment for current line |
| `<C-_>` | Visual | Toggle comment for selected lines |
| `<C-c>` | Visual | Toggle comment for selected lines |
| `<C-/>` | Visual | Toggle comment for selected lines |

## LSP

| Keymap | Mode | Action |
|--------|------|--------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gr` | Normal | Show references |
| `gi` | Normal | Go to implementation |
| `<space>rn` | Normal | Rename symbol |
| `<space>ca` | Normal | Code action |
| `<space>d` | Normal | Show diagnostics |

## Fuzzy Finder (Telescope)

| Keymap | Mode | Action |
|--------|------|--------|
| `<leader>?` | Normal | Find recently opened files |
| `<leader>sb` | Normal | Search existing buffers |
| `<leader>sm` | Normal | Search marks |
| `<leader>gf` | Normal | Search Git files |
| `<leader>gc` | Normal | Search Git commits |
| `<leader>gcf` | Normal | Search Git commits for current file |
| `<leader>gb` | Normal | Search Git branches |
| `<leader>gs` | Normal | Search Git status (diff view) |
| `<leader>sf` | Normal | Search files |
| `<leader>sh` | Normal | Search help tags |
| `<leader>sw` | Normal | Search current word |
| `<leader>sg` | Normal | Search by grep |
| `<leader>sd` | Normal | Search diagnostics |
| `<leader>sr` | Normal | Resume last search |
| `<leader>s.` | Normal | Search recent files |
| `<leader><leader>` | Normal | Find existing buffers |
| `<leader>s/` | Normal | Live grep in open files |
| `<leader>/` | Normal | Fuzzy search in current buffer |

## Bufferline

| Keymap | Mode | Action |
|--------|------|--------|
| `<Tab>` | Normal | Go to next buffer |
| `<S-Tab>` | Normal | Go to previous buffer |
| `<leader>1` to `<leader>9` | Normal | Go to buffer 1-9 |

---

By [herschel21](https://github.com/herschel21)
