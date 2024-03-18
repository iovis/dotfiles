return {
  "rest-nvim/rest.nvim",
  enabled = false,
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("rest-nvim").setup({
      result_split_in_place = true,
      result = {
        show_curl_command = false,
        show_http_info = true,
        show_headers = true,
      },
      jump_to_request = false,
    })
  end,
}
