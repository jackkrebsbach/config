local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local function list_figures()
  local i, t = 0, {}
  local current_dir = vim.fn.expand('%:p:h')
  local files = vim.fn.glob(current_dir .. '/figures/**/*.svg', false, true)

  for _, file in ipairs(files) do
    local relative_path = vim.fn.fnamemodify(file, ':t')
    i = i + 1
    t[i] = relative_path
  end

  return t
end

local function find_svg_figures()
  return finders.new_table({
    results = list_figures(),
  })
end

function M.inkscape_figures()
  pickers
      .new(require("telescope.themes").get_dropdown({}), {
        prompt_title = "Figures",
        finder = find_svg_figures(),
        sorter = conf.file_sorter(),
        attach_mappings = function(prompt_bufnr)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local cmd = string.format("inkscape-figures-manager edit %s", "figures/" .. selection[1])
            local output = vim.fn.system(cmd)
            if vim.v.shell_error ~= 0 then
              print("Command failed with output:", output)
              vim.notify("Failed to open figure: " .. output, vim.log.levels.ERROR)
            end
          end)
          return true
        end,
      })
      :find()
end

return M
