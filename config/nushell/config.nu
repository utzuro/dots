$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.config.edit_mode = "vi"
$env.config.error_style = "fancy"
$env.config.highlight_resolved_externals = true
$env.config.table.mode = "rounded"
$env.config.table.index_mode = "auto"
$env.config.footer_mode = "auto"

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

alias c = clear
alias v = nvim
alias vim = nvim
alias yt = yt-dlp --no-playlist

def --env yy [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    rm -f $tmp

    if ($cwd != "" and $cwd != $env.PWD) {
        cd $cwd
    }
}
