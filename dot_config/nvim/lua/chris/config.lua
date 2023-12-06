-- set global and buffer-local leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General Keybindings

local keymap = vim.keymap

-- improve line navigation when line is wrapped
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Move up by display line", expr = true })
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Move down by display line", expr = true })

-- diagnostics navigation
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap.set("n", "gl", function() vim.diagnostic.open_float({ source = true }) end, { desc = "Open diagnostic floating window" })

-- location list and quickfix navigation
keymap.set("n", "[l", "<cmd>lprev<CR>", { desc = "Go to previous location in location list" })
keymap.set("n", "]l", "<cmd>lnext<CR>", { desc = "Go to next location in location list" })
keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Go to previous quickfix item" })
keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Go to next quickfix item" })

-- line operations
keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- clear highlighting
keymap.set("n", "<leader>ch", "<cmd>noh<CR>", { desc = "Clear highlighting" })

-- copy/paste/delete keybindings
keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without overwriting the default register" })
keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without overwriting the default register" })
keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete character without overwriting the default register" })
keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap.set("n", "<leader>yy", '"+yy', { desc = "Copy line to system clipboard" })

-- toggle line indentation for current buffer
keymap.set("n", "<leader>ci", function()
    if vim.opt_local.shiftwidth:get() == 2 then
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
    else
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end
end, { desc = "Toggle indent between 2 and 4 spaces", silent = true })

-- General Settings

local opt = vim.opt

-- enable mouse support
opt.mouse = "a"

-- line numbers
opt.number = true -- enable line numbers
opt.relativenumber = true -- use relative line numbers
opt.signcolumn = "yes" -- always show sign column to avoid jumping text

-- configure tabs and indentation
opt.tabstop = 4 -- tab width
opt.shiftwidth = 4 -- indentation width
opt.expandtab = true -- use spaces instead of tabs

-- implicit saving
opt.swapfile = false -- disable swap file creation
opt.backup = false -- disable backup file creation
opt.undofile = true -- store undo history in a file

-- search settings
opt.ignorecase = true -- ignore case if search pattern is all lowercase
opt.smartcase = true -- respect case if search pattern contains uppercase

-- visual settings
opt.termguicolors = true -- enable true colors support
opt.scrolloff = 8 -- always keep 8 lines above/below cursor
opt.colorcolumn = "141" -- highlight column after 140 characters

-- Highlighting

-- highlight yanked text
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = "*",
})
