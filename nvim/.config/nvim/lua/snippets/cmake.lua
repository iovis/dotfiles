return {
  s(
    "init",
    fmta(
      [[
        cmake_minimum_required(VERSION <>)
        project(<> C)

        set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

        set(CMAKE_C_STANDARD 17)
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall")

        set(
          SOURCES
          src/main.c
        )

        add_executable(<> ${SOURCES})
      ]],
      {
        i(1, "3.28"),
        i(2, "name"),
        rep(2),
      }
    ),
    { condition = conds.line_begin }
  ),
}
