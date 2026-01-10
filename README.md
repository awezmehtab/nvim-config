>[!WARNING]
> I've made breaking changes, this config now only works for 0.12 version of nvim
> which is in beta currently, to be released in feburary 2026.

# `nvim` configuration

This repository contains our neovim config, starting from 25/02/2025 (wow palindrome).

## Support for inheriting the Terminal cursor

If you are using another cursor in your terminal (Vertical Bar, Underline) and you want to
inherit that into your neovim editor and not the neovim block cursor, set the environment
variable **`NVIM_TERMINAL_CURSOR`** to **`true`**.

```bash
export NVIM_TERMINAL_CURSOR=true
```

and add this to your config:
```lua
-- Inherit cursor from the terminal, if the NVIM_TERMINAL_CURSOR is set to "true"
local nvim_cursor = os.getenv("NVIM_TERMINAL_CURSOR")
if nvim_cursor == "true" then
    opt.guicursor = ""
end
```
