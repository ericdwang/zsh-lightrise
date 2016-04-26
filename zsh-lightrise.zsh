# Enable Git support
autoload -Uz vcs_info
zstyle ":vcs_info:*" enable git

# Check for staged and unstaged changes
zstyle ":vcs_info:git:*" check-for-changes true
zstyle ":vcs_info:git:*" stagedstr "%F{green}+%f"
zstyle ":vcs_info:git:*" unstagedstr "%F{red}*%f"

# Rebase format
zstyle ":vcs_info:git:*" patch-format " %n/%a"

# Check whether the current branch has diverged from its remote branch
zstyle ":vcs_info:git*+set-message:*" hooks git-status
function +vi-git-status() {
    origin="$(git rev-parse "@{u}" 2>/dev/null)"
    if [[ "$origin" && "$origin" != "$(git rev-parse @)" ]]; then
        hook_com[misc]="%F{blue}#%f"
    fi
}

# Git section format
git_format=" %F{yellow}(%b%f%u%c%m%F{yellow})%f"
zstyle ":vcs_info:git:*" formats "$git_format"
zstyle ":vcs_info:git:*" actionformats "$git_format [%a]"

# Full prompt format
setopt PROMPT_SUBST  # Note: only works with single quotes
precmd() { vcs_info }
PROMPT='%F{white}%B--- %2~%f%b${vcs_info_msg_0_} %F{white}%B>%f%b '
