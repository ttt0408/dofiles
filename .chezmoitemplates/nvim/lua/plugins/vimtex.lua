return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  int = function()
    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = vim.api.nvim_create_augroup("lazyvim_vimtex_conceal", { clear = true }),
      pattern = { "bib", "tex" },
      callback = function()
        vim.wo.conceallevel = 0
      end,
    })
    vim.g.vimtex_view_method = "SumatraPDF"
    vim.g.vimtex_view_SumatraPDF_sync = 1
    vim.g.vimtex_view_SumatraPDF_activate = 1
    vim.g.vimtex_view_SumatraPDF_reading_bar = 1
    vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

    vim.g.vimtex_compiler_latexmk = {
      aux_dir = "./aux",
      out_dir = "./out",
    }
  end,
}
