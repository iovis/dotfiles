function ctn --wraps='cargo nextest run --nocapture' --description 'alias ctn=cargo nextest run --nocapture'
    cargo nextest run --nocapture $argv
end
