local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.conditions")
-- local parse = ls.parser.parse_snippet

return {
  s(
    "a",
    fmt("alias {} := {}", {
      i(1, "name"),
      i(2, "task"),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "t",
    fmt(
      [[
        {}: {}
          {}
      ]],
      {
        i(1, "name"),
        i(2),
        i(3),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "init",
    fmt(
      [[
        set dotenv-load

        default: {}

        # lists available tasks
        @list:
            just --list

        # init project
        init:
            {}

        # start the server
        dev:
            {}

        # open the project in the browser
        open:
            {}

        # start a console
        console:
            {}

        # run tests
        test:
            {}

        # Open the DB
        db:
            {}
      ]],
      {
        i(1, "init"),
        i(2, "bundle install"),
        i(3, "rails server"),
        i(4, 'open "$PROJECT_URL" -a "Google Chrome Canary"'),
        i(5, "rails console"),
        i(6, "rspec"),
        i(7, "pgcli $DATABASE_URL"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "rails",
    fmt(
      [[
        set dotenv-load

        default: {}

        full:
            tmux new-window -Sn dev just dev
            tmux new-window -Sn worker just worker

        # lists available tasks
        @list:
            just --list

        # init project
        init:
            git pull
            bundle install

        # start the server
        dev:
            {}

        # open the project in the browser
        open:
            {}

        # start the worker
        worker:
            {}

        # start a console
        console:
            {}

        # Open the DB with pgcli
        db:
            {}

        # run tests
        test:
            {}
      ]],
      {
        i(1, "init"),
        i(2, "bin/rails server"),
        i(3, 'open "$PROJECT_URL" -a "Google Chrome Canary"'),
        i(4, "bundle exec sidekiq -c 10"),
        i(5, "bin/rails console"),
        i(6, "pgcli $DATABASE_URL"),
        i(7, "bin/spring rspec"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "rust",
    fmt(
      [[
        set dotenv-load

        default: {}

        # lists available tasks
        @list:
            just --list

        run:
            {}

        build:
            {}

        dev:
            {}

        console:
            {}

        open:
            gh repo view --web

        clean:
            {}

        # run tests
        test:
            {}

        # Open the DB
        db:
            {}
      ]],
      {
        i(1, "run"),
        i(2, "cargo run"),
        i(3, "cargo build"),
        i(4, "cargo watch -x check -x 'nextest run'"),
        i(5, "evcxr"),
        i(6, "cargo clean"),
        i(7, "cargo nextest run"),
        i(8, "pgcli $DATABASE_URL"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "zig",
    fmt(
      [[
        set dotenv-load

        default: {}

        # lists available tasks
        @list:
            just --list

        run:
            {}

        build:
            {}

        dev:
            {}

        open:
            gh repo view --web

        clean:
            zig build uninstall
            rm -rf zig-cache/ zig-out/

        # run tests
        test:
            {}

        # Open the DB
        db:
            {}
      ]],
      {
        i(1, "run"),
        i(2, "zig build run"),
        i(3, "zig build -Doptimize=ReleaseSafe"),
        i(4, "watchexec -e zig just run"),
        i(5, "zig build test"),
        i(7, "pgcli $DATABASE_URL"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "cmake",
    fmta(
      [[
        bin := "build/<>"

        default: <>

        run: build
            <>

        build type="Debug": # or Release
            cmake -S. -B build -DCMAKE_BUILD_TYPE={{type}}
            cmake --build build

        clean:
            <>

        dev:
            <>

        open:
            gh repo view --web

        lldb: build
            <>

        test:
            <>

        db:
            <>
      ]],
      {
        i(1, "my_program"),
        i(2, "run"),
        i(3, "{{bin}}"),
        i(4, "rm -rf build/"),
        i(5, "watchexec -e c,h just run"),
        i(6, "sudo lldb -- {{bin}}"),
        i(7, "just run"),
        i(8, "pgcli $DATABASE_URL"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "c",
    fmt(
      [[
        cc_flags := "-std=c17 -Wall -fsanitize=address -Iinclude/" # -Wextra -Wpedantic
        libs := ""
        bin := "{}"

        default: {}

        run: build
            {}

        build: init
            {}

        release: init
            {}

        @init:
            {}

        clean:
            {}

        dev:
            {}

        open:
            gh repo view --web

        debug: build
            {}

        # run tests
        test:
            {}

        # Open the DB
        db:
            {}
      ]],
      {
        i(1, "./bin/my_program"),
        i(2, "run"),
        i(3, "{{bin}}"),
        i(4, "cc {{cc_flags}} {{libs}} -g -O0 src/*.c -o {{bin}}"),
        i(5, "cc {{cc_flags}} {{libs}} -O3 src/*.c -o {{bin}}"),
        i(6, "mkdir -p bin/"),
        i(7, "rm -rf bin/"),
        i(8, "watchexec -e c,h just run"),
        i(9, "sudo lldb -- {{bin}}"),
        i(10, "just run"),
        i(11, "pgcli $DATABASE_URL"),
      }
    ),
    { condition = conds.line_begin }
  ),
}
