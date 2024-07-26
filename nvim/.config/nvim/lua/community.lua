-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.color.transparent-nvim" },
  { import = "astrocommunity.color.ccc-nvim" },

  -- { import = "astrocommunity.colorscheme.aurora" },
  { import = "astrocommunity.colorscheme.dracula-nvim" },

  { import = "astrocommunity.editing-support.treesj" },
  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.editing-support.bigfile-nvim" },
  { import = "astrocommunity.editing-support.vim-visual-multi" },

  { import = "astrocommunity.recipes.telescope-lsp-mappings" },

  -- { import = "astrocommunity.lsp.inc-rename-nvim" },
  { import = "astrocommunity.lsp.lsp-lens-nvim" },
  { import = "astrocommunity.lsp.lsp-signature-nvim" },

  { import = "astrocommunity.scrolling.mini-animate" },

  { import = "astrocommunity.search.nvim-hlslens" },

  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
  -- { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  -- { import = "astrocommunity.bars-and-lines.bufferline-nvim" },
  -- { import = "astrocommunity.bars-and-lines.feline-nvim" },
  -- { import = "astrocommunity.bars-and-lines.lualine-nvim" },

  { import = "astrocommunity.indent.mini-indentscope" },

  { import = "astrocommunity.comment.mini-comment" },

  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.marks-nvim" },
  { import = "astrocommunity.motion.mini-move" },

  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.git.git-blame-nvim" },

  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },

  -- { import = "astrocommunity.syntax.vim-cool" },

  { import = "astrocommunity.completion.cmp-cmdline" },

  { import = "astrocommunity.split-and-window.minimap-vim" },

  { import = "astrocommunity.pack.python-ruff" },
  -- { import = "astrocommunity.pack.python" },
}
