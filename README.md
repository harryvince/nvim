# nvim

This repo contains my neovim setup

## Setup

1. Make sure neovim is installed on your machine
2. Run the following to setup the config

```bash
git clone https://github.com/harryvince/nvim.git ~/.config/nvim
```

Now when you open neovim it should setup the package manager and all plugins.
If you want to customise anything the config files are named pretty well so
tweak it yourself :)

## Extras

This is some things you can use in other repos to ensure proper lsp support in all
use cases and or formatting works as expected for repos.

_.editorconfig_

```editorconfig
# top-most EditorConfig file
root = true

# Unix-style newlines with a newline ending every file
[*]
end_of_line = lf
insert_final_newline = true
indent_size = 4
```

_.nvimrc_

```nvimrc
au BufEnter,BufWinEnter *.service.j2 set filetype=systemd

let g:formatOnSave = 1
```

Also if your using iterm2 the background to match the theme is: `#1e1e2e`
