-- Taken from: https://github.com/stevearc/oil.nvim
--
-- ```sh
-- nvim -u repro.lua
-- ```
--

-- Set stdpaths to use $DOTFILES/.repro/
local root = vim.fn.resolve(vim.env.DOTFILES .. "/.repro")
for _, name in ipairs({ "config", "data", "state", "runtime", "cache" }) do
  vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- Bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})

    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.runtimepath:prepend(lazypath)

-- Opts
vim.g.mapleader = " "
vim.o.cursorline = true
vim.o.inccommand = "split"
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.wrap = false

-- Keymap
vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("n", "-", "<cmd>Ex<cr>")
vim.keymap.set("n", "<leader>e", ":e!<space>")
vim.keymap.set("n", "<leader>c", "<cmd>close<cr>")
vim.keymap.set("n", "<leader>h", "<c-w>s")
vim.keymap.set("n", "<leader>v", "<c-w>v")
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>qa<cr>")
vim.keymap.set("n", "<leader>;", "<cmd>noh<cr><cmd>echon<cr>")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")
vim.keymap.set("n", "M", "<c-w>o")
vim.keymap.set("n", "<bs>", "<c-^>")
vim.keymap.set({ "n", "x" }, ";", ":")
vim.keymap.set({ "n", "x" }, ":", ";")
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "x", "o" }, "L", "$")

-- Install plugins
local plugins = {
  {
    "ibhagwan/fzf-lua",
    config = function()
      local fzf = require("fzf-lua")
      fzf.setup({})
      vim.keymap.set("n", "<leader>o", fzf.files)
    end,
  },
  -- {
  --   "iovis/oil.nvim",
  --   dev = true,
  --   lazy = false,
  --   keys = {
  --     { "-", "<cmd>Oil --float<cr>" },
  --     { "_", "<cmd>Oil<cr>" },
  --   },
  --   config = function()
  --     require("oil").setup()
  --   end,
  -- },
  {
    "saghen/blink.cmp",
    build = "cargo build --release",
    config = function()
      require("blink.cmp").setup({
        keymap = {
          ["<Tab>"] = { "select_and_accept", "fallback" },
          ["<C-j>"] = { "snippet_forward", "fallback" },
          ["<C-k>"] = { "snippet_backward", "fallback" },
          ["<Esc>"] = { "cancel", "fallback" },
          ["<C-b>"] = { "show", "hide" },
          ["<M-d>"] = { "show_documentation", "hide_documentation" },
          ["<C-p>"] = { "select_prev", "fallback" },
          ["<C-n>"] = { "select_next", "fallback" },
          ["<M-k>"] = { "scroll_documentation_up", "fallback" },
          ["<M-j>"] = { "scroll_documentation_down", "fallback" },
          ["<M-1>"] = {
            function(cmp)
              cmp.accept({ index = 1 })
            end,
          },
          ["<M-2>"] = {
            function(cmp)
              cmp.accept({ index = 2 })
            end,
          },
          ["<M-3>"] = {
            function(cmp)
              cmp.accept({ index = 3 })
            end,
          },
          ["<M-4>"] = {
            function(cmp)
              cmp.accept({ index = 4 })
            end,
          },
          ["<M-5>"] = {
            function(cmp)
              cmp.accept({ index = 5 })
            end,
          },
          ["<M-6>"] = {
            function(cmp)
              cmp.accept({ index = 6 })
            end,
          },
          ["<M-7>"] = {
            function(cmp)
              cmp.accept({ index = 7 })
            end,
          },
          ["<M-8>"] = {
            function(cmp)
              cmp.accept({ index = 8 })
            end,
          },
          ["<M-9>"] = {
            function(cmp)
              cmp.accept({ index = 9 })
            end,
          },

          cmdline = {
            -- TODO:
            --   - <c-b> not mappable?
            --   - <esc> executes the command (neovim issue)
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-y>"] = { "select_and_accept", "fallback" },
            ["<C-s>"] = { "show", "hide" },
	    ["<M-1>"] = {
	      function(cmp)
	        cmp.accept({ index = 1 })
	      end,
	    },
	    ["<M-2>"] = {
	      function(cmp)
	        cmp.accept({ index = 2 })
	      end,
	    },
	    ["<M-3>"] = {
	      function(cmp)
	        cmp.accept({ index = 3 })
	      end,
	    },
	    ["<M-4>"] = {
	      function(cmp)
	        cmp.accept({ index = 4 })
	      end,
	    },
	    ["<M-5>"] = {
	      function(cmp)
	        cmp.accept({ index = 5 })
	      end,
	    },
	    ["<M-6>"] = {
	      function(cmp)
	        cmp.accept({ index = 6 })
	      end,
	    },
	    ["<M-7>"] = {
	      function(cmp)
	        cmp.accept({ index = 7 })
	      end,
	    },
	    ["<M-8>"] = {
	      function(cmp)
	        cmp.accept({ index = 8 })
	      end,
	    },
	    ["<M-9>"] = {
	      function(cmp)
	        cmp.accept({ index = 9 })
	      end,
	    },
          },
        },

        completion = {
          list = {
            selection = "auto_insert",
          },

          menu = {
            border = "rounded",
            scrollbar = false,
            draw = {
              columns = {
                { "item_idx" },
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "source_name" },
              },
              components = {
                item_idx = {
                  highlight = "BlinkCmpItemIdx",
                  text = function(ctx)
                    return ctx.idx >= 10 and " " or tostring(ctx.idx)
                  end,
                },

                source_name = {
                  text = function(ctx)
                    return ctx.source_name:sub(1, 4)
                  end,
                },
              },
            },
          },

          documentation = {
            auto_show = false,
            auto_show_delay_ms = 100,
            window = {
              border = "rounded",
              scrollbar = false,
            },
          },

          ghost_text = { enabled = true },
        },

        -- Experimental
        signature = {
          enabled = true,
          window = { border = "rounded" },
        },
      })

      vim.api.nvim_create_user_command("BlinkReload", function()
        require("blink.cmp").reload()
        vim.notify("Blink reloaded")
      end, {})
    end,
  },
}

require("lazy").setup(plugins, {
  root = root .. "/plugins",
  install = {
    colorscheme = { "default" },
  },
  dev = {
    path = vim.fn.resolve(vim.env.PROJECT_HOME .. "/vim"),
  },
})
