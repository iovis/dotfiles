# Make solargraph work in vim
# https://github.com/neoclide/coc-solargraph/issues/12#issuecomment-528942686
asdf_path="/usr/local/opt/asdf/asdf.sh"
[ -f $asdf_path ] && source $asdf_path

export PATH="$HOME/.cargo/bin:$PATH"
