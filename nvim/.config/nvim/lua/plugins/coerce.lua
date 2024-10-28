return {
  "gregorias/coerce.nvim",
  version = "*",
  config = function()
    require("coerce").setup({
      default_mode_keymap_prefixes = {
        normal_mode = "cr",
        motion_mode = nil,
        visual_mode = "C",
      },
    })
  end,
}
