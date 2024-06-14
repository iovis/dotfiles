function csvimport
    set file $argv[1]
    set filename (path basename $file)
    set table (path change-extension '' $filename)

    sqlite3 "$table.db" ".import $file $table --csv" && echo "Created $table.db!"
end
