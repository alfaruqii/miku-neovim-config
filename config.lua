--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
vim.opt.relativenumber = true
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "everblush"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.treesitter.autotag.enable = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "sumneko_lua",
  "jsonls",
  "clangd",
  "jdtls",
  "emmet_ls",
  "tsserver",
  "eslint", -- Optional: For linting and code actions
}

require('lspconfig').tsserver.setup {
  on_attach = function(client, bufnr)
    -- Setup LSP-specific keybindings or other configurations
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  end,
}
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black",       filetypes = { "python" } },
--   { command = "clang-format" },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip").filetype_extend("javascriptreact", { "html" })
      require("luasnip").filetype_extend("typescriptreact", { "html" })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  { 'Everblush/nvim',        name = 'everblush' },
  {
    'IogaMaster/neocord',
    event = "VeryLazy",
    config = function()
      require("neocord").setup({
        -- General options
        logo                = "auto",                -- "auto" or url
        logo_tooltip        = nil,                   -- nil or string
        main_image          = "language",            -- "language" or "logo"
        client_id           = "1157438221865717891", -- Use your own Discord application client id (not recommended)
        log_level           = nil,                   -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        debounce_timeout    = 10,                    -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        blacklist           = {},                    -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
        file_assets         = {},                    -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
        show_time           = true,                  -- Show the timer
        global_timer        = false,                 -- if set true, timer won't update when any event are triggered

        -- Rich Presence text options
        editing_text        = "Editing %s",         -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
        file_explorer_text  = "Browsing %s",        -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
        git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
        plugin_manager_text = "Managing plugins",   -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
        reading_text        = "Reading %s",         -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
        workspace_text      = "Working on %s",      -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
        line_number_text    = "Line %s out of %s",  -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
        terminal_text       = "Using Terminal",     -- Format string rendered when in terminal mode.
      })
    end
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('hlchunk').setup({
        chunk = {
          enable = true
          -- ...
        },
      })
    end
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
  },
  {
    "mrjones2014/nvim-ts-rainbow",
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
  {
    "laytan/tailwind-sorter.nvim",
    version = "v1.0.4", -- Specify the version for stability
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-treesitter/nvim-treesitter-textobjects" },
    build = "cd formatter && npm i && npm run build",
    config = function()
      require("tailwind-sorter").setup({
        on_save_enabled = true, -- Enable on save
        on_save_pattern = {
          "*.html",
          "*.js",
          "*.jsx",
          "*.tsx",
          "*.vue",
          "*.res",
          "*.css",
          "*.pcss",
          "*.sass",
          "*.scss",
          "*.md",
          "*.mdx",
          "*.php",
          "*.heex",
          "*.eex",
          "*.erb",
          "*.hbs",
          "*.handlebars",
        },
      })
    end,
  },
  { 'wakatime/vim-wakatime', lazy = false },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   config = function()
  --     local cmp = require('cmp')
  --     local lspkind = require('lspkind')

  --     cmp.setup({
  --       snippet = {
  --         expand = function(args)
  --           vim.fn["vsnip#anonymous"](args.body) -- For vsnip users.
  --         end,
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --         ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --         ['<C-Space>'] = cmp.mapping.complete(),
  --         ['<C-e>'] = cmp.mapping.abort(),
  --         ['<CR>'] = cmp.mapping.confirm({ select = true }),
  --       }),
  --       sources = {
  --         { name = 'nvim_lsp' },
  --         { name = 'buffer' },
  --         { name = 'path' },
  --         { name = 'nvim_lsp_signature_help' },
  --       },
  --       formatting = {
  --         format = lspkind.cmp_format({
  --           with_text = true,
  --           maxwidth = 50,
  --         }),
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "hrsh7th/cmp-nvim-lsp",
  -- },
  -- {
  --   "hrsh7th/cmp-buffer",
  -- },
  -- {
  --   "hrsh7th/cmp-path",
  -- },
  -- {
  --   "hrsh7th/cmp-nvim-lsp-signature-help",
  -- },
  -- {
  --   "onsails/lspkind.nvim",
  -- }
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
-- PATCH: in order to address the message:
-- vim.treesitter.query.get_query() is deprecated, use vim.treesitter.query.get() instead. :help deprecated
--   This feature will be removed in Nvim version 0.10

--   added by faruqi
local options = {
  backspace = vim.opt.backspace + { "nostop" }, -- Don't stop backspace at insert
  clipboard = "unnamedplus",                    -- Connection to the system clipboard
  cmdheight = 0,                                -- hide command line unless needed
  completeopt = { "menuone", "noselect" },      -- Options for insert mode completion
  copyindent = true,                            -- Copy the previous indentation on autoindenting
  cursorline = true,                            -- Highlight the text line of the cursor
  expandtab = true,                             -- Enable the use of space in tab
  fileencoding = "utf-8",                       -- File content encoding for the buffer
  fillchars = { eob = " " },                    -- Disable `~` on nonexistent lines
  history = 100,                                -- Number of commands to remember in a history table
  ignorecase = true,                            -- Case insensitive searching
  laststatus = 3,                               -- globalstatus
  lazyredraw = true,                            -- lazily redraw screen
  mouse = "a",                                  -- Enable mouse support
  number = true,                                -- Show numberline
  preserveindent = true,                        -- Preserve indent structure as much as possible
  pumheight = 10,                               -- Height of the pop up menu
  relativenumber = true,                        -- Show relative numberline
  scrolloff = 8,                                -- Number of lines to keep above and below the cursor
  shiftwidth = 2,                               -- Number of space inserted for indentation
  showmode = false,                             -- Disable showing modes in command line
  showtabline = 2,                              -- always display tabline
  sidescrolloff = 8,                            -- Number of columns to keep at the sides of the cursor
  signcolumn = "yes",                           -- Always show the sign column
  smartcase = true,                             -- Case sensitivie searching
  splitbelow = true,                            -- Splitting a new window below the current one
  splitright = true,                            -- Splitting a new window at the right of the current one
  swapfile = false,                             -- Disable use of swapfile for the buffer
  tabstop = 2,                                  -- Number of space in a tab
  termguicolors = true,                         -- Enable 24-bit RGB color in the TUI
  timeoutlen = 300,                             -- Length of time to wait for a mapped sequence
  undofile = true,                              -- Enable persistent undo
  updatetime = 300,                             -- Length of time to wait before triggering the plugin
  wrap = true,                                  -- Disable wrapping of lines longer than the width of window
  writebackup = false,                          -- Disable making a backup before overwriting a file
  -- minimal number of screen columns either side of cursor if wrap is `false`
  -- guifont = "monospace:h17", -- the font used in graphical neovim applications
  guifont = "JetBrainsMono_Nerd_Font_Mono:h11", -- the font used in graphical neovim applications
  whichwrap = "bs<>[]hl",                       -- which "horizontal" keys are allowed to travel to prev/next line            -- which "horizontal" keys are allowed to travel to prev/next line
}
for k, v in pairs(options) do
  vim.opt[k] = v
end
vim.opt.shortmess:append("c")                         -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append("-")                         -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" })       -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use
vim.opt.title = true
vim.opt.titlestring = "%<%F%=%l/%L - Miku"

local orig_notify = vim.notify
local filter_notify = function(text, level, opts)
  -- more specific to this case
  if type(text) == "string" and (string.find(text, "get_query", 1, true) or string.find(text, "get_node_text", 1, true)) then
    -- for all deprecated and stack trace warnings
    -- if type(text) == "string" and (string.find(text, ":help deprecated", 1, true) or string.find(text, "stack trace", 1, true)) then
    return
  end
  orig_notify(text, level, opts)
end
vim.notify = filter_notify

lvim.keys.visual_mode["J"] = ":move '>+1<CR>gv-gv"
lvim.keys.visual_mode["K"] = ":move '<-2<CR>gv-gv"
lvim.keys.visual_mode["<A-j>"] = ":move '>+1<CR>gv-gv"
lvim.keys.visual_mode["<A-Down>"] = ":move '>+1<CR>gv-gv"
lvim.keys.visual_mode["<A-k>"] = ":move '<-2<CR>gv-gv"
lvim.keys.visual_mode["<A-Up>"] = ":move '<-2<CR>gv-gv"
lvim.keys.visual_mode["<S-Down>"] = ":'<,'>t'><cr>"

lvim.keys.insert_mode["<S-Down>"] = "<cmd>t.<cr>"
lvim.keys.insert_mode["<S-Up>"] = "<cmd>t -1<cr>"
lvim.keys.insert_mode["<M-Down>"] = "<cmd>m+<cr>"
lvim.keys.insert_mode["<M-Up>"] = "<cmd>m-2<cr>"
lvim.keys.insert_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.insert_mode["<C-l>"] = "<cmd>LiveServer start<cr>"
lvim.keys.normal_mode["<S-Down>"] = "<cmd>t.<cr>"
lvim.keys.normal_mode["<S-Up>"] = "<cmd>t -1<cr>"
lvim.keys.normal_mode["<M-J>"] = "<cmd>t.<cr>"
lvim.keys.normal_mode["<M-K>"] = "<cmd>t -1<cr>"
lvim.keys.normal_mode["<M-Down>"] = "<cmd>m+<cr>"
lvim.keys.normal_mode["<M-Up>"] = "<cmd>m-2<cr>"
lvim.keys.normal_mode["<M-j>"] = "<cmd>m+<cr>"
lvim.keys.normal_mode["<M-k>"] = "<cmd>m-2<cr>"
lvim.keys.normal_mode["<C-s>"] = "<cmd>w<cr>"
lvim.keys.normal_mode["q"] = "<cmd>q<cr>"
lvim.builtin.terminal.open_mapping = "<c-t>"
lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  v = { "<cmd>2ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>2ToggleTerm size=30 direction=horizontal<cr>", "Split horizontal" },
}

lvim.builtin.alpha.dashboard.section.header.val = {
  [[███╗   ███╗██╗██╗  ██╗██╗   ██╗]],
  [[████╗ ████║██║██║ ██╔╝██║   ██║]],
  [[██╔████╔██║██║█████╔╝ ██║   ██║]],
  [[██║╚██╔╝██║██║██╔═██╗ ██║   ██║]],
  [[██║ ╚═╝ ██║██║██║  ██╗╚██████╔╝]],
  [[╚═╝     ╚═╝╚═╝╚═╝  ╚═╝ ╚═════╝ ]],
}
local function footer()
  return "Created by miku"
end
lvim.builtin.alpha.dashboard.section.footer.val = footer()
