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
        set dotenv-load := true

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
        set dotenv-load := true

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
    fmta(
      [[
        set dotenv-load := true
        bin := <>

        default: <>

        @list:
            just --list

        run:
            <>

        build:
            <>

        dev:
            <>

        console:
            <>

        open:
            gh repo view --web

        clean:
            <>

        test:
            <>

        profile *args:
            cargo build --profile profiling
            samply record target/profiling/{{ bin }} {{ args }}

        debug *args:
            cargo build
            rust-lldb -Q -- target/debug/{{ bin }} {{ args }}

        db:
            <>
      ]],
      {
        i(1, "file_name(justfile_directory())"),
        i(2, "run"),
        i(3, "cargo run"),
        i(4, "cargo build --release"),
        i(5, "watchexec -re rs,toml -- just run"),
        i(6, "evcxr"),
        i(7, "cargo clean"),
        i(8, "cargo nextest run"),
        i(9, "pgcli $DATABASE_URL"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "zig",
    fmt(
      [[
        set dotenv-load := true

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
    "xmake",
    fmta(
      [[
        bin := "<>"

        default: run

        run *args: build
            xmake run {{ bin }} {{ args }}

        build:
            xmake f -m debug
            xmake build {{ bin }}
            xmake project -k compile_commands

        release:
            xmake f -m release
            xmake build {{ bin }}

        clean:
            xmake clean

        dev *args:
            watchexec -e c,h just run {{ args }}

        open:
            gh repo view --web

        debug *args: build
            xmake run -d {{ bin }} {{ args }}

        build_tests:
            xmake build tests

        @test *args: build_tests
            xmake run tests {{ args }}
      ]],
      {
        i(1, "my_program"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "c",
    fmt(
      [[
        cc_flags := "-std=c2x"
        libs := "-Iinclude/ -Isrc/"
        build_folder := "./build"
        program_name := "{}"
        bin := build_folder / program_name

        default: {}

        run: build
            {}

        build: init
            {}

        release: init
            {}

        build_tests: init
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

        @test:
            {}
      ]],
      {
        i(1, "my_program"),
        i(2, "run"),
        i(3, "{{ bin }}"),
        i(4, "cc {{ cc_flags }} {{ libs }} -g -Wall -Wextra -Wpedantic -O0 src/*.c -o {{ bin }}"),
        i(5, "cc {{ cc_flags }} {{ libs }} -O3 src/*.c -o {{ bin }}"),
        i(6, 'cc {{ cc_flags }} {{ libs }} src/*.c test/*.c -o {{ build_folder / "tests" }}'),
        i(7, "mkdir -p build/"),
        i(8, "rm -rf build/"),
        i(9, "watchexec -e c,h just run"),
        i(10, "sudo lldb -- {{ bin }}"),
        i(11, '{{ build_folder / "tests" }}'),
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
        cc_flags := "-std=c2x"
        libs := "-Iinclude/ -Isrc/"
        build_folder := "./build"
        program_name := "{}"
        bin := build_folder / program_name

        default: {}

        run: build
            {}

        build: init
            {}

        release: init
            {}

        build_tests: init
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

        @test:
            {}
      ]],
      {
        i(1, "my_program"),
        i(2, "run"),
        i(3, "{{ bin }}"),
        i(4, "cc {{ cc_flags }} {{ libs }} -g -Wall -Wextra -Wpedantic -O0 src/*.c -o {{ bin }}"),
        i(5, "cc {{ cc_flags }} {{ libs }} -O3 src/*.c -o {{ bin }}"),
        i(6, 'cc {{ cc_flags }} {{ libs }} src/*.c test/*.c -o {{ build_folder / "tests" }}'),
        i(7, "mkdir -p build/"),
        i(8, "rm -rf build/"),
        i(9, "watchexec -e c,h just run"),
        i(10, "sudo lldb -- {{ bin }}"),
        i(11, '{{ build_folder / "tests" }}'),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "go",
    fmta(
      [[
        set dotenv-load := true

        bin := "<>"

        default: run

        @list:
            just --list

        run:
            go run {{ bin }}

        build:
            go build {{ bin }}

        dev:
            watchexec -re go,html just run

        test:
            go test -v ./tests

        db:
            pgcli $DATABASE_URL
      ]],
      {
        i(1, "cmd/api/main.go"),
      }
    ),
    { condition = conds.line_begin }
  ),
}
