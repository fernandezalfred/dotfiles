return {
  "craftzdog/solarized-osaka.nvim",
  lazy = true,
  priority = 1000,
  opts = {
    transparent = true,
    -- Make sidebars (neo-tree, nvim-tree) and floating windows (telescope,
    -- lsp, ...) transparent too, instead of the theme's default dark bg.
    -- This natively covers Normal, NormalFloat, FloatBorder, LineNr,
    -- SignColumn, VertSplit, the *Tree and Telescope/Lsp groups, etc.
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    -- Only the groups the theme keeps opaque (statusline) or doesn't define
    -- (NeoTreeFloat, TelescopePromptBorder) still need a manual override.
    on_highlights = function(hl, c)
      hl.StatusLine = { fg = c.base1, bg = c.none }
      hl.StatusLineNC = { fg = c.base0, bg = c.none }
      hl.NeoTreeFloat = { bg = c.none }
      hl.TelescopePromptBorder = { fg = c.base02, bg = c.none }
    end,
  },
}
