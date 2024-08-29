# Emre's dotfiles

This repository contains my personal dotfiles, which are used to configure my development environment. Before you stow the dotfiles, you should make sure that you have read related sections. I recommend that you read the dotfiles for possible issues that may be overlooked during installation for different distros.

# Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [List of dotfiles](#dotfiles)
  - [Zsh](#zsh)
  - [Neovim](#neovim)
  - [Tmux](#tmux)
  - [Yazi](#yazi)
  - [Fastfetch](#fastfetch)
  - Unsupported
    - LF
    - Powerlevel10k

## Requirements

This repository is made with [stow](https://github.com/vasi/stow) so it is essential for installing the dotfiles.

- [stow](https://github.com/vasi/stow)

Others are optional and depend on your needs.


### Optionals Requirements for each dotfile

- [Zsh](https://www.zsh.org/)
- [Neovim](https://github.com/neovim/neovim)
- [Tmux](https://github.com/tmux/tmux)
- [Yazi](https://github.com/sxyazi/yazi)
- [Fastfetch](https://github.com/fastfetch-cli/fastfetch)
- Unsupported
  - [LF](https://github.com/gokcehan/lf)
  - [Powerlevel10k](https://github.com/romkatv/powerlevel10k)


## Installation

To install these dotfiles, clone this repository and stow the desired dotfiles to your home directory:

```bash
git clone https://github.com/kilic-emre/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Initialize single dotfile
stow zsh
# Or initialize multiple
stow nvim zsh yazi
```

## Dotfiles

Each dotfile has its own section, and own dependencies. And also 

### Zsh
---

I use zsh for my shell with [antidote](https://github.com/mattmc3/antidote) plugin manager. There is also oh-my-zsh configs in this repository with oh-my-zsh tag. However this is not used for my current shell because of performance considerations. Therefore, you should install antidote or choose own best shell plugin manager.

Then install zsh plugins in the [zsh_plugins.txt](./zsh/.zsh_plugins.txt) file. If you use antidote, it will automatically install plugins.

This part is the most complex part of this repository. Because in the [.zshrc](./zsh/.zshrc) file, there are a lot of custom commands and their setups. So I leave this part to you. If stuck at this point, you can check [Brewfile](./Brewfile) which is [Homebrew](https://brew.sh/) package manager configuration file for all the commands that I use in my workflow.

Additionally, there is [.scripts.zsh](./zsh/.scripts.zsh) file that contains custom shell aliases and functions.

### Neovim
---

I use neovim as my editor with the [AstroNvim](https://astronvim.com/) distribution. I prefer AstroNvim because of its [community plugins](https://github.com/AstroNvim/AstroCommunity) which are easy to setup. Additionally, there are many configurations available to enhance workflow. If you want to see the plugins, you can look at [community.lua](./nvim/.config/nvim/lua/community.lua) file. For requirements, check the [AstroNvim](https://astronvim.com/) website.


### Tmux
---

For tmux can work properly, you should install **TPM** (Tmux Plugin Manager).
You can install with just cloning the repository:

``` bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Or you can install with package manager:
``` bash
brew install tpm # Homebrew
```

### Yazi
---

Yazi is command line file manager tool. It has a lot of builtin bindings such as image preview. I also add some bindings for archive files.

**Remember** your yazi version is under the 0.3.0 version,  you probably shouldn't use plugins.


Also you can check for dependencies and other features in the [yazi](https://yazi-rs.github.io/docs/installation).


### Fastfetch
---

Fastfetch is an alternative to Neofetch, a terminal system information tool that displays details about the system.

> NOTE: this tool is used .zshrc file. Therefore, if you don't install this tool, you should remove it from .zshrc file.
