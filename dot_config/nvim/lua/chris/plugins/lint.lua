return {
    { -- provide a language server for linting
        "mfussenegger/nvim-lint",
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                cpp = { "cpplint" },
                markdown = { "markdownlint" },
            }

            -- ensure that the linters are installed

            local mason_registry = require("mason-registry")
            for _, linter in ipairs(vim.tbl_flatten(vim.tbl_values(lint.linters_by_ft))) do
                if not mason_registry.is_installed(linter) then print("Please install the linter '" .. linter .. "'") end
            end

            -- configure linters

            lint.linters.cpplint.args = { "--linelength=140", "--filter=-legal/copyright,-build/include_order,-readability/todo" }
            lint.linters.markdownlint.args = { "--disable", "MD013", "--" }

            -- enable linting on open, save and insert leave

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function() lint.try_lint() end,
            })
        end,
    },
}
