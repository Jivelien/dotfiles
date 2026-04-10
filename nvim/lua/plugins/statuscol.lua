return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local function lnum_both()
      local lnum = vim.v.lnum
      local relnum = vim.v.lnum == vim.fn.line(".") and 0 or math.abs(vim.v.lnum - vim.fn.line("."))
      return string.format("%3d %2d", relnum, lnum)
    end

    require("statuscol").setup({
      setopt = true,
      bt_ignore = { "nofile" },
      ft_ignore = { "neo-tree" },
      segments = {
        {
          sign = { namespace = { "gitsigns.*" }, name = { "gitsigns.*" } },
        },
        {
          sign = { namespace = { ".*" }, name = { ".*" }, auto = true },
        },
        {
          text = { lnum_both, " " },
          condition = { true },
          click = "v:lua.ScLa",
        },
      },
    })
  end,
}
