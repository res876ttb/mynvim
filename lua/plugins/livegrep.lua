return {
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    config = function ()
      local telescope = require("telescope")
      telescope.load_extension("live_grep_args")
    end,
  }
}
