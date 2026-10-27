-- Parsers installed at startup
local parsers = {
  'bash',
  'c',
  'json',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'markdown_inline',
  'ocaml',
  'latex',
  'bibtex',
  'python',
  'regex',
  'rust',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

-- Languages highlighted by another plugin (vimtex)
local no_highlight = { latex = true }

return {
  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    version = false,
    lazy = false, -- the main branch does not support lazy-loading
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install(parsers)

      -- Highlight, indent and fold with treesitter when a parser is available
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup(
          'TreesitterStart',
          { clear = true }
        ),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if
            not lang
            or no_highlight[lang]
            or not vim.treesitter.language.add(lang)
          then
            return
          end
          vim.treesitter.start(args.buf, lang)
          vim.bo[args.buf].indentexpr =
            "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end,
      })
    end,
  },
}
