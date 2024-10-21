return {
  {
    "jemag/telescope-diff.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    config = function ()
      require("telescope").load_extension("diff")
      -- Key map: <leader> + sc/sC for compare current file or pick 2 files for comparison
    end
  },
}
