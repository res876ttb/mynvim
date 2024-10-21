return {
  {
    "Mr-LLLLL/interestingwords.nvim",
    config = function()
      require("interestingwords").setup({
        search_count = true,
        navigation = true,
        scroll_center = true,
        search_key = "<leader>mm",
        cancel_search_key = "<leader>MM",
        color_key = "<leader>kk",
        cancel_color_key = "<leader>KK",
        select_mode = "loop", -- random or loop
      })
    end,
  },
}
