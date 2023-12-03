return {
  'rcarriga/nvim-notify',
  name = 'notify',
  config = function()
    local ntf = require'notify'
    ntf.setup({
      render = "compact",
    })
    vim.notify = ntf
  end
}
