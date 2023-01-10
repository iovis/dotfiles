return {
  settings = {
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "self",
      },
      procMacro = {
        enable = true,
      },
      checkOnSave = {
        command = "clippy",
        extraArgs = {
          "--",
          "-Wclippy::pedantic",
          "-Aclippy::missing-errors-doc",
          "-Aclippy::missing-panics-doc",
        },
      },
    },
  },
}
