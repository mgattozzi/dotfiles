# Nushell Config File

# git completions and aliases
source '/home/michael/.config/nushell/git.nu'
use git *

# neovim
source '/home/michael/.config/nushell/neovim.nu'

# Terminal Theme
source '/home/michael/.config/nushell/theme.nu'

# Work Configs
source '/home/michael/.config/nushell/work.nu'

# Private Configs
source '/home/michael/.config/nushell/private.nu'

# Functions
source '/home/michael/.config/nushell/functions.nu'

# zoxide
source '/home/michael/.config/nushell/zoxide.nu'

# The default config record. This is where much of your global configuration is setup.
let-env config = {
  filesize_metric: false
  table_mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
  use_ls_colors: true
  rm_always_trash: false
  color_config: $base16_theme
  use_grid_icons: true
  footer_mode: 'auto'
  quick_completions: true
  partial_completions: true
  completion_algorithm: 'fuzzy'
  float_precision: 2
  buffer_editor: 'nvim'
  use_ansi_coloring: true
  filesize_format: 'auto'
  edit_mode: vi
  max_history_size: 10000000
  sync_history_on_enter: true
  history_file_format: 'sqlite'
  shell_integration: true
  disable_table_indexes: false
  cd_with_abbreviations: true
  case_sensitive_completions: false
  enable_external_completion: true
  max_external_completion_results: 100
  table_trim: {
    methodology: wrapping,
    wrapping_try_keep_words: true,
  }
  show_banner: false
  hooks: {
    pre_prompt: [{
      $nothing
    }]
    pre_execution: [{
      $nothing
    }]
    env_change: {
      PWD: [{|before, after|
        $nothing
      }]
    }
  }
  menus: [
      {
        name: completion_menu
        only_buffer_difference: false
        marker: "| "
        type: {
            layout: columnar
            columns: 4
            # col_width: 20
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: help_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: description
            columns: 4
            # col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: commands_menu
        only_buffer_difference: false
        marker: "# "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
      {
        name: vars_menu
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.vars
            | where name =~ $buffer
            | sort-by name
            | each { |it| {value: $it.name description: $it.type} }
        }
      }
      {
        name: commands_with_description
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
  ]
  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: vi_insert
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menuprevious }
    }
    {
      name: history_menu
      modifier: control
      keycode: char_r
      mode: emacs
      event: { send: menu name: history_menu }
    }
    {
      name: next_page
      modifier: control
      keycode: char_x
      mode: emacs
      event: { send: menupagenext }
    }
    {
      name: undo_or_previous_page
      modifier: control
      keycode: char_z
      mode: emacs
      event: {
        until: [
          { send: menupageprevious }
          { edit: undo }
        ]
       }
    }
    {
      name: yank
      modifier: control
      keycode: char_y
      mode: emacs
      event: {
        until: [
          {edit: pastecutbufferafter}
        ]
      }
    }
    {
      name: unix-line-discard
      modifier: control
      keycode: char_u
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cutfromlinestart}
        ]
      }
    }
    {
      name: kill-line
      modifier: control
      keycode: char_k
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cuttolineend}
        ]
      }
    }
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: alt
      keycode: char_o
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
    {
      name: commands_with_description
      modifier: control
      keycode: char_s
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_with_description }
    }
  ]
}

if 'TMUX' in (env).name != true {
  do -i {
    tmux attach -t default
  }

  if $env.LAST_EXIT_CODE > 0 {
    do -i {
      tmux new -s default
    }
  }
}
