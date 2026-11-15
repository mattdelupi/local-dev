vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local data = ev.data
    if data.spec.name == "telescope-fzf-native.nvim"
        and (data.kind == "install" or data.kind == "update") then
      local result = vim.system({ "make" }, {
        cwd = data.path,
        text = true,
      }):wait()
      if result.code ~= 0 then
        vim.notify(
          "fzf-native: compilazione fallita\n" .. (result.stderr or ""),
          vim.log.levels.ERROR
        )
      end
    end
  end,
})

vim.pack.add({
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-lua/plenary.nvim.git' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim.git' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim.git' },
})
