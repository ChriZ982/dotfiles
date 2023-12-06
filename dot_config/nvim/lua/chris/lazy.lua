-- install lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- setup lazy.nvim and all plugins
require("lazy").setup({ { import = "chris.plugins" } }, {
    install = {
        colorscheme = { "catppuccin-mocha" }, -- load colorscheme before installing plugins
    },
    change_detection = {
        notify = false, -- do not notify when nvim config files change
    },
})

vim.keymap.set("n", "<leader>la", "<cmd>Lazy<CR>", { desc = "Open plugin manager (folke/lazy.nvim)" })
