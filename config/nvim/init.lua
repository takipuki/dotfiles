
-- vim-plug --------------------------------------------------------------------
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('nvim-treesitter/nvim-treesitter')
Plug('nvim-treesitter/nvim-treesitter-textobjects')

Plug('catppuccin/nvim')
Plug('Tsuzat/NeoSolarized.nvim')
Plug('ntk148v/komau.vim')
Plug('kdheepak/monochrome.nvim')
Plug('sainnhe/everforest')
Plug('nvim-tree/nvim-web-devicons')

Plug('VonHeikemen/lsp-zero.nvim')
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')

Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('saadparwaiz1/cmp_luasnip')

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { ['branch'] = '0.1.x' })
Plug('nvim-telescope/telescope-file-browser.nvim')
Plug('smartpde/telescope-recent-files')
Plug('stevearc/oil.nvim')
Plug('yegappan/mru')

Plug('Olical/conjure')

Plug('L3MON4D3/LuaSnip')
Plug('rafamadriz/friendly-snippets')
Plug('dhruvasagar/vim-table-mode')
Plug('junegunn/vim-easy-align')
Plug('m4xshen/autoclose.nvim')
vim.call('plug#end')


-- statusline ------------------------------------------------------------------
vim.opt.statusline = '%f %h%w%m%r ' .. '%=%(%y %l,%c%V %= %P%)'


--  vim ------------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.cmd('set cinoptions+=(s,l1,:0')
vim.cmd('set list lcs=tab:\\ \\ ')
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.directory = '/home/taki/.local/share/nvim/swap//'
vim.opt.backup = true;
vim.opt.backupdir = '/home/taki/.local/share/nvim/backup//'
vim.opt.undofile = true
vim.opt.undodir = '/home/taki/.local/share/nvim/undo//'
vim.opt.shell = '/usr/bin/zsh'
vim.cmd('set nocompatible')
vim.cmd('filetype plugin on')
vim.g.rust_recommended_style = false
vim.cmd('syntax off')
vim.opt.foldenable = false

vim.opt.guifont = 'JetBrains Mono:h14'
vim.opt.termguicolors = true
vim.opt.background = 'light'
vim.g.komau_italic = 0
vim.cmd('colorscheme komau')

vim.opt.autochdir = true


-- mappings ------------------------------------------------------------------
vim.g.mapleader = ','
vim.g.maplocalleader = ','

local function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
	map('n', shortcut, command)
end

local function imap(shortcut, command)
	map('i', shortcut, command)
end

local function vmap(shortcut, command)
	map('v', shortcut, command)
end

vim.keymap.set('n', 'gy',
	function()
		vim.fn.setreg('+', vim.api.nvim_buf_get_lines(0, 0, -1, false))
	end,
	{ noremap = true, silent = true }
)

vim.keymap.set('n', 'zc',
	function()
		local current_line = vim.fn.getline('.')
		local new_line = current_line..current_line:gsub('^%s+', '', 1):gsub('^%S+', ' cin >>', 1):gsub(',', ' >>')
		vim.fn.setline(vim.fn.line('.'), new_line)
	end,
	{ noremap = true, silent = true }
)
nmap('zt', "<cmd>norm 'tgcc<cr>")

nmap('<leader>ff', '<cmd>Telescope file_browser<cr>')
nmap('<leader>fb', '<cmd>Telescope buffers<cr>')
nmap('<leader>fr', '<cmd>Telescope recent_files<cr>')
nmap('<leader>nt', '<cmd>Oil<cr>')
nmap('<leader>mr', '<cmd>MRU<cr>')

vmap('zs', [[:s/\%V\v(\S+) (\S+)/\2 \1/<cr>]])

nmap('<C-s>', '<cmd>w<cr>')
nmap('z;', 'A;')
nmap('z,', 'A,')
nmap('<M-h>', 'gT')
nmap('<M-l>', 'gt')
nmap('<leader>q', '<cmd>%bd<cr>')

nmap('zy', '"+y')
nmap('zp', '"+p')
nmap('zY', '"+Y')
nmap('zP', '"+P')
vmap('zy', '"+y')
vmap('zp', '"+p')
vmap('zY', '"+Y')
vmap('zP', '"+P')

imap('<C-c>', '<esc>')
vim.cmd('tnoremap <esc> <C-\\><C-n>')


-- abbr ----------------------------------------------------------------------
vim.cmd('cabbrev sorc source $MYVIMRC')


-- event listeners -----------------------------------------------------------
vim.api.nvim_create_autocmd({ 'ColorScheme', 'BufRead', 'BufNewFile' }, {
	pattern = { '*' },
	callback = function()
		vim.cmd('highlight trailingwhitespace ctermbg=grey guibg=grey')
		vim.cmd('match trailingwhitespace /\\s\\+$/')
		vim.cmd('au InsertEnter * match trailingwhitespace //')
		vim.cmd('au InsertLeave,BufRead * match trailingwhitespace /\\s\\+$/')
	end,
})

function autocmd(pat, cmd)
	vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
		pattern = pat,
		command = cmd,
	})
end

