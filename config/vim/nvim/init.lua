local function source(file)
  vim.cmd('source ' .. file)
end

local files = {
  '~/.vim/basic.vim',
  '~/.vim/maps.vim',
  '~/.vim/auto.vim',
  '~/.vim/plugins.vim',
  '~/.vim/custom.vim',
}

for _, file in ipairs(files) do
  source(file)
end

vim.cmd.colorscheme('dracula')

local config_root = vim.fn.stdpath('config')
-- local devcontainer_file = config_root .. '/devcontainer.lua'
-- if vim.fn.filereadable(devcontainer_file) == 1 then
--   dofile(devcontainer_file)
-- end
