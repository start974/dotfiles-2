local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup {
  spec = {
    -- add LazyVim and import its plugins
    --{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override plugins
    { import = 'plugins' },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- Use the latest stable release for plugins that support semver (set `version = false` per plugin to track HEAD)
    version = '*', -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { 'monokai-nightasty' } },
  checker = {
    -- automatically check for plugin updates
    enabled = false,
    notify = true, -- get a notification when new updates are found
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        -- "matchit",
        -- "matchparen",
        'netrwPlugin', -- replaced by snacks explorer
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
}
