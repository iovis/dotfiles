return {
  "3rd/image.nvim",
  event = "VeryLazy",
  build = false,
  config = function()
    require("image").setup({
      hijack_file_patterns = {
        "*.HEIC",
        "*.avif",
        "*.gif",
        "*.jpeg",
        "*.jpg",
        "*.png",
        "*.webp",
      },
    })
  end,
}
