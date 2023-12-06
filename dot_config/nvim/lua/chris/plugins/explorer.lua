return { {
    -- better file explorer than the built-in netrw
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
        vim.g.loaded_netrw = 1 -- disable netrw to avoid conflicts
        vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
        require("nvim-tree").setup({
            actions = {
                open_file = {
                    quit_on_open = true,
                }
            },
            filters = {
                git_ignored = false,
            },
            diagnostics = {
                enable = true,
            },
        })

        vim.keymap.set("n", "<leader>e", function() require("nvim-tree.api").tree.toggle({ find_file = true }) end,
            { desc = "Toggle file explorer (nvim-tree/nvim-tree.lua)" })
    end
} }
