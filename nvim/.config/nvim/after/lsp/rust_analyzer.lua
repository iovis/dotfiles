return {
  settings = {
    ["rust-analyzer"] = {
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
