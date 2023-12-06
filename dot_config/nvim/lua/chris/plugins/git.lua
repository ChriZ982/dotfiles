return {
    {
        -- Full integration of git commands and UI
        "tpope/vim-fugitive",
        config = function()
            local keymap = vim.keymap
            keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status (tpope/vim-fugitive)" })
            keymap.set("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git push (tpope/vim-fugitive)" })
            keymap.set("n", "<leader>gu", "<cmd>Git pull<CR>", { desc = "Git pull (tpope/vim-fugitive)" })
            keymap.set("n", "<leader>gf", "<cmd>Git fetch --prune --prune--tags<CR>",
                { desc = "Git fetch and prune (tpope/vim-fugitive)" })
            keymap.set("n", "<leader>gd", "<cmd>Git diff --ignore-all-space<CR>",
                { desc = "Git diff (tpope/vim-fugitive)" })
            keymap.set("n", "<leader>gD", "<cmd>Git diff --ignore-all-space --cached<CR>",
                { desc = "Git diff including staged (tpope/vim-fugitive)" })
            keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git blame (tpope/vim-fugitive)" })
            keymap.set("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "Git log (tpope/vim-fugitive)" })
            keymap.set("n", "<leader>gc", ":Git chechout ", { desc = "Git checkout (tpope/vim-fugitive)" })
            keymap.set("n", "<leader>gm", ":Git merge ", { desc = "Git merge (tpope/vim-fugitive)" })
        end
    },

    {
        -- Show git diff in sign column and operate on hunks
        "lewis6991/gitsigns.nvim",
        event = { "BufRead", "BufNewFile" },
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true, desc = "Jump to next hunk (lewis6991/gitsigns.nvim)" })

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true, desc = "Jump to previous hunk (lewis6991/gitsigns.nvim)" })

                -- Actions
                map('n', '<leader>hs', gs.stage_hunk, { desc = "Stage hunk (lewis6991/gitsigns.nvim)" })
                map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage all hunks (lewis6991/gitsigns.nvim)" })
                map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = "Stage hunk (lewis6991/gitsigns.nvim)" })
                map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset hunk (lewis6991/gitsigns.nvim)" })
                map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset all hunks (lewis6991/gitsigns.nvim)" })
                map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    { desc = "Reset hunk (lewis6991/gitsigns.nvim)" })
                map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk (lewis6991/gitsigns.nvim)" })
                map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo last stage hunk (lewis6991/gitsigns.nvim)" })
                map('n', '<leader>hd', gs.diffthis, { desc = "Diff with staged version (lewis6991/gitsigns.nvim)" })
                map('n', '<leader>hD', function() gs.diffthis('HEAD') end,
                    { desc = "Diff with HEAD version (lewis6991/gitsigns.nvim)" })
                map('n', '<leader>hb', function() gs.blame_line { full = true } end,
                    { desc = "Blame line (lewis6991/gitsigns.nvim)" })
            end
        }
    }
}
