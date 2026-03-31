return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_syntax_enabled = 0
      vim.g.vimtex_compiler_latexmk = {
        out_dir = "build",
      }

      -- OS detection
      if jit.os == "OSX" then
        vim.g.vimtex_view_method = "skim"
      else
        vim.g.vimtex_view_method = "zathura"
      end
    end,
  },
}
