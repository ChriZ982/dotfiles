return {
    { -- hugely improves syntax highlighting
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects", -- allows for improved motions/actions on text objects
            "nvim-treesitter/nvim-treesitter-context", -- shows context of current cursor position when it is out of view
            "windwp/nvim-ts-autotag", -- automatically close and rename HTML tags
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "astro",
                    "bash",
                    "c",
                    "cmake",
                    "cpp",
                    "css",
                    "dockerfile",
                    "fish",
                    "go",
                    "gomod",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "make",
                    "markdown",
                    "python",
                    "rust",
                    "sql",
                    "terraform",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "xml",
                    "yaml",
                },
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = "<C-s>",
                        node_decremental = "<C-M-space>",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
                        goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
                        goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
                        goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
                    },
                    swap = {
                        enable = true,
                        swap_next = { ["<leader>a"] = "@parameter.inner" },
                        swap_previous = { ["<leader>A"] = "@parameter.inner" },
                    },
                },
                autotag = {
                    enable = true,
                },
            })
        end,
    },
}
