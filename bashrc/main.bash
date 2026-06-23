
# set default fzf command
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'

export STARSHIP_CONFIG=~/.dotfiles/conf/starship.toml

export EDITOR=nvim

# Minimal init for non-interactive shells or when fast init is requested
for file in $DOTFILES/bashrc/init-untracked-fast/*.bash; do
    source "$file"
done

# ============================================
# PERFORMANCE OPTIMIZATION: Instant prompt support
# If running in a non-interactive context (IDE terminals, CI), skip heavy init
# ============================================
if [[ $- != *i* ]] || [[ -n "$ZSH_FAST_INIT" ]]; then
  return 2>/dev/null || exit 0
fi
