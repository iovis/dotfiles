local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local conds = require("luasnip.extras.conditions")

return {
  s(
    "mpl",
    fmt(
      [[
        import matplotlib.pyplot as plt
        import numpy as np

        # evenly sampled time at 200ms intervals
        t = np.arange(0., 5., 0.2)

        # red dashes, blue squares and green triangles
        plt.plot(t, t, 'r--', t, t**2, 'bs', t, t**3, 'g^')
        plt.show()
      ]],
      {}
    ),
    { condition = conds.line_begin }
  ),
}
