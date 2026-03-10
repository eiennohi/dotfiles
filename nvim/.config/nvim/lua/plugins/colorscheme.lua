return {
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "main", -- try "moon", "main", or "dawn"
        disable_background = false,
        styles = {
          comments = "italic",
          functions = "bold",
          keywords = "italic",
        },
      })

      vim.cmd.colorscheme("rose-pine")
    end,
  },
}
