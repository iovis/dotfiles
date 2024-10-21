return {
  "gregorias/coerce.nvim",
  tag = "v3.0.0",
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
