return {
    { -- provide a language server for formatting that uses formatters installed with mason
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
            },
            format_on_save = {
                async = false,
                timeout_ms = 1000,
                lsp_fallback = true,
            },
        },
    },
}
