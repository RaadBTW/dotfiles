-- 1. Options

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.opt.cursorlineopt = "number"
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#00ff00", bold = true })

vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.o.mouse = "a"

vim.o.showmode = false

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"

vim.o.updatetime = 250
vim.o.timeoutlen = 600

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.scrolloff = 10

-- Preview substitutions live, as you type! ==> :%s/foo/bar/g
vim.o.inccommand = "split"

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

-- 2. Keybinds

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set({ "n", "v" }, "<Home>", '<cmd>echo "Use 0/^"<CR>')
vim.keymap.set({ "n", "v" }, "<End>", '<cmd>echo "Use $"<CR>')

vim.keymap.set("i", "jk", "<Esc>", { silent = true })
vim.keymap.set("v", "jk", "<Esc>", { silent = true })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.api.nvim_set_keymap("n", "<A-i>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<A-i>", "<C-\\><C-n><cmd>ToggleTerm<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-i>", "<Esc><cmd>ToggleTerm<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- 3. Some custom commands?

vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	callback = function()
		vim.cmd("normal! zz")
	end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
vim.opt.termguicolors = true

vim.cmd([[
  highlight NotifyBackground guibg=#000000 ctermbg=0
]])

-- 4. Pluggins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	change_detection = { notify = false },
})

-- Macros
local cr = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

-- Golang error handling
vim.fn.setreg("e", "iif err != nil {" .. cr .. "}" .. esc .. "O")

-- sql show all the tables
vim.fn.setreg(
	"s",
	"i SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'  AND table_type = 'BASE TABLE' ORDER BY table_name;"
		.. esc
)

-- golang log the error
vim.fn.setreg("l", "i clogger.Error(" .. cr .. 'fmt.Sprintf("",err),' .. cr .. ")" .. esc .. "k10h")

-- golan gin Handler func
vim.fn.setreg(
	"h",
	"ifunc x() gin.HandlerFunc {" .. cr .. "return func(c *gin.Context) {" .. cr .. "}" .. cr .. "}" .. esc .. "3k0wciw"
)

-- golang gin
vim.fn.setreg(
	"g",
	"iimport ("
		.. cr
		.. '"log"'
		.. cr
		.. '"net/http"'
		.. cr
		.. '"github.com/gin-gonic/gin"'
		.. cr
		.. ")"
		.. cr
		.. cr
		.. cr
		.. "func main() {"
		.. cr
		.. "router := gin.Default()"
		.. cr
		.. cr
		.. 'router.GET("/ping", func(c *gin.Context) {'
		.. cr
		.. "c.JSON(http.StatusOK, gin.H{"
		.. cr
		.. '"message": "pong",'
		.. cr
		.. "})"
		.. cr
		.. "})"
		.. cr
		.. "if err := router.Run(GIN_PORT); err != nil {"
		.. cr
		.. 'log.Fatalf("failed to run server: %v", err)'
		.. cr
		.. "}"
		.. cr
		.. "}"
		.. esc
)
