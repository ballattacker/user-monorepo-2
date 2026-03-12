[ -d "$CONFIG_USER" ] && source $CONFIG_USER/env

# Source config
for file in $ZDOTDIR/config/*; do
  source "$file"
done

