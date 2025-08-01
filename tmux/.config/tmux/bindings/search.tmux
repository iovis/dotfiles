bind -N "Search mode" f {
  switch-client -T search
  display " Search: [d]-Dates [f]-Floats [i]-IPs [j]-JIRA [n]-Numbers [o]-Commits [p]-Paths [r]-RSpec [t]-Time [u]-URLs [,]-Prompts"
}

# Command Prompts
bind -N "Search command prompts" -T copy-mode-vi , {
  send -X search-backward "(❯|❮)(.*[^[:space:]])?"
}

bind -N "Search command prompts" -T search , {
  copy-mode
  send ,
  send n
}

# Commit Hashes
bind -N "Search commit hashes" -T copy-mode-vi O {
  send -X search-backward "\b(I?[0-9a-f]{7,40}|[[:alnum:]]{52}|[0-9a-f]{64})\b"
}

bind -N "Search commit hashes" -T search o {
  copy-mode
  send O
}

# Dates
bind -N "Search dates" -T copy-mode-vi D {
  send -X search-backward "[[:digit:]]{4}-[[:digit:]]{1,2}-[[:digit:]]{1,2}"
}

bind -N "Search dates" -T search d {
  copy-mode
  send D
}

# Floating numbers
bind -N "Search floating numbers" -T copy-mode-vi F {
  send -X search-backward "[[:digit:]]+(\\.[[:digit:]]+)?"
}

bind -N "Search floating numbers" -T search f {
  copy-mode
  send F
}

# IPs
bind -N "Search IPs" -T copy-mode-vi I {
  send -X search-backward "[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}"
}

bind -N "Search IPs" -T search i {
  copy-mode
  send I
}

# JIRA tickets
bind -N "Search JIRA tickets" -T copy-mode-vi J {
  send -X search-backward "[[:alpha:]]+-[[:digit:]]+"
}

bind -N "Search JIRA tickets" -T search j {
  copy-mode
  send J
}

# Numbers
bind -N "Search numbers" -T copy-mode-vi S {
  send -X search-backward "\b[[:digit:]]+\b"
}

bind -N "Search numbers" -T search n {
  copy-mode
  send S
}

# Paths
bind -N "Search paths" -T copy-mode-vi P {
  send -X search-backward "\b(~/|/)?([-~a-zA-Z0-9_+-,.]+/[^[:space:]|:\"'`\$%&)>\]*)"
}

bind -N "Search paths" -T search p {
  copy-mode
  send P
}

# RSpec failed examples
bind -N "Search RSpec examples" -T copy-mode-vi R {
  send -X search-backward "(rspec|cucumber) [^:]+:[[:digit:]]+"
}

bind -N "Search RSpec examples" -T search r {
  copy-mode
  send R
}

# Time
bind -N "Search time" -T copy-mode-vi T {
  send -X search-backward "[[:digit:]]{1,2}:[[:digit:]]{1,2}(:[[:digit:]]{1,2}(\\.[[:digit:]]+)?)?"
}

bind -N "Search time" -T search t {
  copy-mode
  send T
}

# URLs
bind -N "Search URLs" -T copy-mode-vi U {
  send -X search-backward "(https?://|git@|git://|ssh://|ftp://|file:///)[[:alnum:]?=%/_.:,;~@!#$&()*+-]*"
}

bind -N "Search URLs" -T search u {
  copy-mode
  send U
}
