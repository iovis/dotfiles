bind f switch-client -T search

# URLs
bind -T copy-mode-vi U {
  send -X search-backward "(https?://|git@|git://|ssh://|ftp://|file:///)[[:alnum:]?=%/_.:,;~@!#$&()*+-]*"
}

bind -T search u {
  copy-mode
  send U
}

# Float numbers
bind -T copy-mode-vi F {
  send -X search-backward "[[:digit:]]+(\\.[[:digit:]]+)?"
}

bind -T search f {
  copy-mode
  send F
}

# Hashes
bind -T copy-mode-vi O {
  send -X search-backward "\b([0-9a-f]{7,40}|[[:alnum:]]{52}|[0-9a-f]{64})\b"
}

bind -T search o {
  copy-mode
  send O
}

# IPs
bind -T copy-mode-vi I {
  send -X search-backward "[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}"
}

bind -T search i {
  copy-mode
  send I
}

# Dates
bind -T copy-mode-vi D {
  send -X search-backward "[[:digit:]]{4}-[[:digit:]]{1,2}-[[:digit:]]{1,2}"
}

bind -T search d {
  copy-mode
  send D
}

# Failed RSpec examples
bind -T copy-mode-vi R {
  send -X search-backward "(rspec|cucumber) [^:]+:[[:digit:]]+"
}

bind -T search r {
  copy-mode
  send R
}

# Command Prompts
bind -T copy-mode-vi < {
  send -X search-backward "(❯|❮) .+"
}

bind -T search < {
  copy-mode
  send <
}
