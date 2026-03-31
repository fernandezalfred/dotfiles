-- lua/config/appearance.lua
vim.o.termguicolors = true

-- Ensure this runs after any colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local groups = {
      "Normal",
      "NormalNC",
      "NormalFloat",
      "SignColumn",
      "LineNr",
      "CursorLineNr",
      "FloatBorder",
      "VertSplit",
      "StatusLine",
      "StatusLineNC",
      -- Neo-tree (and a couple other tree plugins)
      "NeoTreeNormal",
      "NeoTreeNormalNC",
      "NeoTreeFloat",
      "NvimTreeNormal",
      "NvimTreeWinSeparator",
      -- Telescope / popup-ish
      "TelescopeBorder",
      "TelescopeNormal",
      "TelescopePromptBorder",
      -- LSP / diagnostic floats
      "LspInfoBorder",
      "LspFloatWinBorder",
    }

    for _, g in ipairs(groups) do
      -- set both GUI and terminal bg to none (robust)
      vim.api.nvim_set_hl(0, g, { bg = "none" })
      -- fallback for terminals that require cterm
      vim.cmd(("hi %s guibg=NONE ctermbg=NONE"):format(g))
    end
  end,
})

-- If you want to apply it right now (without restarting nvim), re-run the callback:
vim.cmd("doautocmd ColorScheme")
