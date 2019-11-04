let g:pwshBuf = 0
let g:pwshWin = 0
function! OpenTerminal()
  let new = v:false
  if !g:pwshBuf || !bufexists(g:pwshBuf)
    let g:pwshBuf = nvim_create_buf(v:false, v:false)
    let new = v:true
  endif

  echo &columns
  let height = &lines - 5
  let width = &columns - 10
  let vertical = (&lines - height) / 2
  let horizontal = (&columns - width) / 2
  let opts = {
        \ 'relative': 'editor',
        \ 'col': horizontal,
        \ 'row': vertical,
        \ 'width': width,
        \ 'height': height,
        \ 'focusable': v:true
        \ }
  let g:pwshWin = nvim_open_win(g:pwshBuf, v:true, opts)
  if new
    let oldShell = &shell
    let &shell = 'pwsh'
    terminal
    set hidden
    let &shell = oldShell
  endif

  call nvim_win_set_config(g:pwshWin, opts)
  startinsert
endfunction

command! Term call OpenTerminal()

function! HideTerminal()
  if g:pwshWin && bufexists(g:pwshBuf) && bufwinnr(g:pwshBuf) != -1
    call nvim_win_close(g:pwshWin, v:true)
    let g:pwshWin = 0
  endif
endfunction

command! TermHide call HideTerminal()
