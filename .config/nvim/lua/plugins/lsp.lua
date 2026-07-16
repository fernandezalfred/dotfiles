return {
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
    },
    opts = {
      document_color = {
        enabled = true,
        kind = "inline", -- "inline" | "foreground" | "background"
      },
      conceal = {
        enabled = false,
      },
    },
  },

  -- treesitter parsers (syntax highlighting / colorization)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "prisma" })
    end,
  },

  -- tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "prisma-language-server",
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Increase hover window limits so full docs render (noice handles the actual display)
      local orig_hover = vim.lsp.buf.hover
      vim.lsp.buf.hover = function(config)
        config = config or {}
        config.max_width = config.max_width or 120
        config.max_height = config.max_height or 40
        return orig_hover(config)
      end
    end,
    opts = function(_, opts)
      -- keymaps: override the default `gd` for all servers via the "*" config.
      -- (Replaces the deprecated `require("lazyvim.plugins.lsp.keymaps").get()`.)
      opts.servers = opts.servers or {}
      opts.servers["*"] = opts.servers["*"] or {}
      opts.servers["*"].keys = opts.servers["*"].keys or {}
      vim.list_extend(opts.servers["*"].keys, {
        {
          "gd",
          function()
            -- DO NOT RESUSE WINDOW
            require("telescope.builtin").lsp_definitions({ reuse_win = false })
          end,
          desc = "Goto Definition",
          has = "definition",
        },
      })

      -- servers
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        cssls = {},
        prismals = {},
        tailwindcss = {
          root_dir = function(fname)
            return vim.fs.root(fname, ".git")
          end,
          filetypes = {
            "html",
            "mdx",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "css",
            "postcss",
          },
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^'\"` ]*?)(?:'|\"|`)" },
                  { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^'\"` ]*?)(?:'|\"|`)" },
                  { "cva\\(([^)]*)\\)", "(?:'|\"|`)([^'\"` ]*?)(?:'|\"|`)" },
                  { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^'\"` ]*?)(?:'|\"|`)" },
                  { "tv\\(([^)]*)\\)", "(?:'|\"|`)([^'\"` ]*?)(?:'|\"|`)" },
                  { "variants:\\s*\\{([^}]*)\\}", "(?:'|\"|`)([^'\"` ]*?)(?:'|\"|`)" },
                },
              },
            },
          },
        },
        ts_ls = {
          root_dir = function(fname)
            return vim.fs.root(fname, ".git")
          end,
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        html = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      })
    end,
  },
}
