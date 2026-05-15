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
    "c",
    fmta(
      [[
        cc := "clang"
        libs := ""
        cc_flags := "-std=c23 -fdefer-ts -D_GNU_SOURCE -Wall -Wextra -Wpedantic"
        sanitize_flags := "-fsanitize=address,undefined -fno-omit-frame-pointer"
        debug_flags := f"{{cc_flags}} -g -O0"
        release_flags := f"{{cc_flags}} -O3 -DNDEBUG"

        program_name := file_name(justfile_directory())
        build_dir := "./build"
        debug_dir := build_dir / "debug"
        release_dir := build_dir / "release"
        test_dir := build_dir / "debug"
        debug_bin := debug_dir / program_name
        release_bin := release_dir / program_name
        test_bin := test_dir / f"{{program_name}}_test"

        default: run

        alias r := run
        run *args: build_debug
            {{ debug_bin }} {{ args }}

        alias build := build_debug
        build_debug: init
            {{ cc }} {{ debug_flags }} {{ sanitize_flags }} src/main.c -o {{ debug_bin }} {{ libs }}

        alias rr := run_release
        run_release *args: build_release
            {{ release_bin }} {{ args }}

        alias release := build_release
        build_release: init
            {{ cc }} {{ release_flags }} src/main.c -o {{ release_bin }} {{ libs }}

        alias t := run_test
        alias test := run_test
        run_test: build_test
            {{ test_bin }}

        build_test: init
            {{ cc }} {{ debug_flags }} {{ sanitize_flags }} -DTEST src/main_test.c -o {{ test_bin }} {{ libs }}

        alias db := compiledb
        compiledb:
            bear -- just clean build_debug build_test

        alias w := watch
        alias dev := watch
        watch:
            watchexec -c clear -e c,h just run

        alias wt := watch_test
        watch_test:
            watchexec -c clear -e c,h just test

        alias d := debug
        debug *args: build_debug
            ASAN_OPTIONS=detect_leaks=0 lldb -o "b main" -o "run" -- {{ debug_bin }} {{ args }}

        alias dt := debug_test
        debug_test *args: build_test
            ASAN_OPTIONS=detect_leaks=0 lldb -- {{ test_bin }} {{ args }}

        alias v := valgrind
        valgrind *args: build_valgrind
            valgrind --tool=memcheck --leak-check=full --track-origins=yes {{ debug_bin }} {{ args }}

        build_valgrind: init
            {{ cc }} {{ debug_flags }} src/main.c -o {{ debug_bin }} {{ libs }}

        alias c := callgrind
        callgrind *args: build_callgrind
            valgrind --tool=callgrind --callgrind-out-file=callgrind.out {{ release_bin }} {{ args }}
            callgrind_annotate callgrind.out

        build_callgrind: init
            {{ cc }} {{ release_flags }} -g src/main.c -o {{ release_bin }} {{ libs }}

        @init:
            mkdir -p {{ debug_dir }} {{ release_dir }} {{ test_dir }}

        clean:
            rm -rf build/
      ]],
      {}
    ),
    { condition = conds.line_begin }
  ),
}
