# Nushell Environment Config File
let-env STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = ""
let-env PROMPT_INDICATOR_VI_INSERT = ": "
let-env PROMPT_INDICATOR_VI_NORMAL = "〉"
let-env PROMPT_MULTILINE_INDICATOR = "::: "

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str collect (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str collect (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# PATH Env Var
let-env PATH = ($env.PATH | split row (char esep) | append $'($env.HOME)/.bin')
let-env PATH = ($env.PATH | split row (char esep) | append $'($env.HOME)/.cargo/bin')
let-env PATH = ($env.PATH | split row (char esep) | append '/usr/bin')
let-env PATH = ($env.PATH | split row (char esep) | append '/usr/local/bin')
let-env PATH = ($env.PATH | split row (char esep) | sort | uniq)

# Personal Env Vars
let-env EDITOR = 'nvim'
let-env PAGER = 'less'
let-env TERM = 'xterm-256color'
let-env RUST_SRC_PATH = $'(^rustc --print sysroot)/lib/rustlib/src/rust/src'
let-env XDG_RUNTIME_DIR = $'/run/user/(^id -u)'
let-env NVM_DIR = $'($env.HOME)/.nvm'
let-env WASMTIME_HOME = $'($env.HOME)/.wasmtime'
let-env CLOUDSDK_PYTHON = $'(which python2 | get path.0)'
