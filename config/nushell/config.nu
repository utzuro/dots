$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.config.edit_mode = "vi"
$env.config.error_style = "fancy"
$env.config.highlight_resolved_externals = true
$env.config.render_right_prompt_on_last_line = false
$env.config.table.mode = "rounded"
$env.config.table.index_mode = "auto"
$env.config.footer_mode = "auto"

$env.config.cursor_shape.emacs = "inherit"
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"

$env.config.history = {
    max_size: 100_000
    sync_on_enter: true
    file_format: "sqlite"
    isolation: false
}

$env.config.completions.algorithm = "fuzzy"
$env.config.completions.case_sensitive = false
$env.config.completions.quick = true
$env.config.completions.partial = true
$env.config.completions.use_ls_colors = true

$env.config.ls.use_ls_colors = true
$env.config.rm.always_trash = false

$env.config.shell_integration = {
    osc2: true
    osc7: true
    osc8: true
    osc9_9: false
    osc133: false
    osc633: false
    reset_application_mode: false
}

if (which starship | is-not-empty) {
    $env.STARSHIP_SHELL = "nu"

    def create_left_prompt [] {
        let duration = ($env.CMD_DURATION_MS? | default 0)
        let status = ($env.LAST_EXIT_CODE? | default 0)
        starship prompt --cmd-duration $duration $'--status=($status)'
    }

    $env.PROMPT_COMMAND = { || create_left_prompt }
    $env.PROMPT_COMMAND_RIGHT = ""
    $env.PROMPT_INDICATOR = ""
    $env.PROMPT_INDICATOR_VI_INSERT = ""
    $env.PROMPT_INDICATOR_VI_NORMAL = ""
    $env.PROMPT_MULTILINE_INDICATOR = "::: "

    $env.TRANSIENT_PROMPT_COMMAND = { || "" }
    $env.TRANSIENT_PROMPT_COMMAND_RIGHT = ""
    $env.TRANSIENT_PROMPT_INDICATOR = ""
    $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = ""
    $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = ""
    $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = ""
}

alias c = clear
alias v = nvim
alias vim = nvim
alias yt = yt-dlp --no-playlist

def tmain [] {
    tmux new-session -A -s main
}

def tls [] {
    tmux list-sessions
}

def --env yy [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    rm -f $tmp

    if ($cwd != "" and $cwd != $env.PWD) {
        cd $cwd
    }
}
