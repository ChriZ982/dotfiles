vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local function keym(mode, l, r, desc, opts)
    opts = opts or {}
    opts.desc = desc
    vim.keymap.set(mode, l, r, opts)
end

require("lazy").setup({
    { "tpope/vim-fugitive" },
    { "tpope/vim-sleuth" },
    { "github/copilot.vim" },
    { "nvim-treesitter/nvim-treesitter-context" },
    { "christoomey/vim-tmux-navigator" },
    { "mbbill/undotree" },
    { "numToStr/Comment.nvim",                  opts = {} },
    { "folke/todo-comments.nvim",               opts = {} },

    {
        "ojroques/nvim-osc52",
        opts = {
            tmux_passthrough = true,
        }
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local function keymb(mode, l, r, desc, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    keym(mode, l, r, desc, opts)
                end

                local gs = package.loaded.gitsigns
                keymb("n", "<leader>hs", gs.stage_hunk, "Current [h]unk [s]tage (gitsigns.nvim)")
                keymb("n", "<leader>hS", gs.stage_buffer, "All [h]unks in buffer [S]tage (gitsigns.nvim)")
                keymb("v", "<leader>hs", function()
                    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Selected [h]unk [s]tage (gitsigns.nvim)")
                keymb("n", "<leader>hr", gs.reset_hunk, "Current [h]unk [r]eset (gitsigns.nvim)")
                keymb("n", "<leader>hR", gs.reset_buffer, "All [h]unks in buffer [R]eset (gitsigns.nvim)")
                keymb("v", "<leader>hr", function()
                    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Selected [h]unk [r]eset (gitsigns.nvim)")
                keymb("n", "<leader>hp", gs.preview_hunk, "Current [h]unk [p]review (gitsigns.nvim)")
                keymb("n", "<leader>hu", gs.undo_stage_hunk, "Current [h]unk [u]ndo stage (gitsigns.nvim)")
                keymb("n", "<leader>hd", gs.diffthis, "All [h]unks in buffer [d]iff with staged version (gitsigns.nvim)")
                keymb("n", "<leader>hD", function()
                    gs.diffthis("HEAD")
                end, "Selected [h]unk [d]iff with unstaged version (gitsigns.nvim)")
                keymb("n", "<leader>hb", function()
                    gs.blame_line({ full = true })
                end, "Current [h]unk show [b]lame popup (gitsigns.nvim)")

                keymb({ "n", "v" }, "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, "Jump to next hunk (gitsigns.nvim)", { expr = true })
                keymb({ "n", "v" }, "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, "Jump to previous hunk (gitsigns.nvim)", { expr = true })
            end,
        }
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({ no_italic = true, })
            vim.cmd.colorscheme("catppuccin-mocha")
        end
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons", },
        opts = {
            actions = { open_file = { quit_on_open = true, } },
            filters = { git_ignored = false, },
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "catppuccin",
                component_separators = "",
                section_separators = "",
            },
        },
    },

    {
        "ntpeters/vim-better-whitespace",
        config = function()
            vim.g.better_whitespace_enabled = 0
            vim.g.strip_whitespace_on_save = 1
            vim.g.strip_whitespace_confirm = 0
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            "folke/neodev.nvim",
        },
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function() return vim.fn.executable("make") == 1 end,
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", },
        build = ":TSUpdate",
    },
})

vim.g.loaded_netrw       = 1 -- disable netrw in favor of nvim-tree
vim.g.loaded_netrwPlugin = 1

vim.o.mouse              = "a"           -- Enable mouse support

vim.o.clipboard          = "unnamedplus" -- Use system clipboard

vim.o.nu                 = true          -- line numbers
vim.o.relativenumber     = true          -- relative line numbers

vim.o.swapfile           = false
vim.o.backup             = false
vim.o.undofile           = true  -- persistent undo

vim.o.ignorecase         = true  -- ignore case when searching
vim.o.smartcase          = true  -- ignore case when searching lowercase only

vim.o.signcolumn         = "yes" -- always show sign column

vim.o.updatetime         = 250   -- decrease update time
vim.o.timeoutlen         = 300

vim.o.completeopt        = "menuone,noselect" -- have better completion experience

vim.o.termguicolors      = true               -- enable true colors support

vim.o.scrolloff          = 8                  -- keep 8 lines above/below cursor

vim.o.colorcolumn        = "140"              -- highlight column 140

keym("n", "k", "v:count == 0 ? 'gk' : 'k'", "Move up by display line", { expr = true })
keym("n", "j", "v:count == 0 ? 'gj' : 'j'", "Move down by display line", { expr = true })

keym("n", "[d", vim.diagnostic.goto_prev, "Go to previous [d]iagnostic")
keym("n", "]d", vim.diagnostic.goto_next, "Go to next [d]iagnostic")
keym("n", "gl", function() vim.diagnostic.open_float({ source = true }) end, "Open diagnostic float")

keym("n", "[l", "<cmd>lprev<CR>", "Go to previous [l]ocation")
keym("n", "]l", "<cmd>lnext<CR>", "Go to next [l]ocation")

keym("n", "[q", "<cmd>cprev<CR>", "Go to previous [q]uickfix")
keym("n", "]q", "<cmd>cnext<CR>", "Go to next [q]uickfix")

keym("n", "J", "mzJ`z", "[J]oin lines and keep cursor position")
keym("v", "J", ":m '>+1<CR>gv=gv", "Move selected lines down")
keym("v", "K", ":m '<-2<CR>gv=gv", "Move selected lines up")

keym("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gc<left><Left><Left>",
    "[s]ubstitute the word under the cursor")
keym("v", "<leader>s", "\"hy:%s/<C-r>h//gc<left><Left><Left>",
    "[s]ubstitute the selected text")

keym("n", "<leader>ch", "<cmd>noh<CR>", "[c]lear [h]ighlighting")

keym("x", "<leader>p", "\"_dP", "[p]aste without overwriting the default register")
keym({ "n", "v" }, "<leader>d", "\"_d", "[d]elete without overwriting the default register")
keym({ "n", "v" }, "x", "\"_x", "Delete character without overwriting the default register")

keym("i", "<C-j>", "copilot#Accept('')", "Accept entire Copilot suggestion (copilot.vim)",
    { expr = true, replace_keycodes = false })
keym("i", "<C-k>", "<Plug>(copilot-accept-word)", "Accept next Copilot word suggestion (copilot.vim)")
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_filetypes = { yaml = true, markdown = true, gitcommit = true, }

keym("n", "<leader>la", "<cmd>Lazy<CR>", "Open [l][a]zy window to manage plugins (lazy.nvim)")
keym("n", "<leader>ls", "<cmd>LspInfo<CR>", "Open [l][s]p info window (lspconfig.nvim)")
keym("n", "<leader>ma", "<cmd>Mason<CR>", "Open [m][a]son window to manage LSP servers (mason.nvim)")

keym("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", "Toggle file [e]xplorer (nvim-tree.lua)")
keym("n", "<leader>u", "<cmd>UndotreeToggle | UndotreeFocus<CR>", "Toggle [u]ndo tree (undotree)")

keym("n", "<leader>gs", "<cmd>Git<CR>", "Open [g]it [s]tatus window (vim-fugitive)")
keym("n", "<leader>gp", "<cmd>Git push<CR>", "[g]it [p]ush (vim-fugitive)")
keym("n", "<leader>gu", "<cmd>Git pull<CR>", "[g]it [u]pull (vim-fugitive)")
keym("n", "<leader>gf", "<cmd>Git fetch --prune --prune--tags<CR>", "[g]it [f]etch (vim-fugitive)")
keym("n", "<leader>gd", "<cmd>Git diff --ignore-all-space<CR>", "[g]it [d]iff (vim-fugitive)")
keym("n", "<leader>gD", "<cmd>Git diff --ignore-all-space --cached<CR>", "[g]it [d]iff including staged (vim-fugitive)")
keym("n", "<leader>gb", "<cmd>Git blame<CR>", "[g]it [b]lame (vim-fugitive)")
keym("n", "<leader>gl", "<cmd>Git log<CR>", "[g]it [l]og (vim-fugitive)")
keym("n", "<leader>gc", ":Git chechout ", "[g]it [c]heckout (vim-fugitive)")
keym("n", "<leader>gm", ":Git merge ", "[g]it [m]erge (vim-fugitive)")

keym("n", "<leader>c", require("osc52").copy_operator, "Copy to system clipboard (nvim-osc52)",
    { expr = true })
keym("n", "<leader>cc", "<leader>c_", "Copy to system clipboard (nvim-osc52)", { remap = true })
keym("v", "<leader>c", require("osc52").copy_visual, "Copy visual selection to system clipboard (nvim-osc52)")

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

require("telescope").setup({
    defaults = {
        layout_config = {
            horizontal = {
                prompt_position = "top",
            },
        },
        sorting_strategy = "ascending",
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
            },
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

pcall(require("telescope").load_extension, "fzf")

local tele = require("telescope.builtin")

keym("n", "<C-p>", tele.git_files, "Find [p]roject / git files (telescope.nvim)")
keym("n", "<leader>?", tele.oldfiles, "Show old files (telescope.nvim)")
keym("n", "<leader>/", tele.current_buffer_fuzzy_find, "Show current buffer fuzzy find (telescope.nvim)")
keym("n", "<leader>b", tele.buffers, "Show open [b]uffers (telescope.nvim)")
keym("n", "<leader>ff", tele.find_files, "[f]ind [f]iles (telescope.nvim)")
keym("n", "<leader>fF", function() tele.find_files({ hidden = true, no_ignore = true }) end,
    "[f]ind all [F]iles (telescope.nvim)")
keym("n", "<leader>fg", tele.live_grep, "[f]ind in [g]rep (telescope.nvim)")
keym("n", "<leader>fG", function() tele.live_grep({ additonal_args = { "--hidden", "--no-ignore" } }) end,
    "[f]ind all in [G]rep (telescope.nvim)")
keym("n", "<leader>fh", tele.help_tags, "[f]ind [h]elp tags (telescope.nvim)")
keym("n", "<leader>fk", tele.keymaps, "[f]ind [k]eymaps (telescope.nvim)")
keym("n", "<leader>fd", tele.diagnostics, "[f]ind [d]iagnostics (telescope.nvim)")
keym("n", "<leader>fr", tele.resume, "[f]ind [r]esume (telescope.nvim)")
keym("n", "<leader>ft", "<cmd>TodoTelescope<CR>", "[f]ind [t]odo items in workspace (todo-comments.nvim)")

-- Defer Treesitter setup after first render to improve startup time of "nvim {filename}"
vim.defer_fn(function()
    require("nvim-treesitter.configs").setup {
        ensure_installed = {
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
                goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer", },
                goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer", },
                goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer", },
                goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer", },
            },
            swap = {
                enable = true,
                swap_next = { ["<leader>a"] = "@parameter.inner", },
                swap_previous = { ["<leader>A"] = "@parameter.inner", },
            },
        },
    }
end, 0)

local function on_attach(_, bufnr)
    local function keymb(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        keym("n", keys, func, desc, { buffer = bufnr })
    end

    keymb("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
    keymb("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

    keymb("K", vim.lsp.buf.hover, "Hover Documentation")

    keymb("gd", tele.lsp_definitions, "[g]oto [d]efinition (telescope.nvim)")
    keymb("gi", tele.lsp_implementations, "[g]oto [i]mplementation (telescope.nvim)")
    keymb("go", tele.lsp_type_definitions, "[g]oto [o]utline / type definition (telescope.nvim)")
    keymb("gr", tele.lsp_references, "[g]oto [r]eferences (telescope.nvim)")

    keymb("<leader>fs", tele.lsp_document_symbols, "[f]ind [s]ymbols in document (telescope.nvim)")
    keymb("<leader>fw", tele.lsp_dynamic_workspace_symbols,
        "[f]ind [w]orkspace symbols (telescope.nvim)")

    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

require("mason").setup()
require("mason-lspconfig").setup()

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

require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end,
})

local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup {}

cmp.setup({
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = require("lspkind").cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "…",
        }),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = "menu,menuone,noinsert"
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<CR>"] = cmp.mapping.confirm({ select = true, }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    view = {
        entries = { name = "custom", selection_order = "bottom_up" },
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
})
