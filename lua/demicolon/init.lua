local keymaps = require('demicolon.keymaps')

local M = {}

---@class demicolon.diagnostic.options
---@field float? boolean|vim.diagnostic.Opts.Float Default options passed to diagnostic floating window

<<<<<<< HEAD
---@class demicolon.keymaps.options
---@field horizontal_motions? boolean Create `t`/`T`/`f`/`F` key mappings
---@field repeat_motions? 'stateless' | 'stateful' | false Create `;` and `,` key mappings. `'stateless'` means that `;`/`,` move right/left. `'stateful'` means that `;`/`,` will remember the direction of the original jump, and `,` inverts that direction (Neovim's default behaviour).
---@field disabled_keys? table<string> Keys that shouldn't be repeatable (because aren't motions), excluding the prefix `]`/`[`
=======
---@class DemicolonAlternativeRepeatSpec
---@field key? string|string[] Key(s) that trigger the repeat
---@field fallback? string Fed when no demicolon motion is active

---@class DemicolonAlternativeRepeatOptions
---@field enabled boolean Enable alternative repeat keymaps
---@field forward?  DemicolonAlternativeRepeatSpec Configuration for forward repeat
---@field backward? DemicolonAlternativeRepeatSpec Configuration for backward repeat
---@field reset_on_search? boolean Reset stored motion after `/` or `?`

---@class DemicolonKeymapsOptions
---@field horizontal_motions? boolean Create `t`/`T`/`f`/`F` key mappings
---@field diagnostic_motions? boolean Create ]d/[d, etc. key mappings to jump to diganostics. See demicolon.keymaps.create_default_diagnostic_keymaps.
---@field repeat_motions? boolean Create `;` and `,` key mappings
---@field list_motions? boolean Create `]q`/`[q`/`]<C-q>`/`[<C-q>` and `]l`/`[l`/`]<C-l>`/`[<C-l>` quickfix and location list mappings
---@field spell_motions? boolean Create `]s`/`[s` key mappings for jumping to spelling mistakes
---@field fold_motions? boolean Create `]z`/`[z` key mappings for jumping to folds
---@field alternative_repeat? DemicolonAlternativeRepeatOptions Configure alternative repeat keymaps
>>>>>>> 77b60b9 (feat: add configurable alternative-repeat keys)

---@class demicolon.options
---@field diagnostic? demicolon.diagnostic.options Diagnostic options
---@field keymaps? demicolon.keymaps.options Create default keymaps
local options = {
  keymaps = {
    horizontal_motions = true,
<<<<<<< HEAD
    repeat_motions = 'stateless',
    disabled_keys = { 'p', 'I', 'A', 'f', 'i' },
=======
    diagnostic_motions = true,
    repeat_motions = true,
    list_motions = true,
    spell_motions = true,
    fold_motions = true,
    alternative_repeat = {
      enabled = false,
      forward = {},
      backward = {},
      reset_on_search = true,
    },
  },
  integrations = {
    gitsigns = {
      enabled = true,
      keymaps = {
        next = ']c',
        prev = '[c',
      },
    },
    neotest = {
      enabled = true,
      keymaps = {
        test = {
          next = ']t',
          prev = '[t',
        },
        failed_test = {
          next = ']T',
          prev = '[T',
        },
      },
    },
    vimtex = {
      enabled = true,
      keymaps = {
        section_start = {
          next = ']]',
          prev = '[[',
        },
        section_end = {
          next = '][',
          prev = '[]',
        },
        frame_start = {
          next = ']r',
          prev = '[r',
        },
        frame_end = {
          next = ']R',
          prev = '[R',
        },
        math_start = {
          next = ']n',
          prev = '[n',
        },
        math_end = {
          next = ']N',
          prev = '[N',
        },
        comment_start = {
          next = ']/',
          prev = '[/',
        },
        comment_end = {
          next = ']*',
          prev = '[*',
        },
        environment_start = {
          next = ']m',
          prev = '[m',
        },
        environment_end = {
          next = ']M',
          prev = '[M',
        },
      },
    },
>>>>>>> 77b60b9 (feat: add configurable alternative-repeat keys)
  },
}

---@return demicolon.options
function M.get_options()
  return options
end

---@param opts? demicolon.options
function M.setup(opts)
  options = vim.tbl_deep_extend('force', options, opts or {})
<<<<<<< HEAD
=======

  local alt = options.keymaps.alternative_repeat or { enabled = false }
  if alt.enabled then
    options.keymaps.repeat_motions = false
  end
>>>>>>> 77b60b9 (feat: add configurable alternative-repeat keys)

  if options.keymaps.horizontal_motions then
    keymaps.create_default_horizontal_keymaps()
  end

  local repeat_behaviour = options.keymaps.repeat_motions
  if repeat_behaviour ~= false then
    keymaps.create_default_repeat_keymaps(repeat_behaviour)
  end

  require('demicolon.deprecation').warn_for_deprecated_options(options)

<<<<<<< HEAD
  require('demicolon.listen').listen_for_repetable_bracket_motions(options.keymaps.disabled_keys)
=======
  if options.keymaps.list_motions then
    keymaps.create_default_list_keymaps()
  end

  if options.keymaps.spell_motions then
    keymaps.create_default_spell_keymaps()
  end

  if options.keymaps.fold_motions then
    keymaps.create_default_fold_keymaps()
  end

  if alt.enabled then
    keymaps.create_alternative_repeat_keymaps(alt)

    if alt.reset_on_search then
      local ts_move = require('nvim-treesitter.textobjects.repeatable_move')
      vim.api.nvim_create_autocmd('CmdlineLeave', {
        pattern = { '/', '\\?' },
        callback = function()
          ts_move.last_move = nil
        end,
        desc = 'demicolon.nvim: reset alternative-repeat after / or ?',
      })
    end
  end

  if options.integrations.gitsigns.enabled then
    require('demicolon.integrations.gitsigns').create_keymaps()
  end

  if options.integrations.neotest.enabled then
    require('demicolon.integrations.neotest').create_keymaps()
  end

  if options.integrations.vimtex.enabled then
    require('demicolon.integrations.vimtex').create_keymaps()
  end
>>>>>>> 77b60b9 (feat: add configurable alternative-repeat keys)
end

return M
