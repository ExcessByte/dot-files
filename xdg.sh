export XDG_RUNTIME_DIR=/tmp/runtime-$(id -u)

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_BIN_HOME=$HOME/.local/bin
export XDG_TMP_HOME=$HOME/.local/tmp
export XDG_LIB_HOME=$HOME/.local/lib

export PATH="$XDG_BIN_HOME:$PATH"

mkdir -p "$XDG_RUNTIME_DIR" "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_BIN_HOME" "$XDG_TMP_HOME" "$XDG_LIB_HOME"

if [[  -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec dbus-run-session -- start-hyprland
fi
