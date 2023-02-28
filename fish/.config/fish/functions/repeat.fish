function repeat
    for i in (seq $argv[1])
        $argv[2..-1]
    end
end
