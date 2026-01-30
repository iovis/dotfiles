return {
  settings = {
    ["rust-analyzer"] = {
      cargo = { targetDir = true },
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      check = {
        command = "clippy",
        extraArgs = {
          "--",
          "-W",
          "clippy::pedantic",
          "-A",
          "clippy::missing-errors-doc",
          "-A",
          "clippy::missing-panics-doc",
          "-A",
          "clippy::must-use-candidate",
        },
      },
    },
  },
}
