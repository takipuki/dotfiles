
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
Plug('nvim-tree/nvim-tree.lua')
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
vim.opt.virtualedit = 'all'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.cinoptions:append({ '(s', 'l1', ':0', 'g0' })
vim.opt.list = true
vim.opt.listchars = { tab = '| ', trail = '~' }
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.directory = '/home/taki/.local/share/nvim/swap//'
vim.opt.backup = true;
vim.opt.backupdir = '/home/taki/.local/share/nvim/backup//'
vim.opt.undofile = true
vim.opt.undodir = '/home/taki/.local/share/nvim/undo//'
vim.opt.shell = '/usr/bin/bash'
vim.opt.shelltemp = false
vim.opt.foldenable = false
vim.cmd('filetype plugin on')
vim.cmd('filetype indent off')
vim.cmd('syntax off')
vim.g.rust_recommended_style = false

-- vim.opt.guifont = 'Fixedsys Excelsior,JetBrains Mono,Symbols Nerd Font Mono:h18'
vim.opt.linespace = 0
vim.opt.termguicolors = true
vim.opt.background = 'light'
vim.cmd('highlight! link ColorColumn CursorColumn')

vim.opt.autochdir = true

-- Uncomment the following to have Vim jump to the last position when reopening
-- a file
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])


-- helper functions ----------------------------------------------------------
function merge(a, b)
	for _,val in ipairs(b) do a[#a+1] = val end
	return a
end

function except(a, b)
	local set_b = {}
	for _,val in pairs(b) do set_b[val] = true end

	local t = {}
	for _,val in pairs(a) do
		if not set_b[val] then
			t[#t+1] = val
		end
	end

	return t
end

local function map(mode, trigger, callback)
	vim.keymap.set(mode, trigger, callback, { noremap = true, silent = true })
end

local function nmap(trigger, callback)
	map('n', trigger, callback)
end

local function imap(trigger, callback)
	map('i', trigger, callback)
end

local function vmap(trigger, callback)
	map('v', trigger, callback)
end

local function nvmap(trigger, callback)
	map({ 'n', 'v' }, trigger, callback)
end

function autocmd(pat, cmd)
	vim.api.nvim_create_autocmd('FileType', {
		pattern = pat,
		command = cmd,
	})
end

function autofn(pat, fn)
	vim.api.nvim_create_autocmd('FileType', {
		pattern = pat,
		callback = fn,
	})
end


-- mappings ------------------------------------------------------------------
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.cmd([[ nmap <space> , ]])
vim.cmd([[ vmap <space> , ]])

vmap('<leader>f', [[<cmd>'<,'>s/\<\([ij]\)\>/\=nr2char(char2nr(submatch(1)[0])+1)/g<cr>]])

nmap('<leader>ff', '<cmd>Telescope file_browser<cr>')
nmap('<leader>fb', '<cmd>Telescope buffers<cr>')
nmap('<leader>fr', '<cmd>Telescope recent_files<cr>')
nmap('<leader>nt', '<cmd>NvimTreeOpen %:h<cr>')
nmap('<leader>mr', '<cmd>MRU<cr>')

nmap('<C-s>', '<cmd>w<cr>')
nmap('<leader>;', 'A;')
nmap('<leader>,', 'A,')
nmap('<M-h>', 'gT')
nmap('<M-l>', 'gt')
nmap('<M-H>', '<cmd>tabmove -1<cr>')
nmap('<M-L>', '<cmd>tabmove +1<cr>')
nmap('<leader>q', '<cmd>%bd<cr>')

nvmap('<leader>y', '"+y')
nvmap('<leader>p', '"+p')
nvmap('<leader>Y', '"+Y')
nvmap('<leader>P', '"+P')

imap('<C-c>', '<esc>')
vim.cmd('tnoremap <esc> <C-\\><C-n>')

nmap('gy', function()
	vim.fn.setreg('+', vim.api.nvim_buf_get_lines(0, 0, -1, false))
end)

nmap('<leader>cc', function()
	local current_line = vim.fn.getline('.')
	local new_line = current_line..current_line:gsub('^%s+', '', 1):gsub('^%S+', ' cin >>', 1):gsub(',', ' >>')
	vim.fn.setline(vim.fn.line('.'), new_line)
end)

nmap('<leader>ciw', function()
	local find = vim.fn.expand('<cword>')
	local replace = vim.fn.input('Replace: ')
	vim.cmd(string.format([[%%s/\<%s\>/%s/g]], find, replace))
end)
vmap('<leader>ciw', function()
	local find = vim.fn.expand('<cword>')
	local replace = vim.fn.input('Replace: ')
	vim.fn.feedkeys(string.format([[:'<,'>s/\<%s\>/%s/g]], find, replace))
end)


-- abbr ----------------------------------------------------------------------
vim.cmd('cabbrev sorc source $MYVIMRC')


-- event listeners -----------------------------------------------------------
-- vim.api.nvim_create_autocmd({ 'ColorScheme', 'BufRead', 'BufNewFile' }, {
-- 	pattern = { '*' },
-- 	callback = function()
-- 		vim.cmd('highlight trailingwhitespace ctermbg=grey guibg=grey')
-- 		vim.cmd('match trailingwhitespace /\\s\\+$/')
-- 		vim.cmd('au InsertEnter * match trailingwhitespace //')
-- 		vim.cmd('au InsertLeave,BufRead * match trailingwhitespace /\\s\\+$/')
-- 	end,
-- })

autocmd({ 'c', 'cpp', }, 'setlocal cindent')

autocmd({ 'typst', 'tex', 'lua', 'php', 'html', 'css', 'json', 'svelte',  'javascript', 'lisp', 'scheme', 'clojure', 'djot', },
	'setlocal sw=2 ts=2'
)

autocmd({ 'fsharp', 'svelte', 'js', 'text', 'tex', 'html', 'css', 'lisp', 'scheme', 'clojure', 'haskell', 'djot', },
	'setlocal expandtab'
)

autocmd({ 'tex', },
	'setlocal spell colorcolumn=80 indentexpr&'
)


-- neovide -------------------------------------------------------------------
vim.g.neovide_cursor_trail_size = 0.5
if vim.g.neovide and not vim.g.neovide_initialized then
	vim.g.neovide_initialized = true
	_ = os.remove('/tmp/neovide.pipe') or nil
	_ = vim.fn.serverstart('/tmp/neovide.pipe') or nil
	nmap('<C-=>', function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1 end)
	nmap('<C-->', function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1 end)
	nmap('<C-0>', function() vim.g.neovide_scale_factor = 1 end)
end


-- nvim-tree -----------------------------------------------------------------
require('nvim-tree').setup({
	update_focused_file = { enable = true },
	renderer = {
		highlight_opened_files = 'all',
	},
	git = { enable = false },
})


-- komau ---------------------------------------------------------------------
require('komau').setup({
	style = 'auto',
	transparent = false,
	dim_inactive = false,
	terminal_colors = true,
	styles = {
		comments = { italic = false },
		keywords = { bold = false },
		functions = {},
		strings = {},
		variables = {},
	},
	integrations = {
		treesitter = true,
		lsp = false,
		diagnostics = false,
		cmp = false,
		telescope = false,
		gitsigns = false,
		nvimtree = false,
		trouble = false,
		hop = false,
		which_key = false,
		indent_blankline = false,
		notify = false,
		mini = false,
		dashboard = false,
		statusline = {
			lightline = false,
			lualine = false,
		},
	},
})

vim.cmd.colorscheme('everforest')


-- treesitter setup ----------------------------------------------------------
local filetypes = {
	'c', 'cpp', 'rust', 'odin',
	'html', 'css', 'javascript', 'php', 'svelte',
	'zsh', 'bash',
	'python', 'clojure', 'fsharp',
	'latex', 'markdown',
	'make',
	'vim', 'hyprlang',
}
require('nvim-treesitter').install(filetypes)
autofn(merge(filetypes, { 'sh', }),
	function()
		vim.treesitter.start()
	end
)
autofn(except(filetypes, { 'c', 'cpp', 'clojure', 'fsharp', }),
	function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
)
vim.api.nvim_set_hl(0, "@constant.builtin", { link = "@constant" })
vim.api.nvim_set_hl(0, "@variable.builtin", { link = "@variable" })
vim.api.nvim_set_hl(0, "@variable.parameter", { link = "@variable" })
vim.api.nvim_set_hl(0, "@variable.parameter.builtin", { link = "@variable" })
vim.api.nvim_set_hl(0, "@variable.member", { link = "@variable" })
vim.api.nvim_set_hl(0, "@module.builtin", { link = "@module" })
vim.api.nvim_set_hl(0, "@function.builtin", { link = "@function" })
vim.api.nvim_set_hl(0, "@function.macro", { link = "@function" })
vim.api.nvim_set_hl(0, "@constructor", { link = "@function" })
vim.api.nvim_set_hl(0, "@type.builtin", { link = "@type" })
vim.api.nvim_set_hl(0, "@string.special", { link = "@string" })
vim.api.nvim_set_hl(0, "@string.escape", { link = "@string" })
vim.api.nvim_set_hl(0, "@punctuation.special", { link = "@punctuation" })
vim.api.nvim_set_hl(0, "@string.special.symbol.clojure", { link = "@variable.clojure" })
vim.api.nvim_set_hl(0, "@tag", { link = "@tag.builtin" })


-- treesitter text objects ---------------------------------------------------
require('nvim-treesitter-textobjects').setup {
	select = {
		lookahead = false,
		-- linewise: V, charwise: v, blockwise: <c-v>
		selection_modes = {
			['@function.outer'] = 'V',
			['@function.inner'] = 'V',
			['@class.outer'] = 'V',
			['@class.inner'] = 'V',
		},
		include_surrounding_whitespace = false,
	},
}

vim.keymap.set({ 'x', 'o' }, 'af', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'x', 'o' }, 'if', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
end)
vim.keymap.set({ 'x', 'o' }, 'aa', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@parameter.outer', 'textobjects')
end)
vim.keymap.set({ 'x', 'o' }, 'ia', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@parameter.inner', 'textobjects')
end)
vim.keymap.set('n', '<leader>a', function()
	require('nvim-treesitter-textobjects.swap').swap_next '@parameter.inner'
end)
vim.keymap.set('n', '<leader>A', function()
	require('nvim-treesitter-textobjects.swap').swap_previous '@parameter.outer'
end)


-- autoclose -----------------------------------------------------------------
-- require('autoclose').setup({
-- 	options = {
-- 		disable_command_mode = true,
-- 	},
-- 	keys = {
-- 		["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = { 'lisp', 'scheme', 'clojure' } },
-- 		['`'] = { escape = true, close = true, pair = '``', disabled_filetypes = { 'lisp', 'scheme', 'clojure' } },
-- 	},
-- })


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
	automatic_enable = false,
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
vim.g['conjure#client_on_load'] = false


-- luasnip -------------------------------------------------------------------
require('luasnip.loaders.from_vscode').lazy_load({
	include = { 'tex', 'latex', 'html', 'php' }
})


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
				get_bufnrs = vim.api.nvim_list_bufs
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
