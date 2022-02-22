setopt PROMPT_SUBST

COMMON_COLORS_GIT_STATUS_DEFAULT=magenta
COMMON_COLORS_GIT_STATUS_STAGED=yellow
COMMON_COLORS_GIT_STATUS_UNSTAGED=red

common_git_status() {
    local message=''
    local message_color="%F{$COMMON_COLORS_GIT_STATUS_DEFAULT}"

    # https://git-scm.com/docs/git-status#_short_format
    local staged=$(git status --porcelain 2>/dev/null | grep -e "^[MADRCU]")
    local unstaged=$(git status --porcelain 2>/dev/null | grep -e "^[MADRCU? ][MADRCU?]")

    if [[ -n ${staged} ]]; then
        message_color="%F{$COMMON_COLORS_GIT_STATUS_STAGED}"
    elif [[ -n ${unstaged} ]]; then
        message_color="%F{$COMMON_COLORS_GIT_STATUS_UNSTAGED}"
    fi

    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -n ${branch} ]]; then
        message+="${message_color}"$'\U2387'"  ${branch} "
    fi

    echo -n "${message}"
}
NEWLINE=$'\n'
PROMPT='%F{red}[%D{%d-%m %H:%M}] %F{cyan}%n%F{red}@%F{yellow}%M %F{green}'$'\U2b95'' %~ $(common_git_status)%f%# '
alias python='python3'
alias pip='pip3'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/pierclgr/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/pierclgr/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/pierclgr/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/pierclgr/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH=/Applications/MiniZincIDE.app/Contents/Resources:$PATH
export PATH=$PATH:/Users/pierclgr/.nexustools

if [ -f $HOME/.zsh_aliases ]
then
  . $HOME/.zsh_aliases
fi

export PATH="$PATH:/Users/pierclgr/flutter/bin"

export MAVEN_HOME=/Library/apache-maven-3.6.3
export PATH=$MAVEN_HOME/bin:$PATH