function libc_src
    if test (count $argv) -lt 1
        echo "usage: libc-src FUNCTION [OBJECT]" >&2
        return 2
    end

    set -l fn $argv[1]
    set -l obj /usr/lib/libc.so.6

    if test (count $argv) -ge 2
        set obj $argv[2]
    end

    set -l src (lldb -b "$obj" \
          -o 'settings set symbols.auto-download foreground' \
          -o "image lookup -vn $fn" \
          -o quit 2>/dev/null \
          | sed -n 's/.*CompileUnit:.*file = "\([^"]*\)".*/\1/p' \
          | head -n 1)

    if test -z "$src"
        echo "no source path found for $fn" >&2
        return 1
    end

    set -l file (debuginfod-find source "$obj" "$src")
    if test $status -ne 0
        return $status
    end

    "$EDITOR" "$file"
end
