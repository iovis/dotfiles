return {
  settings = {
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
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
        },
      },
    },
  },
  cmd = {
    "rustup",
    "run",
    "stable",
    "rust-analyzer",
  },
}
