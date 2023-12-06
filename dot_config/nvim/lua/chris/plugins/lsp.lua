return {
    {
        -- configures the built-in LSP client
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim", -- install LSP servers, formatters, linters, and other tools with ease
            "williamboman/mason-lspconfig.nvim", -- integrate mason with lspconfig
            "folke/neodev.nvim", -- setup LSP for neovim config
            { "j-hui/fidget.nvim", opts = { notification = { window = { winblend = 0 } } } }, -- show LSP status
            "hrsh7th/nvim-cmp", -- autocompletion plugin
            "hrsh7th/cmp-buffer", -- buffer source for nvim-cmp
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
            "onsails/lspkind.nvim", -- adds pictograms to nvim-cmp
            "L3MON4D3/LuaSnip", -- snippet engine
            "saadparwaiz1/cmp_luasnip", -- snippet source for nvim-cmp
            "rafamadriz/friendly-snippets", -- snippets collection
        },
        config = function()
            local servers = {
                clangd = {},
                -- gopls = {},
                -- pyright = {},
                rust_analyzer = {},
                -- tsserver = {},
                -- html = { filetypes = { "html", "twig", "hbs"} },

                lua_ls = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                        diagnostics = { disable = { "missing-fields" } },
                    },
                },
            }

            local function on_attach(_, bufnr)
                local function map(keys, func, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set("n", keys, func, opts)
                end

                local builtin = require("telescope.builtin")

                map("<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol (neovim/nvim-lspconfig)" })
                map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code action (neovim/nvim-lspconfig)" })
                map("K", vim.lsp.buf.hover, { desc = "Hover documentation (neovim/nvim-lspconfig)" })
                map("gd", builtin.lsp_definitions, { desc = "Goto definition (telescope.nvim)" })
                map("gi", builtin.lsp_implementations, { desc = "Goto implementation (telescope.nvim)" })
                map("go", builtin.lsp_type_definitions, { desc = "Goto outline / type definition (telescope.nvim)" })
                map("gr", builtin.lsp_references, { desc = "Goto references (telescope.nvim)" })
                map("<leader>fs", builtin.lsp_document_symbols, { desc = "Find symbols in document (telescope.nvim)" })
                map("<leader>fw", builtin.lsp_dynamic_workspace_symbols, { desc = "Find workspace symbols (telescope.nvim)" })
            end

            -- change the Diagnostic symbols in the sign column
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- configure mason to automatically install and configure LSP servers
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            -- print table keys
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                ensure_installed = vim.tbl_keys(servers),
            })

            require("neodev").setup()

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            mason_lspconfig.setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    })
                end,
            })

            -- configure autocompletion
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            luasnip.config.setup({})

            cmp.setup({
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = require("lspkind").cmp_format({
                        mode = "symbol",
                        ellipsis_char = "…",
                    }),
                },
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                completion = {
                    completeopt = "menu,menuone,noselect",
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                    ["<CR>"] = function(fallback)
                        if cmp.visible() and cmp.get_active_entry() then
                            cmp.confirm({})
                        else
                            fallback()
                        end
                    end,
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                view = {
                    entries = { name = "custom", selection_order = "bottom_up" },
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                },
            })

            -- configure keymaps
            local keymap = vim.keymap

            keymap.set("n", "<leader>ls", "<cmd>LspInfo<CR>", { desc = "Open LSP info window (neovim/nvim-lspconfig" })
            keymap.set("n", "<leader>ma", "<cmd>Mason<CR>", { desc = "Open Mason window to manage LSP servers (williamboman/mason.nvim)" })
        end,
    },
}
