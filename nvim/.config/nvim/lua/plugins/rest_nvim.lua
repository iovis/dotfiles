return {
  "rest-nvim/rest.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  commit = "8b62563", -- https://github.com/rest-nvim/rest.nvim/issues/246
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
