return {
    { -- provide a language server for formatting that uses formatters installed with mason
        "stevearc/conform.nvim",
        config = function()
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    javascript = { "prettierd" },
                    typescript = { "prettierd" },
                    markdown = { "markdownlint" },
                },
                format_on_save = {
                    async = false,
                    timeout_ms = 1000,
                    lsp_fallback = true,
                },
            })

            -- ensure that the formatters are installed

            local mason_registry = require("mason-registry")
            for _, formatter in ipairs(conform.list_all_formatters()) do
                if not mason_registry.is_installed(formatter.name) then print("Please install the formatter '" .. formatter.name .. "'") end
            end

            vim.keymap.set("n", "<leader>lf", "<cmd>ConformInfo<CR>", { desc = "Show formatter info (stevearc/conform.nvim)" })
        end,
    },
}
