function generate_ruby_clangd
    ruby ext/**/extconf.rb && bear -- make && make clean && rm Makefile
end
