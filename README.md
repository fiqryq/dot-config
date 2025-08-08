# My Personal Configuration

This repository contains my personal terminal setup and dotfiles configuration.

## Terminal Setup

I use **Ghostty** as my terminal emulator with its default settings, plus a custom color scheme.
Here are the main tools I use in my environment:

- **[Ghostty](https://ghostty.org/)** – Terminal emulator
- **[yabai](https://github.com/koekeishiya/yabai)** – Tiling window manager for macOS
- **[skhd](https://github.com/koekeishiya/skhd)** – Simple hotkey daemon
- **[AstroNvim](https://github.com/AstroNvim/AstroNvim)** – Neovim configuration framework

## Installation

This configuration is managed using **GNU Stow**, so you'll need to install it first:

```bash
brew install stow
```

### 1. Clone the Repository

Clone this repository into your home directory:

```bash
git clone https://github.com/fiqryq/dot-config.git ~/dot-config
```

### 2. Create Symlinks

Use GNU Stow to symlink the configuration files to your home directory:

```bash
cd ~/dot-config
stow .
```

That's it — your terminal will now use these dotfiles.
