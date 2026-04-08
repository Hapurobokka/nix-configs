use std/util "path add"
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false
$env.__zoxide_hooked = true
$env.config.edit_mode = "vi"

path add "~/.emacs.d/bin"
path add "~/.bin"
path add "~/.local/bin/"
path add "~/.local/share/nvim/mason/staging/nil/bin"
path add "~/.config/emacs/bin"

source ~/.zoxide.nu
source ./nb-completions.nu
source ./completions-jj.nu

$env.LD_LIBRARY_PATH = $"/nix/store/qi7spcan9lv78ag41bsmjrrhqrw496kq-libx11-1.8.13/lib:($env.LD_LIBRARY_PATH? | default '')"

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD | append { ||
    if (which direnv | is-empty) {
        return
    }

    direnv export json | from json | default {} | load-env
})
