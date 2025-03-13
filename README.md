# Our `nvim` configuration

This repository contains our neovim config, starting from 25/02/2025 (wow palindrome).
I hope everything works fine in any machine, you might have to install these by yourselves:
* [`stylua`](https://github.com/JohnnyMorganz/StyLua)
* [`clangd`](https://github.com/clangd/clangd)

## Support for inheriting the Terminal cursor

If you are using another cursor in your terminal (Vertical Bar, Underline) and you want to
inherit that into your neovim editor and not the neovim block cursor, set the environment
variable **`NVIM_TERMINAL_CURSOR`** to **`true`**.

```bash
export NVIM_TERMINAL_CURSOR=true
```
