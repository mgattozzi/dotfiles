-- Key remaps
local remap = vim.api.nvim_set_keymap
function noremap(from, to)
  remap('', from, to, {noremap = true})
end
function nnoremap(from, to)
  remap('n', from, to, {noremap = true})
end
function vnoremap(from, to)
  remap('v', from, to, {noremap = true})
end
function inoremap(from, to)
  remap('i', from, to, {noremap = true})
end
function nmap(from, to)
  remap('n', from, to, {})
end
function vmap (from, to)
  remap('v', from, to, {})
end

return {
  noremap = noremap,
  nnoremap = nnoremap,
  vnoremap = vnoremap,
  nmap = nmap,
  vmap = vmap
}

