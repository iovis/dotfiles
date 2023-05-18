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
    "quangnguyen30192/cmp-nvim-tags",
    "saadparwaiz1/cmp_luasnip",
    "saecki/crates.nvim",
  },
  config = function()
    local cmp = require("cmp")

    ---- Plugins
    -- Autopairs
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- Pretty LSP menu
    local lspkind = require("lspkind")
    lspkind.init()

    -- Git
    require("cmp_git").setup()

    -- Crates.nvim
    cmp.register_source("crates", require("crates.src.cmp").new())

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
        ["<C-b>"] = { i = toggle_completion },
        ["<C-n>"] = { i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
        ["<C-p>"] = { i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
        ["<Tab>"] = { i = cmp.mapping.confirm({ select = true }) },
      },
      formatting = {
        format = lspkind.cmp_format({
          menu = {
            buffer = "[Buf]",
            crates = "[Cra]",
            git = "[GIT]",
            luasnip = "[Snip]",
            nvim_lsp = "[LSP]",
            path = "[Path]",
            tags = "[TAG]",
          },
        }),
      },
      sources = cmp.config.sources({
        { name = "crates" },
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
        ["<C-b>"] = { c = toggle_completion },
        ["<C-e>"] = cmp.config.disable,
      }),
      sources = {
        { name = "buffer" },
      },
    })

    -- Command line
    -- NOTE: it breaks "-complete=command"
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline({
        ["<C-b>"] = { c = toggle_completion },
        ["<C-e>"] = cmp.config.disable,
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

    ---- Filetypes
    cmp.setup.filetype("ruby", {
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 4 },
        { name = "tags" },
        { name = "path" },
      }),
    })
  end,
}
