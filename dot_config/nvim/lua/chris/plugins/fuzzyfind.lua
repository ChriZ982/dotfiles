return { {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',                                            -- utility functions
        "nvim-tree/nvim-web-devicons",                                      -- icons
        { "folke/todo-comments.nvim",                 opts = {} },          -- highlight and search TODOs
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },     -- faster fuzzy finding
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                    },
                },
                sorting_strategy = "ascending",
                mappings = {
                    n = {
                        ["<C-d>"] = require("telescope.actions").delete_buffer
                    },
                },
                file_ignore_patterns = { "node_modules", ".git", "vcpkg" }
            },
            pickers = {
                buffers = {
                    sort_mru = true,
                    ignore_current_buffer = true,
                },
                lsp_document_symbols = {
                    symbol_width = 50,
                },
            },
        })

        telescope.load_extension("fzf")

        -- Keymaps for telescope
        local keymap = vim.keymap
        local builtin = require("telescope.builtin")

        keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find project files (nvim-telescope/telescope.nvim)" })
        keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Show old files (nvim-telescope/telescope.nvim)" })
        keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find,
            { desc = "Show current buffer fuzzy find (nvim-telescope/telescope.nvim)" })
        keymap.set("n", "<leader>b", builtin.buffers, { desc = "Show open buffers (nvim-telescope/telescope.nvim)" })
        keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files (nvim-telescope/telescope.nvim)" })
        keymap.set("n", "<leader>fF", function() builtin.find_files({ hidden = true, no_ignore = true }) end,
            { desc = "Find all files (nvim-telescope/telescope.nvim)" })
        keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find in grep (nvim-telescope/telescope.nvim)" })
        keymap.set("n", "<leader>fG",
            function() builtin.live_grep({ additonal_args = { "--hidden", "--no-ignore" } }) end,
            { desc = "Find all in grep (nvim-telescope/telescope.nvim)" })
        keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags (nvim-telescope/telescope.nvim)" })
        keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps (nvim-telescope/telescope.nvim)" })
        keymap.set("n", "<leader>fd", builtin.diagnostics,
            { desc = "Find diagnostics (nvim-telescope/telescope.nvim)" })
        keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find resume (nvim-telescope/telescope.nvim)" })

        -- Keymaps for TODOs
        local todo = require("todo-comments")

        keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>",
            { desc = "Find todo items in workspace (folke/todo-comments.nvim)" })
        keymap.set("n", "]t", function() todo.jump_next() end,
            { desc = "Jump to next todo item (folke/todo-comments.nvim)" })
        keymap.set("n", "[t", function() todo.jump_prev() end,
            { desc = "Jump to previous todo item (folke/todo-comments.nvim)" })
    end
} }
