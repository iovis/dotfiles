local u = require("user.utils")

u.command("ReloadPlugins", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^plugins") then
      package.loaded[name] = nil
      require(name)
    end
  end
end)
