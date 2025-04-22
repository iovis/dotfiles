return {
  "MagicDuck/grug-far.nvim",
  version = "*",
  cmd = { "GrugFar" },
  config = function()
    require("grug-far").setup({
      engines = {
        ripgrep = { extraArgs = "--hidden" },
        astgrep = { extraArgs = "--no-ignore hidden" },
      },
      keymaps = {
        close = { n = "q" },
        syncLocations = { n = "<localleader>w" },
      },
    })
  end,
}
