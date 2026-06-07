-- Optional discipline plugin (commented out by default)
-- local discipline = require("craftzdog.discipline")
-- discipline.cowboy()

-- Shortcuts for defining keymaps
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- =========================================================
-- Register behavior (preventing clipboard/register overwrite)
-- =========================================================

-- Delete a character without copying it to any register
keymap.set("n", "x", '"_x')

-- Paste from the last yank (register 0), not from deleted text
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')

-- Change text without copying it
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')

-- Delete text without copying it
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- =========================================================
-- Basic editing and navigation
-- =========================================================

-- Increment/decrement numbers under cursor
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete word backwards (visual-select then delete silently)
keymap.set("n", "dw", 'vb"_d')

-- Select all text in the current buffer
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Open a new line below/above, clearing auto-indent, and enter insert mode
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Move forward in the jump list (acts like redo for jumps)
keymap.set("n", "<C-m>", "<C-i>", opts)

-- =========================================================
-- Tabs and window management
-- =========================================================

-- Create a new tab
keymap.set("n", "te", ":tabedit")

-- Navigate between tabs
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window horizontally or vertically
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move between split windows
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize windows with Ctrl + arrow keys
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- =========================================================
-- Diagnostics (LSP)
-- =========================================================

-- Jump to next diagnostic message
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

-- =========================================================
-- LSP utilities
-- =========================================================

-- Toggle inlay hints (LSP feature)
keymap.set("n", "<leader>i", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

-- Command to toggle autoformatting
vim.api.nvim_create_user_command("ToggleAutoformat", function()
  require("lazyvim.util").format.toggle()
end, {})

-- =========================================================
-- (Optional) Save with root permission
-- =========================================================
-- Not currently active
-- vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})
