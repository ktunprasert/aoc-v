local term_ops = { auto_close = false }

local entries = {
    {
        " v:run",
        function()
            Snacks.terminal(
                string.format("v run %s", vim.fn.expand("%")), term_ops)
        end,
        "<space>",
    },
    {
        " v:run example",
        function()
            Snacks.terminal(
                string.format(
                    "v run %s %se.txt",
                    vim.fn.expand("%"), vim.fn.expand("%:r")
                ), term_ops)
        end,
        "e",
    },
}


for _, value in pairs(entries) do
    Menus.append(value[1], value[2], value[3])
end
