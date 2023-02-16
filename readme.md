# Omega the second
Rewrite of omega-nvim neovim config (max397574/omega-nvim)
This config should be usable as is

You can place your own plugins or disable plugins inside the `lua/omega/custom` folder.
You can overwrite lazy options inside the `lua/omega/custom/config/lazy.lua` file.
For example to set dev options you could do this:
```lua
-- lua/omega/custom/config/lazy.lua
return {
    dev = {
        path = "~/neovim_plugins/",
        fallback = true,
        patterns = { "max397574" },
    },
}
```

Atm this only has onedark colorscheme and you can't also install plugins for other ones because a specific style of themes is needed
## Credits
- Nvchad: The original concept of how the themes are done now and some code for the tabline
