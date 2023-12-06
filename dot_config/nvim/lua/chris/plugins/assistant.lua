return {
    { -- add GitHub copilot suggestions
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = { "InsertEnter" },
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = false,
                },
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept_word = "<M-Right>",
                        accept_line = "<M-Down>",
                    },
                },
                filetypes = {
                    gitcommit = true,
                    markdown = true,
                    yaml = true,
                },
            })

            local suggestion = require("copilot.suggestion")
            vim.keymap.set("i", "<Tab>", function()
                if suggestion.is_visible() then
                    suggestion.accept()
                else
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
                end
            end, { desc = "Accept copilot suggestion if available (zbirenbaum/copilot.lua)" })
        end,
    },
}
