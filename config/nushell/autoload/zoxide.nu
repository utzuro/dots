export-env {
    $env.config = ($env.config
        | upsert hooks { default {} }
        | upsert hooks.env_change { default {} }
        | upsert hooks.env_change.PWD { default [] })

    let hooked = ($env.config.hooks.env_change.PWD | any { try { get __zoxide_hook } catch { false } })

    if not $hooked {
        $env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD | append {
            __zoxide_hook: true
            code: {|_, dir|
                if (which zoxide | is-not-empty) {
                    ^zoxide add -- $dir
                }
            }
        })
    }
}

export def --env --wrapped z [...rest: string] {
    let arg0 = ($rest | append "~").0
    let path = if (($rest | length) <= 1) and ($arg0 == "-" or ($arg0 | path expand | path type) == dir) {
        $arg0
    } else {
        if (which zoxide | is-empty) {
            error make { msg: "zoxide is not installed" }
        }

        ^zoxide query --exclude $env.PWD -- ...$rest | str trim --right --char "\n"
    }

    cd $path
}

export def --env --wrapped zi [...rest: string] {
    if (which zoxide | is-empty) {
        error make { msg: "zoxide is not installed" }
    }

    let path = (^zoxide query --interactive -- ...$rest | str trim --right --char "\n")

    if $path != "" {
        cd $path
    }
}
