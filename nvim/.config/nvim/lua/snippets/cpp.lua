-- C header files (*.h)
---@param node "i"|"t"
---@return function
local function module_name(node)
  return function()
    local path = vim.fn.expand("%:t:r")

    if node == "t" then
      return sn(nil, t(path))
    elseif node == "i" then
      return sn(nil, i(1, path))
    else
      assert(false, "messed up")
    end
  end
end

return {
  s("pragma", t("#pragma once"), {
    condition = conds.line_begin,
  }),
  s(
    "include",
    fmt([[#include {}]], {
      c(1, {
        fmt([[<{}.h>]], { i(1, "stdio") }),
        fmt([["{}.h"]], { d(1, module_name("i")) }),
      }),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "f",
    fmta([[<ret_type> <fname>(<args>);]], {
      ret_type = i(1, "void"),
      fname = i(2, "fname"),
      args = i(3, "void"),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "st",
    c(1, {
      fmta(
        [[
          typedef struct {
            <>
          } <>;
        ]],
        {
          r(2, "body", i(2)),
          r(1, "name", i(1)),
        }
      ),
      fmta(
        [[
          struct <> {
            <>
          };
        ]],
        {
          r(1, "name", i(1)),
          r(2, "body", i(2)),
        }
      ),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "modtest",
    fmta(
      [[
        #ifdef TEST
        void <test_name>_tests(void);
        #endif
      ]],
      {
        test_name = d(1, module_name("t")),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "clangformat",
    fmt(
      [[
        // clang-format off
        {visual_selection}
        // clang-format on
      ]],
      {
        visual_selection = dl(1, l.LS_SELECT_DEDENT),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "base",
    fmta(
      [[
        #pragma once

        #include <<stdio.h>>  // IWYU pragma: keep (fprintf)
        #include <<stdlib.h>> // IWYU pragma: keep (abort)

        typedef float f32_t;
        typedef double f64_t;

        #define panic(fmt, ...)                                                                                                \
          do {                                                                                                                 \
            fprintf(stderr, "[%s:%d:%s] panic: " fmt "\n", __FILE__, __LINE__, __func__ __VA_OPT__(, ) __VA_ARGS__);           \
            abort();                                                                                                           \
          } while (0)

        #define expect(cond, ...)                                                                                              \
          do {                                                                                                                 \
            if (!(cond)) {                                                                                                     \
              fprintf(stderr, "[%s:%d:%s] panic: expectation failed: %s", __FILE__, __LINE__, __func__, #cond);                \
              __VA_OPT__(fprintf(stderr, ": "); fprintf(stderr, __VA_ARGS__);)                                                 \
              fputc('\n', stderr);                                                                                             \
              abort();                                                                                                         \
            }                                                                                                                  \
          } while (0)

        #ifndef NDEBUG
        #define dbg(fmt, ...)                                                                                                  \
          do {                                                                                                                 \
            fprintf(stderr, "[%s:%d:%s] " fmt "\n", __FILE__, __LINE__, __func__ __VA_OPT__(, ) __VA_ARGS__);                  \
          } while (0)
        #else
        #define dbg(...)                                                                                                       \
          do {                                                                                                                 \
          } while (0)
        #endif
      ]],
      {}
    ),
    { condition = conds.line_begin }
  ),
}
