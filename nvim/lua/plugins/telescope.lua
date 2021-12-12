-- nnoremap +s :Telescope<space>
--
-- nnoremap <silent> <c-p> :Telescope commands<cr>
-- nnoremap <silent> <leader><leader> :Telescope buffers<cr>
-- nnoremap <silent> <leader>A   :Telescope filetypes<cr>
-- nnoremap <silent> <leader>H   :Telescope git_bcommits<cr>
-- nnoremap <silent> <leader>gL  :Telescope git_commits<cr>
-- nnoremap <silent> <leader>R   :Telescope tags<cr>
-- nnoremap <silent> <leader>f   :Telescope live_grep<cr>
-- nnoremap <silent> <leader>gco :Telescope git_branches<cr>
-- nnoremap <silent> <leader>j   :Telescope git_status<cr>
-- nnoremap <silent> <leader>o   :Telescope find_files<cr>
-- nnoremap <silent> <leader>r   :Telescope treesitter<cr>
-- nnoremap <silent> <leader>ñ   :Telescope current_buffer_fuzzy_find<cr>
--
-- nnoremap <silent> +m :Telescope marks<cr>
-- nnoremap <silent> +r :Telescope registers<cr>

local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<c-u>"] = false,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
        ["<c-h>"] = "which_key",
      }
    }
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('gh')
