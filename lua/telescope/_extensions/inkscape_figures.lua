return require("telescope").register_extension({
  -- setup = function(ext_config, config)
  --     -- Access extension config and user config
  -- end,
  exports = {
    inkscape_figures = require("telescope_inkscape").inkscape_figures,
  },
})
