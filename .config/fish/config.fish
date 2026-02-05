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

# In fish, history append is default, no PROMPT_COMMAND needed

# Allow ctrl-s
if status is-interactive
    stty -ixon
end

# Editor variables
set -x EDITOR nvim
set -x VISUAL nvim

# PATH additions
set -x PATH $PATH $HOME/.dotfiles/bin $HOME/.local/bin $HOME/.cargo/bin

# Custom env vars
set -x vscodium code

# Colors for ls/grep
set -x CLICOLOR 1
set -x LS_COLORS 'no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

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

alias rr 'curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias cat 'bat'
alias vim 'nvim'
alias vi 'nvim'
alias please 'sudo'
alias finger 'touch'

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
            switch $archive
                case '*.tar.bz2'   ; tar xvjf $archive
                case '*.tar.gz'    ; tar xvzf $archive
                case '*.bz2'       ; bunzip2 $archive
                case '*.rar'       ; rar x $archive
                case '*.gz'        ; gunzip $archive
                case '*.tar'       ; tar xvf $archive
                case '*.tbz2'      ; tar xvjf $archive
                case '*.tgz'       ; tar xvzf $archive
                case '*.zip'       ; unzip $archive
                case '*.Z'         ; uncompress $archive
                case '*.7z'        ; 7z x $archive
                case '*'           ; echo "don't know how to extract '$archive'..."
            end
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
        set path $path/..
    end
    cd $path
end


# Auto-ls after cd (except VSCode)
if test "$TERM_PROGRAM" != "vscode"
    function cd
        if set -q argv[1]
            z $argv; and ls
        else
            z ~; and ls
        end
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
#   AUTOJUMP
# ============================

# if test -f /usr/share/autojump/autojump.fish
#     source /usr/share/autojump/autojump.fish
# else
#     echo "autojump fish script not found"
# end

# ============================
#   OTHER SETTINGS
# ============================

# Clean temp session
rm -rf ~/.temp_session
mkdir -p ~/.temp_session

# Android SDK
set -x ANDROID_HOME $HOME/Android/Sdk

set -g fish_greeting ""
