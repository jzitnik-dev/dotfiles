# ============================
#   STARTUP BEHAVIOR
# ============================

zoxide init fish | source

# Detect interactive shell
set -l iatest (string match -q "*i*" $fish_killring)

# Run fastfetch unless VSCode terminal or certain TERM
if test "$TERM_PROGRAM" != "vscode" -a "$TERM" != "xterm-256color"
    fastfetch
    # colorscript -r
end


# ============================
#   EXPORTS / ENV VARS
# ============================

# history behavior
set -x HISTCONTROL "erasedups:ignoredups:ignorespace"

# Allow ctrl-s
if status is-interactive
    stty -ixon
end

# Editor variables
set -x EDITOR nvim
set -x VISUAL nvim

# PATH additions
set -x PATH $PATH $HOME/.dotfiles/bin $HOME/.local/bin $HOME/.cargo/bin $HOME/go/bin

# Custom env vars
set -x vscodium code

# Colors for ls/grep
set -x CLICOLOR 1

# manpage colors (these variables work the same in fish)
set -x LESS_TERMCAP_mb (printf '\e[01;31m')
set -x LESS_TERMCAP_md (printf '\e[01;31m')
set -x LESS_TERMCAP_me (printf '\e[0m')
set -x LESS_TERMCAP_se (printf '\e[0m')
set -x LESS_TERMCAP_so (printf '\e[01;44;33m')
set -x LESS_TERMCAP_ue (printf '\e[0m')
set -x LESS_TERMCAP_us (printf '\e[01;32m')


# ============================
#   ALIASES
# ============================

alias alert 'notify-send --urgency=low -i (test $status -eq 0; and echo terminal; or echo error) (history | tail -n1)'
alias da 'date "+%Y-%m-%d %A %T %Z"'
alias rebootsafe 'sudo shutdown -r now'
alias rebootforce 'sudo shutdown -r -n now'

alias ls 'exa -l --color=always --group-directories-first'
alias la 'exa -al --color=always --group-directories-first'

alias cat 'bat -p'
alias vim 'nvim'
alias vi 'nvim'

# ============================
#   FUNCTIONS
# ============================

function edit
    nvim $argv
end

function sedit
    sudo nvim $argv
end

# Extract archives
function extract
    for archive in $argv
        if test -f "$archive"
          bsdtar -xvf "$archive"
        else
            echo "'$archive' is not a valid file!"
        end
    end
end

function cpg
    if test -d "$argv[2]"
        cp $argv[1] $argv[2]
        cd $argv[2]
    else
        cp $argv[1] $argv[2]
    end
end

function mvg
    if test -d "$argv[2]"
        mv $argv[1] $argv[2]
        cd $argv[2]
    else
        mv $argv[1] $argv[2]
    end
end

function mkdirg
    mkdir -p $argv[1]
    cd $argv[1]
end

function up
    set -l limit $argv[1]
    set -l path ""
    for i in (seq $limit)
        set path "$path../"
    end
    cd $path
end

function upe
    set -l limit $argv[1]
    set -l path ""
    for i in (seq $limit)
        set path "$path../"
    end
    set resolved_path (path normalize "$PWD/$path")
    echo $resolved_path
end

function cd
    if set -q argv[1]
        z $argv; and ls
    else
        z ~; and ls
    end
end


# Trim whitespace
function trim
    set -l var (string join " " $argv)
    set var (string trim $var)
    echo -n $var
end


# ============================
#   STARSHIP
# ============================

starship init fish | source

# ============================
#   OTHER SETTINGS
# ============================

# Clean temp session
rm -rf ~/.temp_session
mkdir -p ~/.temp_session

# Android SDK
set -x ANDROID_HOME $HOME/.Android/Sdk

set -g fish_greeting ""