function autofn(pat, fn)
	vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
		pattern = pat,
		callback = fn,
	})
end

autofn({ '*.cpp', }, function()
	vim.cmd('iabbrev <buffer> ci cin >>')
	vim.cmd('iabbrev <buffer> co cout <<')
	vim.cmd('iabbrev <buffer> ll int64_t')
	vim.cmd('iabbrev <buffer> str string')
	vim.cmd('iabbrev <buffer> v< vector<')
	vim.cmd('iabbrev <buffer> p< pair<')
	vim.cmd('iabbrev <buffer> m< map<')
	vim.cmd('iabbrev <buffer> s< set<')
	vim.cmd('iabbrev <buffer> a< array<')
	vim.cmd('iabbrev <buffer> vi vector<int>')
	vim.cmd('iabbrev <buffer> vvi vector<vector<int>>')
	vim.cmd('iabbrev <buffer> vll vector<int64_t>')
	vim.cmd('iabbrev <buffer> vvll vector<vector<int64_t>>')
end)

autocmd({ '*.zig', '*.py' },
	'setlocal sw=4 ts=4'
)

autocmd({ '*.typ', '*.latex', '*.tex', '*.lua', '*.html', '*.json', '*.svelte', '*.jsx', '*.js', '*.mjs', '*.lisp', '*.scm', '*.clj', '*.djot', },
	'setlocal sw=2 ts=2'
)

autocmd({ '*.lisp', '*.scm', '*.clj', '*.hs', '*.djot', },
	'setlocal expandtab'
)


-- server --------------------------------------------------------------------
if vim.g.neovide then
	vim.fn.serverstart('/tmp/neovide.pipe')
end


-- oil -----------------------------------------------------------------------
require('oil').setup()


-- treesitter setup ----------------------------------------------------------
require('nvim-treesitter.configs').setup({
	ignore_install = { 'hack' },
	indent = {
		enable = true,
		disable = { 'c', 'cpp', }
	},
	auto_install = true,
	highlight = { enable = true },
})
vim.api.nvim_set_hl(0, "@variable.builtin", { link = "@variable" })
vim.api.nvim_set_hl(0, "@variable.parameter", { link = "@variable" })
vim.api.nvim_set_hl(0, "@variable.parameter.builtin", { link = "@variable" })
vim.api.nvim_set_hl(0, "@variable.member", { link = "@variable" })
vim.api.nvim_set_hl(0, "@module.builtin", { link = "@module" })
vim.api.nvim_set_hl(0, "@function.builtin", { link = "@function" })
vim.api.nvim_set_hl(0, "@constructor", { link = "@function" })
vim.api.nvim_set_hl(0, "@type.builtin", { link = "@type" })
vim.api.nvim_set_hl(0, "@string.special.symbol.clojure", { link = "@variable.clojure" })


-- treesitter text objects ---------------------------------------------------
require'nvim-treesitter.configs'.setup {
	textobjects = {
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},

		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
	},
}


-- autoclose -----------------------------------------------------------------
require('autoclose').setup({
	options = {
		disable_command_mode = true,
	},
	keys = {
		["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = { 'lisp', 'scheme', 'clojure' } },
		['`'] = { escape = true, close = true, pair = '``', disabled_filetypes = { 'lisp', 'scheme', 'clojure' } },
	},
})


-- telescope.nvim -----------------------------------------------------------------
require('telescope').load_extension('recent_files')
require('telescope').setup {
	defaults = {
		preview = false,
	},
  pickers = {
    buffers = {
      mappings = {
        i = {
          ['<c-d>'] = 'delete_buffer',
        }
      }
    }
  }
}


-- lsp zero ------------------------------------------------------------------
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({buffer = bufnr})
end)

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = false,
})
-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,InsertLeave * lua vim.diagnostic.open_float(nil, {focus=false})]]


-- mason ---------------------------------------------------------------------
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,

		clangd = function()
			-- require('lspconfig').clangd.setup({
			-- 	cmd = {
			-- 		"clangd",
			-- 		"--header-insertion=never",
			-- 	},
			-- })
		end,

		lua_ls = function()
			require('lspconfig').lua_ls.setup({
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = 'LuaJIT'
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME
								-- Depending on the usage, you might want to add additional paths here.
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							}
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
							-- library = vim.api.nvim_get_runtime_file("", true)
						}
					})
				end,
				settings = {
					Lua = {}
				}
			})
		end,
	},
})


-- conjure -------------------------------------------------------------------
vim.g['conjure#log#hud#enabled'] = false


-- luasnip -------------------------------------------------------------------
require("luasnip.loaders.from_vscode").lazy_load()


-- nvim-cmp ------------------------------------------------------------------
local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = 'luasnip' , option = { show_autosnippets = true } },
		{ name = 'nvim_lsp' },
		{
			name = 'buffer',
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = 'path' },
	},
	mapping = cmp.mapping.preset.insert({
		['<C-f>'] = cmp.mapping.scroll_docs(4), -- Down
		['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Up
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<C-s>'] = cmp.mapping(function(fallback)
			if luasnip.expandable() then
				luasnip.expand()
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
