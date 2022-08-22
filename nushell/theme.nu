let base00 = "#181818" # Base 00 - Black
let base01 = "#ab4642" # Base 08 - Red
let base02 = "#a1b56c" # Base 0B - Green
let base03 = "#f7ca88" # Base 0A - Yellow
let base04 = "#7cafc2" # Base 0D - Blue
let base05 = "#ba8baf" # Base 0E - Magenta
let base06 = "#86c1b9" # Base 0C - Cyan
let base07 = "#d8d8d8" # Base 05 - White
let base08 = "#585858" # Base 03 - Bright Black
let base09 = $'$base01' # Base 08 - Bright Red
let base0a = $'$base02' # Base 0B - Bright Green
let base0b = $'$base03' # Base 0A - Bright Yellow
let base0c = $'$base04' # Base 0D - Bright Blue
let base0d = $'$base05' # Base 0E - Bright Magenta
let base0e = $'$base06' # Base 0C - Bright Cyan
let base0f = "#f8f8f8" # Base 07 - Bright White

let base16 = "#dc9656" # Base 09
let base17 = "#a16946" # Base 0F
let base18 = "#282828" # Base 01
let base19 = "#383838" # Base 02
let base20 = "#b8b8b8" # Base 04
let base21 = "#e8e8e8" # Base 06
let base_foreground = "#d8d8d8" # Base 05
let base_background = "#181818" # Base 00

let base16_theme = {
    separator: $base03
    leading_trailing_space_bg: $base04
    header: $base0b
    date: $base0e
    filesize: $base0d
    row_index: $base0c
    bool: $base08
    int: $base0b
    duration: $base08
    range: $base08
    float: $base08
    string: $base04
    nothing: $base08
    binary: $base08
    cellpath: $base08
    hints: dark_gray

    # shape_garbage: { fg: $base07 bg: $base08 attr: b} # base16 white on red
    # but i like the regular white on red for parse errors
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_bool: $base0d
    shape_int: { fg: $base0e attr: b}
    shape_float: { fg: $base0e attr: b}
    shape_range: { fg: $base0a attr: b}
    shape_internalcall: { fg: $base0c attr: b}
    shape_external: $base0c
    shape_externalarg: { fg: $base0b attr: b}
    shape_literal: $base0d
    shape_operator: $base0a
    shape_signature: { fg: $base0b attr: b}
    shape_string: $base0b
    shape_filepath: $base0d
    shape_globpattern: { fg: $base0d attr: b}
    shape_variable: $base0e
    shape_flag: { fg: $base0d attr: b}
    shape_custom: {attr: b}
}
