
-- rocks -----------------------------------------------------------------------
local rocks_config = {
	rocks_path = vim.env.HOME .. "/.local/share/nvim/rocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
	vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
	vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
	vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
	vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "*", "*"))


-- statusline ------------------------------------------------------------------
vim.opt.statusline = '%f %h%w%m%r ' .. '%=%(%y %l,%c%V %= %P%)'


--  vim ------------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.wrap = false
-- vim.opt.expandtab = true
vim.cmd('set cinoptions+=(1s')
-- vim.opt.list = false
-- vim.opt.listchars = 'tab:\\ \\ '
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
vim.cmd('syntax enable')
vim.opt.foldenable = false

vim.opt.guifont = 'JetBrainsMono Nerd Font:h14'
vim.opt.termguicolors = true
-- vim.cmd('colorscheme komau')
vim.g.komau_italic = 0
vim.g.everforest_background = 'hard'
vim.cmd('colorscheme everforest')

vim.opt.autochdir = true


-- maps ----------------------------------------------------------------------
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

nmap('<leader>ff', '<cmd>Telescope file_browser<cr>')
nmap('<leader>fb', '<cmd>Telescope buffers<cr>')
nmap('<leader>fr', '<cmd>Telescope oldfiles<cr>')
nmap('<leader>nt', '<cmd>NvimTreeToggle<cr>')
nmap('<leader>mr', '<cmd>MRU<cr>')

vmap('<leader>s', [[:s/\%V\v(\S+) (\S+)/\2 \1/<cr>]])

nmap('<C-s>', '<cmd>w<cr>')
nmap('z;', 'A;')
nmap('<M-h>', 'gT')
nmap('<M-l>', 'gt')
nmap('<leader>q', '<cmd>qall<cr>')

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
vim.cmd('ab sorc source $MYVIMRC')


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

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = { '*.hack', '*.asm' },
	command = 'set ft=txt',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = { '*.tex', '*.lua', '*.html' },
	callback = function()
		vim.opt_local.tabstop = 3
		vim.opt_local.shiftwidth = 3
		-- vim.opt_local.autoindent = true
		-- vim.opt_local.smartindent = false
		-- vim.opt_local.cindent = false
		-- vim.opt_local.indentexpr = nil
	end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = { '*.json', '*.svelte', '*.jsx', '*.js' },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
	pattern = { '*.dj' },
	callback = function()
		vim.opt_local.filetype = 'djot'
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
	pattern = { '*.http' },
	callback = function()
		vim.opt_local.filetype = 'http'

		vim.api.nvim_buf_set_keymap( 'n', '<leader>r',
			'<cmd>Rest run<cr>',
			{ noremap = true, silent = true }
		)
	end,
})


-- nvim tree -----------------------------------------------------------------
require("nvim-tree").setup()


-- treesitter setup ----------------------------------------------------------
require('nvim-treesitter.configs').setup({
	ensure_installed = { 'javascript', 'typescript', 'latex', 'lua', 'c', 'cpp', 'java', 'python', 'bash' },
	ignore_install = { 'hack' },
	indent = { enable = true },
	auto_install = true,
	highlight = { enable = true },
})


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
				-- ["ac"] = "@class.outer",
				-- You can optionally set descriptions to the mappings (used in the desc parameter of
				-- nvim_buf_set_keymap) which plugins like which-key display
				-- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				-- You can also use captures from other query groups like `locals.scm`
				-- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
			},
			-- You can choose the select mode (default is charwise 'v')
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * method: eg 'v' or 'o'
			-- and should return the mode ('v', 'V', or '<c-v>') or a table
			-- mapping query_strings to modes.
			-- selection_modes = {
			-- 	['@parameter.outer'] = 'v', -- charwise
			-- 	['@function.outer'] = 'V', -- linewise
			-- 	['@class.outer'] = '<c-v>', -- blockwise
			-- },
			-- If you set this to `true` (default is `false`) then any textobject is
			-- extended to include preceding or succeeding whitespace. Succeeding
			-- whitespace has priority in order to act similarly to eg the built-in
			-- `ap`.
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * selection_mode: eg 'v'
			-- and should return true or false
			-- include_surrounding_whitespace = true,
		},
	},
}


-- neorg setup ---------------------------------------------------------------
require("neorg").setup({
	load = {
		["core.defaults"] = {},
		-- ["core.concealer"] = {
		--	 config = {
		--		 icons = false,
		--	 },
		-- }, -- We added this line!
		["core.export"] = {},
	}
})


-- Comment.nvim --------------------------------------------------------------
require('Comment').setup()


-- autoclose -----------------------------------------------------------------
require('autoclose').setup()


-- rest.nvim -----------------------------------------------------------------
require('rest-nvim').setup({})


-- luasnip setup -------------------------------------------------------------
local luasnip = require'luasnip'
require("luasnip.loaders.from_vscode").lazy_load()


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


-- lazydev.nvim --------------------------------------------------------------
require('lazydev').setup()


-- mason ---------------------------------------------------------------------
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,

		clangd = function()
			require('lspconfig').clangd.setup({
				cmd = {
					"clangd",
					"--header-insertion=never",
				},
			})
		end,
	},
})


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
		-- { name = 'cmp_luasnip' },
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'path' },
		-- { name = 'conjure' },
	},
	mapping = cmp.mapping.preset.insert({
		['<C-f>'] = cmp.mapping.scroll_docs(4), -- Down
		['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Up
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