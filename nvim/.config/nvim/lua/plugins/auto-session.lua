return {
    'rmagatti/auto-session',
    lazy = false,
    keys = {
        { '<leader>Sr', '<cmd>AutoSession restore<CR>', desc = 'Restaurar última sesión' },
        { '<leader>Ss', '<cmd>AutoSession search<CR>', desc = 'Buscar sesión' },
        -- { '<leader>Sa', '<cmd>AutoSession save<CR>', desc = 'Guardar sesión' },
        -- Guardar sesión con nombre personalizado
        {
            '<leader>Sa',
            function()
                local session_name = vim.fn.input("Nombre de la sesión: ")
                if session_name and session_name ~= "" then
                    vim.cmd("AutoSession save " .. session_name)
                else
                    print("Operación cancelada: Nombre no válido")
                end
            end,
            desc = 'Guardar sesión con nombre',
        },
    },

    opts = {
        auto_restore = false, -- Deshabilita restaurar automáticamente la última sesión
        auto_save = true, -- Guarda automáticamente las sesiones al salir de nvim
        root_dir = vim.fn.stdpath("data") .. "/sessions/", -- Directorio donde se guardan las sesiones
        -- suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        session_lens = {
            load_on_setup = true, -- Activa el selector de sesiones al usar Telescope
            previewer = false, -- Sin vista previa en el selector
            mappings = {
                -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
                delete_session = { { "i", "n" }, "<C-D>" },
                alternate_session = { "i", "<C-S>" },
                copy_session = { "i", "<C-Y>" },
            },
            -- Can also set some Telescope picker options
            -- For all options, see: https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
            theme_conf = {
                border = true,
                -- layout_config = {
                --   width = 0.8, -- Can set width and height as percent of window
                --   height = 0.5,
                -- },
            },
        },
        log_level = "error", -- Log mínimo para evitar mensajes innecesarios
    },
}

