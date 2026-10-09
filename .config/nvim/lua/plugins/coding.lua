return {
  -- Extend eslint linting to mdx files
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        mdx = { "eslint_d" },
      },
    },
  },

  -- Extend prettier formatting to mdx and prisma files
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        mdx = { "prettierd", "prettier", stop_after_first = true },
        prisma = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
