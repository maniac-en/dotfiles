local augroup = vim.api.nvim_create_augroup
local maniac_aug = augroup("maniac_aug", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- highlight the yanked text post yanking
-- weird sentence formation lol
autocmd("TextYankPost", {
    group = maniac_aug,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

-- clear out trailing spaces on buffer write
autocmd("BufWrite", {
    group = maniac_aug,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- disable line numbers in terminal
autocmd("TermOpen", {
    group = maniac_aug,
    pattern = "*",
    callback = function()
        vim.o.number = false
        vim.o.relativenumber = false
    end,
}
)
