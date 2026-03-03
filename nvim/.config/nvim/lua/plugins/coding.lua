return {
    {
        "xeluxee/competitest.nvim",
        dependencies = "MunifTanjim/nui.nvim",
        config = function()
            require("competitest").setup({
                received_problems_path = function(task, file_extension)
                    local home = os.getenv("HOME")
                    local contest_id = "unknown_contest"
                    local problem_id = task.name

                    if task.url then
                        local c, p = task.url:match("contest/(%d+)/problem/([%w%p]+)")
                        if c and p then
                            contest_id, problem_id = c, p
                        else
                            c, p = task.url:match("problem/(%d+)/([%w%p]+)")
                            if c and p then
                                contest_id, problem_id = c, p
                            end
                        end
                    end
                    if problem_id == task.name then
                        local p = task.name:match("^(%w+)%.")
                        if p then problem_id = p end
                    end
                    return string.format("%s/code/codeforces/%s/%s.%s", home, contest_id, problem_id, file_extension)
                end,
                received_contest_problems_path = function(task, file_extension)
                    local home = os.getenv("HOME")
                    local contest_id = "unknown_contest"
                    local problem_id = task.name

                    if task.url then
                        local c, p = task.url:match("contest/(%d+)/problem/([%w%p]+)")
                        if c and p then
                            contest_id, problem_id = c, p
                        end
                        local c2, p2 = task.url:match("problem/(%d+)/([%w%p]+)")
                        if c2 and p2 then
                            contest_id, problem_id = c2, p2
                        end
                    end
                    if problem_id == task.name then
                        local p = task.name:match("^(%w+)%.")
                        if p then problem_id = p end
                    end
                    return string.format("%s/code/codeforces/%s/%s.%s", home, contest_id, problem_id, file_extension)
                end,
                template_file = "$(HOME)/code/codeforces/template.rb",
                received_files_extension = "rb",
                runner_ui = { interface = "popup" },
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            local ls = require("luasnip")
            local s = ls.snippet
            local i = ls.insert_node
            local fmta = require("luasnip.extras.fmt").fmta

            ls.config.set_config({ enable_autosnippets = true })

            ls.add_snippets("tex", {
                s({ trig = "ff", snippetType = "autosnippet" },
                    fmta("\\frac{<>}{<>}", { i(1), i(2) })
                ),
            })
        end
    },

    {
        "3rd/image.nvim",
        opts = {
            max_width = 100,
            max_height = 12,
            max_width_window_percentage = math.huge,
            max_height_window_percentage = math.huge,
            window_overlap_clear_enabled = true,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        }
    },

    {
        "benlubas/molten-nvim",
        version = "^1.0.0",
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
        end,
        keys = {
            { "<leader>mi", ":MoltenInit<CR>",                desc = "Initialize Molten" },
            { "<leader>e",  ":MoltenEvaluateOperator<CR>",    desc = "Evaluate Operator" },
            { "<leader>rl", ":MoltenEvaluateLine<CR>",        desc = "Evaluate Line" },
            { "<leader>re", ":<C-u>MoltenEvaluateVisual<CR>", mode = "v",                desc = "Evaluate Visual" },
            { "<leader>md", ":MoltenDelete<CR>",              desc = "Delete Output" },
        },
    },
}
