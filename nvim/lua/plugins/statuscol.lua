return {
    "luukvbaal/statuscol.nvim",
    config = function()
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                pattern = "*",
                callback = function()
                    vim.cmd("redraw!")
                end,
            })

            require("statuscol").setup({
                setopt = true,
                segments = {
                    { sign = { namespace = { ".*" }, name = { ".*" }, auto = true } },
                    { text = { function()
                                    local rel = vim.v.relnum
                                    if rel ~= 0 then
                                        return string.format("%2d", rel)
                                    end 
                                    return "  "
                                end
                        , " " },
                      condition = { true },
                      click = "v:lua.ScLa" },
                    { text = { 
                        function()
                            return string.format("%3d", vim.v.lnum)
                        end
                        , " " }, 
                      condition = { true }, 
                      click = "v:lua.ScLa" },
                    },
                })
            end,
        }
