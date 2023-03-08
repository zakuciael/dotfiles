local merge_tb = vim.tbl_deep_extend

local M = {}

M.load_mappings = function(mappings, options)
  for mode, values in pairs(mappings) do
    local default_opts = merge_tb("force", { mode = mode }, options or {})

    for keybind, data in pairs(values) do
      local opts = merge_tb("force", default_opts, data.opts or {})

      data.opts, opts.mode = nil, nil
      opts.desc = data[2]

      vim.keymap.set(mode, keybind, data[1], opts)
    end
  end
end

return M
