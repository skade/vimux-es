command! -nargs=+ RunEs call s:runRequest(<f-args>)
command! -nargs=1 EsGet call s:runRequest("GET", <f-args>)
command! -nargs=1 EsHead call s:runRequest("HEAD", <f-args>)
command! -nargs=1 EsPostFile call s:runRequest("POST", <f-args>, expand('%:p'))
command! -nargs=1 EsPutFile call s:runRequest("PUT", <f-args>, expand('%:p'))

let g:es_host = "http://localhost:9200"
let g:es_highlight = "on"

function! s:runRequest(verb, path, ...)
  let command = "curl -X".a:verb." ".g:es_host.a:path
  if a:0 > 0
    let command = command . " -d @" . a:1
  endif
  if exists("g:es_highlight")
    :call VimuxRunCommand(command." | jazor | coderay -json")
  else
    :call VimuxRunCommand(command)
  endif
endfunction
