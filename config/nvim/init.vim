call plug#begin()

" LSP Support
Plug 'neovim/nvim-lspconfig'                           " Required
Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'} " Optional
Plug 'williamboman/mason-lspconfig.nvim'               " Optional
" Autocompletion
Plug 'hrsh7th/nvim-cmp'         " Required
Plug 'hrsh7th/cmp-nvim-lsp'     " Required
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'} " Replace <CurrentMajor> by the latest released major (first number of latest release)
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'

Plug 'preservim/vim-markdown'
Plug 'Olical/conjure'
Plug 'PaterJason/cmp-conjure'
Plug 'kaarmu/typst.vim'
Plug 'nvim-orgmode/orgmode'

Plug 'yegappan/mru'
Plug 'nvim-tree/nvim-tree.lua'

Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'elkowar/yuck.vim'

"Plug 'lervag/vimtex'
"Plug 'iurimateus/luasnip-latex-snippets.nvim'
Plug 'rafamadriz/friendly-snippets'

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

" markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_fenced_languages = ['c=c', 'viml=vim', 'bash=sh', 'ini=dosini']

" typst ----------------------------------------------------------------------
let g:typst_pdf_viewer = 'okular'

" vimtex ---------------------------------------------------------------------
"let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_mappings_prefix = ',l'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk_engines = {
  \ '_': '-lualatex',
  \}
let g:vimtex_quickfix_ignore_filters = [
  \ 'Overfull',
  \]

" statusline -----------------------------------------------------------------
" start of default statusline
set statusline=%f\ %h%w%m%r\ 
" NOTE: preceding line has a trailing space character

" Syntastic statusline
"set statusline+=%#warningmsg#
"set statusline+=%{StatusDiagnostic()}
"set statusline+=%*

" end of default statusline (with ruler)
set statusline+=%=%(%y\ %l,%c%V\ %=\ %P%)

" vim ------------------------------------------------------------------------
"set textwidth=0
"set wrapmargin=1
"set formatoptions+=t
"set formatoptions-=l

"set nrformats+=alpha
set number
set relativenumber
set nohlsearch
"set colorcolumn=81
set nowrap
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set directory=/home/taki/.local/share/nvim/swap//
set backup
set backupdir=/home/taki/.local/share/nvim/backup//
set undofile
set undodir=/home/taki/.local/share/nvim/undo//
set shell=/usr/bin/zsh
syntax enable

set guifont=JetBrainsMono\ Nerd\ Font:h14
"let g:neovide_cursor_animation_length = 0
set termguicolors
colorscheme catppuccin-latte

set autochdir

augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" filetype -------------------------------------------------------------------
autocmd FileType org,latex,json,html,javascript,css,vim,clojure setlocal softtabstop=2 shiftwidth=2
autocmd FileType markdown,rst setlocal softtabstop=3 shiftwidth=3
autocmd FileType markdown,djot nnoremap <buffer> } /#<CR>
autocmd FileType markdown,djot nnoremap <buffer> { ?#<CR>

" maps -----------------------------------------------------------------------
let mapleader = ","

"inoremap <leader>; A;
nnoremap <leader>; A;
nnoremap <leader>nt :NvimTreeToggle<CR>
nnoremap <leader>mr :MRU<CR>
nnoremap <M-h> gT
nnoremap <M-l> gt
nnoremap <leader>q :qall<CR>
nnoremap zy "+y
nnoremap zp "+p
nnoremap zY "+Y
nnoremap zP "+P
vnoremap zy "+y
vnoremap zp "+p
vnoremap zY "+Y
vnoremap zP "+P
nnoremap <C-s> :w<CR>
inoremap <C-c> <esc>
tnoremap <esc> <C-\><C-n>

" abbr -----------------------------------------------------------------------
ab sorc source $MYVIMRC

" lsp ------------------------------------------------------------------------
lua local lsp = require('lsp-zero').preset({});lsp.on_attach(function(client, bufnr) lsp.default_keymaps({buffer = bufnr}) end);lsp.setup()
lua vim.diagnostic.config({  virtual_text=false, update_in_insert=false }); vim.o.updatetime=250;
"lua vim.api.nvim_create_autocmd("LspAttach", { callback = function(args) local client = vim.lsp.get_client_by_id(args.data.client_id) client.server_capabilities.semanticTokensProvider = nil end, });

autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})
nnoremap <silent> <leader>lsq <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>lsr <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>lsf <cmd>lua vim.lsp.buf.format()<CR>
lua require("mason").setup()

" nvim-tree ------------------------------------------------------------------
let loaded_netrw = 1
let loaded_netrwPlugin = 1
lua << EOF
require("nvim-tree").setup {
    system_open = {
        cmd  = "gio",
        args = { "open" }
    }
}
local function open_nvim_tree(data)
-- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end
-- create a new, empty buffer
  vim.cmd.enew()
-- wipe the directory buffer
  vim.cmd.bw(data.buf)
-- change to the directory
  vim.cmd.cd(data.file)
-- open the tree
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })


-- orgmode -------------------------------------------------------------------
-- Load custom treesitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = {'~/Desktop/org/*'},
  org_default_notes_file = '~/Desktop/org/refile.org',
  org_highlight_latex_and_related = nil,
})


-- lsp -----------------------------------------------------------------------
local lspconfig = require 'lspconfig'
local root_pattern = lspconfig.util.root_pattern
lspconfig.lua_ls.setup{}
lspconfig.clangd.setup{}
lspconfig.typst_lsp.setup{root_dir = root_pattern(".")}


-- luasnip setup -------------------------------------------------------------
local luasnip = require'luasnip'
require("luasnip.loaders.from_vscode").lazy_load()

-- latex-snippets ------------------------------------------------------------
--require'luasnip-latex-snippets'.setup()

-- nvim-cmp setup ------------------------------------------------------------
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'luasnip' , option = { show_autosnippets = true } },
    --{ name = 'cmp_luasnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'orgmode' },
    --{ name = 'conjure' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-f>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-b>'] = cmp.mapping.scroll_docs(4), -- Down
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
}

--[[
local root_pattern = require'lspconfig'.util.root_pattern
require'lspconfig'.clojure_lsp.setup{
  settings = {
    cmd = { "clojure-lsp" },
    filetypes = { "clojure", "edn" },
    root_dir = root_pattern("*")
  }
}
]]--

EOF
