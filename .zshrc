[ -d "$USRP_DIR" ] && eval "$("$USRP_DIR"/activate)"

# Source config
for file in $ZDOTDIR/config/*; do
  source "$file"
done

