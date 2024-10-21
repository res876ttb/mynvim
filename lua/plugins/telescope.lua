return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending", -- display results top->bottom
          layout_config = {
            prompt_position = "top", -- search bar at the top
          },
        },
      })
    end,
  },
}
