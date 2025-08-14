# My Personal Configuration

This repository contains my personal terminal setup and dotfiles configuration.

<img width="1972" height="1236" alt="CleanShot 2025-08-14 at 12 16 17" src="https://github.com/user-attachments/assets/27d3462b-2797-4ae8-8232-d2240867b18c" />


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
