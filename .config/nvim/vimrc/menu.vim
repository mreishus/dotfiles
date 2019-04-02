let g:quickmenu_options = 'LHT'
noremap <silent><F12> :call quickmenu#toggle(0)<CR>

" 0 - Main Menu
call quickmenu#current(0)
call quickmenu#reset()
call quickmenu#append('# Main', '')
call quickmenu#append('FZF...', 'call quickmenu#toggle(1)', 'open the FZF menu...')
call quickmenu#append('Echo 1', ':echo 1', 'Echo the number 1 to screen.')
call quickmenu#append('Echo 2', ':echo 2', 'Echo the number 2 to screen.')

" 1 - FZF (Main)
call quickmenu#current(1)
call quickmenu#reset()
call quickmenu#append('# FZF', '')
"Files [PATH] 	Files (similar to :FZF) <-- my ctrl-p
call quickmenu#append('Git Files', ':GFiles', 'search git files (git ls-files)')
call quickmenu#append('Recent Files', ':History', 'search history (v:oldfiles and open buffers)')
call quickmenu#append('Marks', ':Marks', 'search marks')
call quickmenu#append('Windows', ':Windows', 'search windows')
call quickmenu#append('Git Status', ':GFiles?', 'search git files (git status)')
call quickmenu#append('Commits', ':Commits', 'search git commits')

call quickmenu#append('# Menus', '')
call quickmenu#append('FZF (obscure)...', 'call quickmenu#toggle(2)', 'obscure FZF commands.')
call quickmenu#append('Main Menu...', 'call quickmenu#toggle(0)', 'back to main menu.')

" 2 - FZF (Obscure)
call quickmenu#current(2)
call quickmenu#reset()

call quickmenu#append('# FZF (obscure)', '')

call quickmenu#append('Buffers', ':Buffers', 'search open buffers')
call quickmenu#append('Colors', ':Colors', 'search color schemes')
call quickmenu#append('Command History', ':History:', 'search command history')
call quickmenu#append('Commands', ':Commands', 'search commands')

call quickmenu#append(' ', '')
call quickmenu#append('Commits', ':Commits', 'Search Git Commits')
call quickmenu#append('BCommits', ':BCommits', 'search git commits for the current buffer')
call quickmenu#append(' ', '')

call quickmenu#append('Filetypes', ':Filetypes', 'search file types')
call quickmenu#append('Helptags', ':Helptags', 'search help tags 1')

call quickmenu#append(' ', '')
call quickmenu#append('Lines', ':Lines', 'search lines in loaded buffers')
call quickmenu#append('BLines', ':BLines', 'search lines in the current buffer')
call quickmenu#append(' ', '')

call quickmenu#append('Locate', 'call fzf#vim#locate(shellescape(expand(''<cword>'')))', 'search output of "locate (%{expand("<cword>")})"')
call quickmenu#append('Maps', ':Maps', 'search normal mode mappings')
call quickmenu#append('Search History', ':History/', 'search "search history"')
call quickmenu#append('Snippets', ':Snippets', 'search snippets (ultisnips)')

call quickmenu#append(' ', '')
call quickmenu#append('Tags', ':Tags', 'tags in the project (ctags -R)')
call quickmenu#append('BTags', ':BTags', 'tags in the current buffer (ctags -R)')

call quickmenu#append('# Menus', '')
call quickmenu#append('FZF (main)...', 'call quickmenu#toggle(1)', 'main FZF commands.')
call quickmenu#append('Main Menu...', 'call quickmenu#toggle(0)', 'back to main menu.')

" These don't work for me?
"Ag [PATTERN] 	ag search result (ALT-A to select all, ALT-D to deselect all)
"Rg [PATTERN] 	rg search result (ALT-A to select all, ALT-D to deselect all)

call quickmenu#current(3)
call quickmenu#reset()
call quickmenu#append('# Development 2', '')
call quickmenu#append('Echo 5', ':echo 5', 'Echo the number 1 to screen.')
call quickmenu#append('Echo 6', ':echo 6', 'Echo the number 2 to screen.')
