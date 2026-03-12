## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
setopt histignorespace                                          # Don't save commands that start with space
setopt globdots                                                 # Don't hide dot files and folders

# Match
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' matcher-list 'r:|?=** m:{a-z\-}={A-Z\_}' # Match fuzzy
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path

# Cache: Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.cache/zsh

# Completion
fpath+=($ZDOTDIR/completions)
autoload -U compinit
compinit -d $HOME/.cache/zsh/.zcompdump

# History
HISTFILE=$HOME/.local/state/zsh/.zhistory
if [[ ! -e "$HISTFILE" ]]; then
	mkdir -p "$(dirname "$HISTFILE")"
	touch "$HISTFILE"
fi
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word
