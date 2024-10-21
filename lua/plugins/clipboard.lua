-- Write yanked text to file
function WriteClipboardToFile()
  WriteDataToFile(vim.fn.getreg('\"'))
end

function WriteDataToFile(data)
  local defaultPath = os.getenv("HOME") .. "/.nvim_clipboard"
  local filepath = os.getenv("NVIM_CLIPBOARD_FILEPATH")
  if filepath == nil then
    filepath = defaultPath
  end

  local fio = io.open(filepath, 'w')
  if fio ~= nil then
    fio:write(data)
    fio:close()
  else
    print("Failed to open file " .. filepath)
  end
end

-- Register a autocmd to redirect yanked text to files
local commands = {
  "augroup yank2file",
  "autocmd!",
  "autocmd TextYankPost * :lua WriteClipboardToFile()",
  "augroup end",
}
vim.cmd(table.concat(commands, "\n"))

return {
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "kkharji/sqlite.lua", module = "sqlite" },
    },
    config = function()
      require("neoclip").setup({
        -- The following setting makes neoclip fail, need to enable them back once the issue is fixed
        -- enable_persistent_history = true,
        -- continuous_sync = true,
      })
    end,
  },
}
