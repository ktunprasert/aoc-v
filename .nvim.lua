local term_ops = { auto_close = false }

local entries = {
    {
        " v:run",
        function() Snacks.terminal(("v run %s"):format(vim.fn.expand("%")), term_ops) end,
        "v",
    },
    {
        " v:test",
        function() Snacks.terminal(("v -stats test %s"):format(vim.fn.expand("%:h")), term_ops) end,
        "<space>",
    },
}


for _, value in pairs(entries) do
    Menus.append(value[1], value[2], value[3])
end
