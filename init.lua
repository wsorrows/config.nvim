-- This is an example init file , its supposed to be placed in /lua/custom dir
-- lua/custom/init.lua

-- This is where your custom modules and plugins go.
-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!

local hooks = require "core.hooks"

-- MAPPINGS
-- To add new mapps, use the "setup_mappings" hook,

hooks.add("setup_mappings", function(map)
   map("n", "<leader>q", ":bd<CR>", opt)
   map("n", "<leader>ft", ":Telescope treesitter<CR>")
end)

-- NOTE : opt is a variable  there (most likely a table if you want multiple options),
-- you can remove it if you dont have any custom options

-- Install plugins
-- To add new plugins, use the "install_plugin" hook,

-- examples below:

hooks.add("install_plugins", function(use)
   use {
     "blackCauldron7/surround.nvim",
      config = function()
        require("surround").setup {mappings_style = "sandwich"}
      end
   }
end)

-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event' field)
-- see: https://github.com/wbthomason/packer.nvim
-- https://nvchad.github.io/config/walkthrough
