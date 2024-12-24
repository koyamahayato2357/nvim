M = {}

function M.get_visual_selection()
  local vpos = vim.fn.getpos("v")
  local begin_pos = {  vpos[2],  vpos[3] - 1 }
  local end_pos = vim.api.nvim_win_get_cursor(0)
  if begin_pos[1] < end_pos[1] or begin_pos[1] == end_pos[1] and begin_pos[2] <= end_pos[2] then
    return { start = begin_pos, last = end_pos }
  else
    return { start = end_pos, last = begin_pos }
  end
end

return M
