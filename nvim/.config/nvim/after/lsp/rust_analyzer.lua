return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        targetDir = true,
      },
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      checkOnSave = {
        command = "clippy",
        extraArgs = {
          "--",
          "-Wclippy::pedantic",
          "-Aclippy::missing-errors-doc",
          "-Aclippy::missing-panics-doc",
          "-Aclippy::must-use-candidate",
          "-Aclippy::needless_range_loop",
        },
      },
    },
  },
}
