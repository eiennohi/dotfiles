return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,
  config = function()
    require("rose-pine").setup()

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function() vim.cmd.colorscheme "rose-pine" end,
    })
  end,
}
