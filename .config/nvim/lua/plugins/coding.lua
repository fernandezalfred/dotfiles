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

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    keys = function(_, keys)
      -- Remove the old AI menu to avoid duplication
      local new_keys = vim.tbl_filter(function(k)
        return k[1] ~= "<leader>ap"
      end, keys)

      -- Add prompt actions directly under <leader>a
      vim.list_extend(new_keys, {
        { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
        { "<leader>af", "<cmd>CopilotChatFix<cr>", desc = "Fix code" },
        { "<leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Generate docs" },
        { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Add tests" },
        { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
      })
      return new_keys
    end,
  },
}
