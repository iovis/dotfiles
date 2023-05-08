function venv
    python3 -m venv .venv && activate && pipu pip setuptools wheel ipython pyright pylint
end
