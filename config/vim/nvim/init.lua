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

vim.cmd.colorscheme('eink')
vim.cmd.colorscheme('dracula')

local config_root = vim.fn.stdpath('config')
-- local devcontainer_file = config_root .. '/devcontainer.lua'
-- if vim.fn.filereadable(devcontainer_file) == 1 then
--   dofile(devcontainer_file)
-- end

local is_wsl = vim.fn.has("wsl") == 1

if is_wsl then
  local win_paste = {
    "powershell.exe",
    "-NoLogo",
    "-NoProfile",
    "-Command",
    '$t = Get-Clipboard -Raw; if ($null -ne $t) { [Console]::Out.Write($t.Replace("`r", "")) }',
  }

  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = { "clip.exe" },
      ["*"] = { "clip.exe" },
    },
    paste = {
      ["+"] = win_paste,
      ["*"] = win_paste,
    },
    cache_enabled = 0,
  }
end
