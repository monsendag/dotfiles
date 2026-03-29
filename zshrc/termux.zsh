
# Termux-specific initialization. Abort if not Termux.
[[ -n "$TERMUX_VERSION" ]] || [[ "$PREFIX" == *termux* ]] || return 0

export PATH="$PREFIX/bin:$PATH"
