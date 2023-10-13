" let g:ale_enabled = v:true
let b:ale_linters = ['quick-lint-js']
" Following are good to have because qljs is fast
let b:ale_lint_on_text_changed = 'always'
let b:ale_lint_delay = 0
