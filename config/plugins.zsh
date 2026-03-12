## Plugins section: Enable fish style features

plugins=(
  zsh-syntax-highlighting
  zsh-history-substring-search
  zsh-autosuggestions
  # zsh-autocomplete
  # fzf-tab
  # itlt
  )

for i in "${plugins[@]}"
do
  source "$ZDOTDIR"/plugins/$i/$i.zsh
done

# Use syntax highlighting
# source "$ZDOTDIR"/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Use history substring search
# source "$ZDOTDIR"/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

# Offer to install missing package if command is not found
# if [[ -r /usr/share/zsh/functions/command-not-found.zsh ]]; then
#     source /usr/share/zsh/functions/command-not-found.zsh
#     export PKGFILE_PROMPT_INSTALL_MISSING=1
# fi

# zsh-autosuggestion
# source "$ZDOTDIR"/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=5"
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
  "${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#forward-char}"
)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
  "${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#end-of-line}"
)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(
  forward-char
  end-of-line
)
ZSH_AUTOSUGGEST_STRATEGY=(
  history
  completion
)

# live fuzzy autocomletion
source "$ZDOTDIR"/plugins/itlt/itlt.zsh

