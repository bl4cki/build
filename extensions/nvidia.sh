function extension_prepare_config__build_nvidia_kernel_module() {
	export INSTALL_HEADERS="yes"
	declare -g NVIDIA_DRIVER_VERSION="${NVIDIA_DRIVER_VERSION:-"510"}"
	display_alert "Forcing INSTALL_HEADERS=yes; using nVidia driver version ${NVIDIA_DRIVER_VERSION}" "${EXTENSION}" "debug"
}

function post_install_kernel_debs__build_nvidia_kernel_module() {
	display_alert "Install nVidia packages, build kernel module in chroot" "${EXTENSION}" "info"
	# chroot_sdcard_apt_get_install() is in lib/logging/runners.sh which handles "running" of stuff nicely.
	# chroot_sdcard_apt_get_install() -> chroot_sdcard_apt_get() -> chroot_sdcard() -> run_host_command_logged_raw()
	# it handles bash-specific quoting issues, apt proxies, logging, and errors.
	chroot_sdcard_apt_get_install "nvidia-dkms-${NVIDIA_DRIVER_VERSION}" "nvidia-driver-${NVIDIA_DRIVER_VERSION}" nvidia-settings
}
