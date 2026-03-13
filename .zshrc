[ -d "$POSIX_DIR" ] && eval "$("$POSIX_DIR"/../activate)"

# Source config
for file in $ZDOTDIR/config/*; do
  source "$file"
done

