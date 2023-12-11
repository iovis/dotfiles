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
          "-W clippy::pedantic",
          "-A clippy::missing-errors-doc",
          "-A clippy::missing-panics-doc",
          "-A clippy::must-use-candidate",
          "-A clippy::needless_range_loop",
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
