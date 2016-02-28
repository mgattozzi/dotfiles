function does_not_exist(path)
  return not (vim.fn.empty(vim.fn.glob(install_path)) > 0)
end

return {
  does_not_exist = does_not_exist,
}
