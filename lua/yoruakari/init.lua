local M = {}

local defaults = {
  transparent = false,
  terminal_colors = true,
}

---@param opts? table
function M.setup(opts)
  opts = vim.tbl_deep_extend("force", defaults, opts or {})

  local palette = require("yoruakari.palette").get()
  local groups = require("yoruakari.groups").get(palette)

  if opts.transparent then
    groups.Normal = { fg = palette.fg }
    groups.NormalNC = { fg = palette.fg }
    groups.SignColumn = { fg = palette.comment }
    groups.EndOfBuffer = { fg = palette.comment }
    groups.TabLineFill = { fg = palette.muted }
    groups.Pmenu = { fg = palette.fg }
    groups.NormalFloat = { fg = palette.fg }
  end

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "yoruakari"

  for name, value in pairs(groups) do
    vim.api.nvim_set_hl(0, name, value)
  end

  if opts.terminal_colors then
    vim.g.terminal_color_0 = palette.bg_dark
    vim.g.terminal_color_1 = palette.red
    vim.g.terminal_color_2 = palette.green
    vim.g.terminal_color_3 = palette.yellow
    vim.g.terminal_color_4 = palette.blue
    vim.g.terminal_color_5 = palette.purple
    vim.g.terminal_color_6 = palette.cyan
    vim.g.terminal_color_7 = palette.fg
    vim.g.terminal_color_8 = palette.dim
    vim.g.terminal_color_9 = palette.red
    vim.g.terminal_color_10 = palette.green
    vim.g.terminal_color_11 = palette.yellow
    vim.g.terminal_color_12 = palette.blue
    vim.g.terminal_color_13 = palette.purple
    vim.g.terminal_color_14 = palette.cyan
    vim.g.terminal_color_15 = palette.white
  end
end

function M.load(opts)
  M.setup(opts)
end

return M
