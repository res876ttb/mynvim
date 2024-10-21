-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- Easy command mode
vim.keymap.set({ "n", "v" }, ";", ":", { desc = "Enter command mode", silent = false })

-- Enable/Disable mouse mode
vim.keymap.set("n", "<leader>m", function()
  if vim.o.mouse == "a" then
    vim.o.mouse = ""
    print("Mouse mode disabled")
  else
    vim.o.mouse = "a"
    print("Mouse mode enabled")
  end
end, { desc = "Toggle mouse mode" })

-- Jump back and forth using alt + ,.
map("n", "<M-,>", "<C-o>", { desc = "Jump to previous location" })
map("n", "<M-.>", "<C-i>", { desc = "Jump to next location" })

-- Use backspace for deleting without yanking
map("n", "d", '"_X', { desc = "Delete word forward (Cut word to blackhole register)" })
map("n", "<BS>", '"_X', { desc = "Delete word forward (Cut word to blackhole register)" })
map("n", "D", '"_x', { desc = "Delete word backward (Cut word to blackhole register)" })
map("n", "<Del>", '"_x', { desc = "Delete word backward (Cut word to blackhole register)" })
map("v", "d", '"_d', { desc = "Delete selected words" })
map("v", "D", '"_d', { desc = "Delete selected words" })
map("v", "<Del>", '"_d', { desc = "Delete selected words" })

-- Paste and replace selected words in visual mode
map("v", "p", '"_dP', { desc = "Replace the selected text with yanked text" })

-- Easy indent adjust
map("i", "jk.", "<esc>>>a", { desc = "Increase indent in insert mode" })
map("i", "jk,", "<esc><<a", { desc = "Decrease indent in insert mode" })

-- Easy esc
map("i", "jk", "<esc>", { desc = "Esc with jk" })
map("i", "kj", "<esc>", { desc = "Esc with kj" })

-- Paste mode
map("n", "<leader>p", "<cmd>set paste!<cr>", { desc = "Toggle paste mode" })

-- Save file
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>wq", "<cmd>wq<cr>", { desc = "Save file and quit" })

-- Diff files
vim.keymap.set("n", "<leader>sc", function()
  require("telescope").extensions.diff.diff_current({ hidden = true })
end, { desc = "Compare/Diff file with current" })
vim.keymap.set("n", "<leader>sC", function()
  require("telescope").extensions.diff.diff_files({ hidden = true })
end, { desc = "Compare/Diff 2 files" })

-- Toggle relative line number
map("n", "<leader>rn", "<cmd>set relativenumber<cr>", { desc = "Enable relative line number" })
map("n", "<leader>nrn", "<cmd>set norelativenumber<cr>", { desc = "Disable relative line number" })

-- Get current file path of current buffer
vim.keymap.set("n", "<leader>sfp", "<cmd>echo expand('%:p')<cr>", { desc = "Get current file path" })
vim.keymap.set(
  "n",
  "<leader>yfp",
  '<cmd>let @" = expand("%:p")<cr><cmd>lua WriteDataToFile(vim.fn.expand("%:p"))<cr>',
  { desc = "Yank/copy current file path to clipboard" }
)

-- Copy entire file content
map("n", "<leader>ay", "<cmd>%y<cr>", { desc = "Copy entire file content" })

-- Easy paste in insert mode
map("i", "jkp", "<esc>pa", { desc = "Paste in insert mode" })
map("i", "jkP", "<esc>Pa", { desc = "Paste in insert mode" })

-- Legacy undo like normal editor
map("i", "<C-z>", "<esc>ui", { desc = "Undo in insert mode" })
map("n", "<C-z>", "u", { desc = "Undo in normal mode" })
map("i", "<C-r>", "<esc><C-r>i", { desc = "Redo in insert mode" })

-- Grep with args
map(
  "n",
  "<leader>//",
  ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = "Grep with args" }
)

-- Open clipboard manager
map("n", "<leader>C", "<cmd>Telescope neoclip<cr>", { desc = "Open clipboard manager" })

-- Selection
map("i", "<S-Left>", "<esc>v", { desc = "Enter visual mode in insert mode (select left)" })
map("i", "<S-Right>", "<esc><Right>v<Right>", { desc = "Enter visual mode in insert mode (select Right)" })
map("i", "<S-Up>", "<esc>v<Up>", { desc = "Enter visual mode in insert mode (select Up)" })
map("i", "<S-Down>", "<esc>v<Down>", { desc = "Enter visual mode in insert mode (select Down)" })
map("n", "<S-Left>", "v", { desc = "Enter visual mode (select left)" })
map("n", "<S-Right>", "v<Right>", { desc = "Enter visual mode (select Right)" })
map("n", "<S-Up>", "v<Up>", { desc = "Enter visual mode (select Up)" })
map("n", "<S-Down>", "v<Down>", { desc = "Enter visual mode (select Down)" })
map("v", "<S-Left>", "<Left>", { desc = "Select left in visual mode" })
map("v", "<S-Right>", "<Right>", { desc = "Select right in visual mode" })
map("v", "<S-Up>", "<Up>", { desc = "Select up in visual mode" })
map("v", "<S-Down>", "<Down>", { desc = "Select down in visual mode" })

-- Search selected text
map("v", "/", 'y/<C-r>"<CR>N', { desc = "Search selected text" })

-- Surround setting: '"[{(?<
vim.keymap.set("v", "(", "gsa(", { desc = "Add surround `(` around the selected text with space", remap = true })
vim.keymap.set("v", ")", "gsa)", { desc = "Add surround `(` around the selected text without space", remap = true })
vim.keymap.set("v", "[", "gsa[", { desc = "Add surround `[` around the selected text with space", remap = true })
vim.keymap.set("v", "]", "gsa]", { desc = "Add surround `[` around the selected text without space", remap = true })
vim.keymap.set("v", "{", "gsa{", { desc = "Add surround `{` around the selected text with space", remap = true })
vim.keymap.set("v", "}", "gsa}", { desc = "Add surround `{` around the selected text without space", remap = true })
vim.keymap.set("v", "'", "gsa'", { desc = "Add surround `'` around the selected text without space", remap = true })
vim.keymap.set("v", '"', 'gsa"', { desc = 'Add surround `"` around the selected text without space', remap = true })
-- For `<>`, we use `,.` instead of `<>` because `<>` have been reserved for adjust indent
vim.keymap.set("v", ",", "gsa<", { desc = "Add surround `<` around the selected text with space", remap = true })
vim.keymap.set("v", ".", "gsa>", { desc = "Add surround `<` around the selected text without space", remap = true })
