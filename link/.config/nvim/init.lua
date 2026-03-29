-- =============================================================================
-- Neovim Configuration (Lua)
-- Migrated from .vimrc
-- =============================================================================

-- Bootstrap lazy.nvim plugin manager
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

-- Set leader key before lazy (required)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =============================================================================
-- Plugins
-- =============================================================================
require("lazy").setup({
  -- Colorscheme
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup({ style = "dark" })
      require("onedark").load()
    end,
  },

  -- Syntax highlighting via Treesitter (Neovim 0.11+)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Install parsers
      require("nvim-treesitter").install({ "lua", "vim", "vimdoc", "rust", "toml", "json", "yaml", "markdown", "bash" })
      -- Enable treesitter highlighting for all filetypes
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  -- Rust-specific features (formatting, cargo integration)
  { "rust-lang/rust.vim", ft = "rust" },

  -- File navigation
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>o", "<cmd>Telescope find_files<cr>", desc = "Open file" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git", "DS_Store" },
        },
      })
    end,
  },

  -- File tree (replaces NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
      { "<leader>l", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    },
    config = function()
      require("nvim-tree").setup({
        -- Close nvim-tree if it's the last window
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
      })
    end,
  },

  -- Statusline (replaces vim-airline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "onedark",
          section_separators = "",
          component_separators = "",
        },
        tabline = {
          lualine_a = { "buffers" },
        },
      })
    end,
  },

  -- Tim Pope essentials
  { "tpope/vim-commentary" },  -- gcc to comment
  { "tpope/vim-sleuth" },      -- Auto-detect indentation
  { "tpope/vim-surround" },    -- cs"' to change surroundings

  -- EditorConfig: Built-in since Neovim 0.9 (no plugin needed)
  -- vim.g.editorconfig = true  -- enabled by default

  -- Text objects & motions
  { "wellle/targets.vim" },                     -- Additional text objects
  { "bkad/CamelCaseMotion" },                   -- CamelCase motion
  { "coderifous/textobj-word-column.vim" },     -- Column text objects
  {
    "terryma/vim-expand-region",
    keys = {
      { "v", "<Plug>(expand_region_expand)", mode = "v", desc = "Expand region" },
      { "<C-v>", "<Plug>(expand_region_shrink)", mode = "v", desc = "Shrink region" },
    },
  },

  -- Line moving: Using native keymaps (Alt+j/k) defined below

  -- Smooth scrolling
  { "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>" },
      })
    end,
  },

  -- Completion (replaces supertab)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Terminal: Neovim handles cursor shape, focus events, bracketed paste natively
})

-- =============================================================================
-- General Settings
-- =============================================================================
local opt = vim.opt

opt.encoding = "utf-8"
opt.modelines = 0

-- UI
opt.number = true
opt.numberwidth = 4
opt.relativenumber = true
opt.cursorline = true
opt.showmode = false            -- Hidden, shown by lualine
opt.showcmd = true
opt.visualbell = true
opt.ruler = true
opt.laststatus = 2
opt.colorcolumn = "120"
opt.scrolloff = 3
opt.ttyfast = true

-- Editing
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.wrap = true
opt.textwidth = 79
opt.formatoptions = "qrn1"

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true
opt.incsearch = true
opt.showmatch = true
opt.hlsearch = true

-- Behavior
opt.hidden = true
opt.mouse = "nicr"
opt.swapfile = false
opt.wildmode = { "longest", "list", "full" }
opt.wildmenu = true
opt.matchpairs:append("<:>")
opt.fileformat = "unix"

-- Undo persistence
local undodir = vim.fn.expand("~/.vim/undo")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
opt.undodir = undodir
opt.undofile = true

-- Timeouts
opt.timeoutlen = 1000
opt.ttimeoutlen = 0

-- Auto-adjust timeout in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function() opt.timeoutlen = 200 end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function() opt.timeoutlen = 1000 end,
})

-- Save on focus lost
vim.api.nvim_create_autocmd("FocusLost", {
  pattern = "*",
  command = "silent! wa",
})

-- Highlight search colors
vim.api.nvim_set_hl(0, "Search", { bg = "Red" })

-- =============================================================================
-- Key Mappings
-- =============================================================================
local map = vim.keymap.set

-- Exit insert mode with jj
map("i", "jj", "<Esc>")

-- Use very magic regex by default
map("n", "/", "/\\v")
map("v", "/", "/\\v")

-- Remap visual block to Ctrl+Shift+V
map("n", "<C-S-v>", "<C-v>")

-- Tab to match brackets instead of %
map("n", "<tab>", "%")
map("v", "<tab>", "%")

-- Disable arrow keys (learn hjkl!)
map("n", "<Space>", "<nop>")
map("n", "<up>", "<nop>")
map("n", "<down>", "<nop>")
map("n", "<left>", "<nop>")
map("n", "<right>", "<nop>")
map("i", "<up>", "<nop>")
map("i", "<down>", "<nop>")
map("i", "<left>", "<nop>")
map("i", "<right>", "<nop>")

-- Move lines with Alt+j/k
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Move in display lines instead of physical lines
map("n", "j", "gj")
map("n", "k", "gk")

-- Map , to :
map("n", ",", ":")

-- Enter to go to end of file, Backspace to go to beginning
map("n", "<CR>", "G")
map("n", "<BS>", "gg")

-- Leader key mappings
map("n", "<leader>ev", "<C-w><C-v><C-l>:e $MYVIMRC<CR>", { desc = "Edit init.lua" })
map("n", "<leader>wq", ":wq<CR>", { desc = "Write and quit" })
map("n", "<leader>w", ":w<CR>", { desc = "Write file" })
map("n", "<leader>rv", ":source $MYVIMRC<CR>", { desc = "Reload config" })
map("n", "<leader>v", "<C-w>v<C-w>l", { desc = "Vertical split" })

-- System clipboard shortcuts
map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("v", "<leader>d", '"+d', { desc = "Delete to clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("n", "<leader>P", '"+P', { desc = "Paste before from clipboard" })
map("v", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("v", "<leader>P", '"+P', { desc = "Paste before from clipboard" })

-- =============================================================================
-- Filetype Detection
-- =============================================================================
vim.filetype.add({
  pattern = {
    [".*/etc/nginx/conf/.*"] = "nginx",
    [".*%.ahk"] = "autohotkey",
  },
  extension = {
    json = "json",
    gitconfig = "gitconfig",
  },
})

-- Logstash detection
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.conf",
  callback = function()
    local first_line = vim.fn.getline(1)
    if first_line:match("^%s*input {") then
      vim.bo.filetype = "logstash"
    end
  end,
})









