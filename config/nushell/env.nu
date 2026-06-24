$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")

$env.alchemy = ($env.HOME | path join "alchemy")
$env.a = $env.alchemy
$env.magic = ($env.HOME | path join "magic")
$env.m = $env.magic
$env.manuscripts = ($env.alchemy | path join "manuscripts")
$env.manu = $env.manuscripts

$env.GOPATH = ($env.HOME | path join "go")
$env.GOPRIVATE = "github.com/*"
$env.NIXPKGS_ALLOW_INSECURE = "1"
$env.NIXPKGS_ALLOW_UNFREE = "1"
$env.PNPM_HOME = ($env.HOME | path join ".local" "share" "pnpm")

$env.PATH = ($env.PATH
    | prepend [
        ($env.HOME | path join ".local" "bin")
        ($env.GOPATH | path join "bin")
        $env.PNPM_HOME
    ]
    | uniq)
