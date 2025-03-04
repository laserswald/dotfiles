
if [ -n "$WAYLAND_DISPLAY" ]
then
	export MOZ_ENABLE_WAYLAND=1
	export MOZ_DBUS_REMOTE=1

	# Fixes an issue with GTK 4, Vulkan and AMDGPU.
	# See https://bbs.archlinux.org/viewtopic.php?id=302001
	export GSK_RENDERER=gl
fi

