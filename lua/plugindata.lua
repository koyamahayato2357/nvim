local map = vim.keymap.set

return {
    ['folke/flash.nvim'] = {
        modname = 'flash',
        opts = {},
        callback = function()
            local flash = require 'flash'
            flash.toggle(true)
        end
    },
    ['gbprod/substitute.nvim'] = {
        modname = 'substitute',
        callback = function()
            local sub = require 'substitute'
            map('n', 's', sub.operator)
            map('n', 'ss', sub.line)
            map('n', 'S', sub.eol)
            map('x', 's', sub.visual)
        end
    },
    ['kylechui/nvim-surround'] = {
        modname = 'nvim-surround',
        opts = {},
    },
    ['stevearc/oil.nvim'] = {
        modname = 'oil',
        opts = {
            columns = {
                'icon',
                'permission',
                'size',
                'mtime'
            },
        },
        callback = function()
            local oil = require 'oil'
            map('n', '^o', function() oil.toggle_float() end)
        end,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        }
    },
    ['vim-jp/vimdoc-ja'] = {},
    ['vim-jp/nvimdoc-ja'] = {},
    ['altermo/ultimate-autopair.nvim'] = {
        modname = 'ultimate-autopair',
        opts = {
            fastwarp = {
                rmap = '<A-y>',
                rcmap = '<A-y>',
            },
            tabout = {
                multi = true,
                enable = true,
                hopout = true,
            },
            bs = {
                indent_ignore = true,
            },
            space2 = {
                enable = true,
            },
            extensions = {
                fly = {
                    multiline = true,
                    enable = true
                },
            }
        },
    },
    ['utilyre/sentiment.nvim'] = {
        modname = 'sentiment',
        opts = {},
        callback = function()
            vim.g.loaded_matchparen = 1
        end
    },
    ['nvim-tree/nvim-web-devicons'] = {},
    ['niuiic/core.nvim'] = {},
    ['niui/track.nvim'] = {
        modname = 'track',
        opts = {},
        callback = function()
            local track = require 'track'
            local markfile = vim.fn.stdpath('data') .. '/marks/mark.json'
            map('n', 'ma', track.add_mark)
            map('n', 'mA', track.add_flow)
            map('n', 'md', track.delete_mark)
            map('n', 'mD', track.delete_flow)
            map('n', 'mu', track.update_mark)
            map('n', 'mU', track.update_flow)
            map('n', 'ms', function() track.store_marks(markfile) end)
            track.restore_marks(markfile)
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'niuiic/core.nvim',
        },
    },
    ['nvim-lua/plenary.nvim'] = {},
    ['nvim-telescope/telescope.nvim'] = {
        modname = 'telescope',
        opts = {},
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },
    ['hadronized/hop.nvim'] = {
        modname = 'hop',
        opts = {},
        callback = function()
            local hop = require 'hop'
            map('n', 'gw', hop.hint_words)
            map('n', 'ga', hop.hint_anywhere)
        end
    },
    ['zbirenbaum/copilot.lua'] = {
        modname = 'copilot',
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = false,
                keymap = {
                    accept = '<C-S-y>',
                    next = '<C-S-n>',
                    prev = '<C-S-p>',
                    dismiss = '<C-S-e>',
                }
            },
            filetypes = {
                gitcommit = true
            }
        },
        callback = function()
            map('n', '^a', require 'copilot.suggestion'.toggle_auto_trigger)
        end
    },
    ['nvim-treesitter/nvim-treesitter'] = {
        modname = 'nvim-treesitter',
        opts = { ensure_installed = 'all' },
    },
    ['folke/snacks.nvim'] = {
        modname = 'snacks',
        opts = {
            indent = {
                enabled = true,
                char = "│",
            },
            dashboard = {
                width = 60,
                row = nil,                                                                   -- dashboard position. nil for center
                col = nil,                                                                   -- dashboard position. nil for center
                pane_gap = 4,                                                                -- empty columns between vertical panes
                autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
                -- These settings are used by some built-in sections
                sections = {
                    {
                        section = 'terminal',
                        cmd = 'cat ~/.config/nvim/data/dashboard-header.txt | tte beams',
                        height = 20
                    },
                    {
                        pane = 2,
                        section = "terminal",
                        cmd = "~/bin/colorscript -e square",
                        height = 5,
                        padding = 1,
                    },
                    { section = "keys", gap = 1, padding = 1 },
                    { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Git Status",
                        section = "terminal",
                        enabled = function()
                            return require 'snacks'.git.get_root() ~= nil
                        end,
                        cmd = "hub status --short --branch --renames",
                        height = 5,
                        padding = 1,
                        ttl = 5 * 60,
                        indent = 3,
                    },
                },
            }
        },
        callback = function()
            local snacks = require 'snacks'
            snacks.indent.enable()
            vim.api.nvim_create_user_command('L', function(_)
                vim.cmd.wa()
                snacks.lazygit()
            end, { nargs = 0 })
            vim.keymap.set('n', '^t', snacks.terminal.toggle)
        end,
    },
    ['SmiteshP/nvim-navic'] = {
        modname = 'nvim-navic',
        opts = {
            lsp = { auto_attach = true },
            highlight = true
        }
    },
    ['SmiteshP/nvim-navbuddy'] = {
        modname = 'nvim-navbuddy',
        opts = {
            lsp = { auto_attach = true },
            highlight = true
        },
        dependencies = {
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim'
        }
    },
    ['MunifTanjim/nui.nvim'] = {
        modname = 'nui',
    },
    ['andersevenrud/nvim_context_vt'] = {
        modname = 'nvim_context_vt',
        opts = {
            enabled = true,
        },
    },
    ['sphamba/smear-cursor.nvim'] = {
        modname = 'smear_cursor',
        opts = {},
    },
}
