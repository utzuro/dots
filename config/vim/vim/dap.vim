lua require("dap-go").setup()

nnoremap <leader>db <Cmd>DapToggleBreakpoint<CR>
nnoremap <leader>dc <Cmd>DapContinue<CR>
nnoremap <leader>dt <cmd>lua require("dap-go").debug_test()<cr>
nnoremap <leader>dl <cmd>lua require("dap-go").debug_last_test()<cr>
