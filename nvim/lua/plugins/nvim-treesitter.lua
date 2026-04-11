return { 'nvim-treesitter/nvim-treesitter',
      lazy = false,
      build = ':TSUpdate',
      config = function ()
          require('nvim-treesitter').install { 'rust', 'python', 'go', 'lua' }
          vim.api.nvim_create_autocmd('FileType', {
          pattern = { '<filetype>' },
            callback = function() vim.treesitter.start() end,
          })
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- vim.wo[0][0].foldmethod = 'expr'
      end

  }
