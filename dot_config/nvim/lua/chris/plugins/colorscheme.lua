return { {
    -- beatiful dark blue colorscheme
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            no_italic = true,
            integrations = {
                fidget = true,
                mason = true,
                treesitter_context = true,
            }
        })
        vim.cmd.colorscheme("catppuccin-mocha")
    end
} }
