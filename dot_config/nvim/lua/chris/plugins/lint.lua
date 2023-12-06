return {
    { -- provide a language server for linting
        "mfussenegger/nvim-lint",
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                cpp = { "cpplint" },
            }

            -- configure linters

            lint.linters.cpplint.args = {
                "--linelength=140",
                "--filter=-legal/copyright,-build/include_order,-readability/todo",
            }

            -- enable linting on open, save and insert leave

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function() lint.try_lint() end,
            })
        end,
    },
}
