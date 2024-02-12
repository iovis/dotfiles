return {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "onsails/lspkind-nvim",
    "petertriho/cmp-git",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local u = require("config.utils")

    ---- Plugins
    -- Autopairs
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- Git
    require("cmp_git").setup()

    ---- Setup
    local toggle_completion = function()
      if cmp.visible() then
        cmp.close()
      else
        cmp.complete({})
      end
    end

    cmp.setup({
      mapping = {
        ["<c-b>"] = { i = toggle_completion },
        ["<c-n>"] = { i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
        ["<c-p>"] = { i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
        ["<tab>"] = { i = cmp.mapping.confirm({ select = true }) },
        ["<m-d>"] = {
          i = function()
            if cmp.visible_docs() then
              cmp.close_docs()
            else
              cmp.open_docs()
            end
          end,
        },
      },
      formatting = {
        format = require("lspkind").cmp_format({
          -- maxwidth = 10,
          -- ellipsis_char = "…",
          -- menu = {
          --   buffer = "[Buf]",
          --   git = "[Git]",
          --   luasnip = "[Sni]",
          --   nvim_lsp = "[LSP]",
          --   path = "[Pat]",
          -- },
          before = function(_entry, vim_item)
            --- Example
            -- ```lua
            -- {
            --   abbr = "poll_recv_many",
            --   dup = 1,
            --   kind = "Method",
            --   menu = "fn(&mut self, &mut Context<'_>, &mut Vec<T, Global>, usize) -> Poll<usize>",
            --   word = "poll_recv_many"
            -- }
            -- ```

            -- TODO: media queries with vim.o.columns or a global toggle?
            local max_width = 35

            vim_item.abbr = u.truncate(vim_item.abbr, max_width)
            vim_item.menu = u.truncate(vim_item.menu, max_width)

            return vim_item
          end,
        }),
      },
      sources = cmp.config.sources({
        { name = "git" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 4 },
        { name = "path" },
      }),
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = {
        ghost_text = { hl_group = "NonText" },
      },
    })

    ---- Modes
    -- Search
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline({
        ["<c-b>"] = { c = toggle_completion },
        ["<c-e>"] = cmp.config.disable,
      }),
      sources = {
        { name = "buffer" },
      },
    })

    -- Command line
    -- NOTE: it breaks "-complete=command"
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline({
        ["<c-b>"] = { c = toggle_completion },
        ["<c-e>"] = cmp.config.disable,
      }),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man" },
          },
        },
      }),
    })
  end,
}
