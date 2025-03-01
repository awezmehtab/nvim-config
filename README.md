# Our `nvim` configuration

This repository contains our (Awez and Mohana, most of the credit to **Awez**) neovim config, starting from 25/02/2025 (wow palindrome).
I hope everything works fine in any machine, you might have to install these by yourselves:
* [`stylua`](https://github.com/JohnnyMorganz/StyLua)

## Support for inheriting the Terminal cursor

If you are using another cursor in your terminal (Vertical Bar, Underline) and you want to inherit that into your nvim and not the nvim
block cursor, set the environment variable **`NVIM_TERMINAL_CURSOR` to **`true`**.

```bash
export NVIM_TERMINAL_CURSOR=true
```
