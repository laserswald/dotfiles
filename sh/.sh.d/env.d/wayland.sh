
if [ -n "$WAYLAND_DISPLAY" ]
then
	export MOZ_ENABLE_WAYLAND=1
	export MOZ_DBUS_REMOTE=1
fi
