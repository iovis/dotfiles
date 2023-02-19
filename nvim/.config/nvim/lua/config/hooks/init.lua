local cargo_hooks = require("config.hooks.cargo")
local npm_hooks = require("config.hooks.npm")
local bundler_hooks = require("config.hooks.bundler")
local rspec_hooks = require("config.hooks.rspec")

return {
  run_cargo_outdated = cargo_hooks.run_cargo_outdated,
  run_npm_outdated = npm_hooks.run_npm_outdated,
  run_bundle_outdated = bundler_hooks.run_bundle_outdated,
  run_rspec = rspec_hooks.run_rspec,
}
