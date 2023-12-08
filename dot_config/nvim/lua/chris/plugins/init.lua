return {
    { -- navigate between nvim and tmux panes using CTRL-h/j/k/l
        "christoomey/vim-tmux-navigator",
    },

    { -- enable commenting out lines or blocks of code with 'gc' and 'gcc'
        "numToStr/Comment.nvim",
        event = { "BufRead", "BufNewFile" },
        opts = {},
    },

    { -- show history of edits made to a file
        "mbbill/undotree",
        keys = { { "<leader>u", "<cmd>UndotreeToggle | UndotreeFocus<CR>", desc = "Toggle and focus undo tree (mbbill/undotree)" } },
    },

    { -- surround text with quotes, brackets, etc.
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },

    { -- show vertical lines at indentation levels
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufRead", "BufNewFile" },
        main = "ibl",
        opts = {
            indent = { char = "▏" },
            scope = { enabled = false },
        },
    },

    { -- remove trailing whitespace on save
        "ntpeters/vim-better-whitespace",
        init = function()
            vim.g.better_whitespace_enabled = 0 -- disable highlighting
            vim.g.strip_whitespace_on_save = 1
            vim.g.strip_whitespace_confirm = 0 -- do not ask for confirmation
        end,
    },

    { -- more beautiful and improved statusline
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "catppuccin",
                component_separators = "",
                section_separators = "",
            },
        },
    },
}
