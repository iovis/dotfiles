bind -N "Search mode" f switch-client -T search

# URLs
bind -N "Search URLs" -T copy-mode-vi U {
  send -X search-backward "(https?://|git@|git://|ssh://|ftp://|file:///)[[:alnum:]?=%/_.:,;~@!#$&()*+-]*"
}

bind -N "Search URLs" -T search u {
  copy-mode
  send U
}

# Float numbers
bind -N "Search numbers" -T copy-mode-vi F {
  send -X search-backward "[[:digit:]]+(\\.[[:digit:]]+)?"
}

bind -N "Search numbers" -T search f {
  copy-mode
  send F
}

# Hashes
bind -N "Search commit hashes" -T copy-mode-vi O {
  send -X search-backward "\b([0-9a-f]{7,40}|[[:alnum:]]{52}|[0-9a-f]{64})\b"
}

bind -N "Search commit hashes" -T search o {
  copy-mode
  send O
}

# IPs
bind -N "Search IPs" -T copy-mode-vi I {
  send -X search-backward "[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}"
}

bind -N "Search IPs" -T search i {
  copy-mode
  send I
}

# Dates
bind -N "Search dates" -T copy-mode-vi D {
  send -X search-backward "[[:digit:]]{4}-[[:digit:]]{1,2}-[[:digit:]]{1,2}"
}

bind -N "Search dates" -T search d {
  copy-mode
  send D
}

# Failed RSpec examples
bind -N "Search RSpec examples" -T copy-mode-vi R {
  send -X search-backward "(rspec|cucumber) [^:]+:[[:digit:]]+"
}

bind -N "Search RSpec examples" -T search r {
  copy-mode
  send R
}

# Command Prompts
bind -N "Search command prompts" -T copy-mode-vi < {
  send -X search-backward "(❯|❮) .+"
}

bind -N "Search command prompts" -T search < {
  copy-mode
  send <
}
