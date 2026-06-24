let home = $nu.home-dir
let is_windows = ($nu.os-info.name == "windows")

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

if not $is_windows {
    $env.XDG_CONFIG_HOME = ($home | path join ".config")
}

$env.alchemy = ($home | path join "alchemy")
$env.a = $env.alchemy
$env.magic = ($home | path join "magic")
$env.m = $env.magic
$env.manuscripts = ($env.alchemy | path join "manuscripts")
$env.manu = $env.manuscripts

$env.GOPATH = ($home | path join "go")
$env.GOPRIVATE = "github.com/*"
$env.NIXPKGS_ALLOW_INSECURE = "1"
$env.NIXPKGS_ALLOW_UNFREE = "1"
$env.PNPM_HOME = ($home | path join ".local" "share" "pnpm")

$env.PATH = ($env.PATH
    | prepend [
        ($home | path join ".local" "bin")
        ($env.GOPATH | path join "bin")
        $env.PNPM_HOME
    ]
    | uniq)
