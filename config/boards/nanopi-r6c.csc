# NanoPi R6C
BOARD_NAME="NanoPi R6C"
BOARDFAMILY="rk35xx"
BOOTCONFIG="nanopi-r6c-rk3588s_defconfig"
BOOT_SOC="rk3588"
KERNEL_TARGET="legacy"
BOARD_FIRMWARE_INSTALL="-full"
BOOT_LOGO="desktop"
BOOT_FDT_FILE="rockchip/rk3588s-nanopi-r6c.dtb"
IMAGE_PARTITION_TABLE="gpt"
BOOT_SCENARIO="spl-blobs"
BOOTFS_TYPE="fat"
WIREGUARD="no"
ENABLE_EXTENSIONS="mesa-vpu"

DDR_BLOB="rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v1.15.bin"
BL31_BLOB="rk35/rk3588_bl31_v1.45.elf"

<<<<<<< HEAD
function post_family_config__use_orangepi_uboot() {
        BOOTSOURCE='https://github.com/liwei19920307/u-boot-orangepi.git'
        BOOTBRANCH='branch:v2017.09-rk3588'
        BOOTDIR="u-boot-${BOARD}"
        BOOTPATCHDIR="u-boot-${BOARD}"
        BOOTDELAY=3
=======
	mkdir -p $SDCARD/etc/udev/rules.d/
	cat <<- EOF > $SDCARD/etc/udev/rules.d/90-naming-audios.rules
		SUBSYSTEM=="sound", ENV{ID_PATH}=="platform-hdmi0-sound", ENV{SOUND_DESCRIPTION}="HDMI0 Audio"'
	EOF
}

function post_family_tweaks__nanopi_r6c_naming_udev_network_interfaces() {
	display_alert "$BOARD" "Renaming NanoPi R6C network interfaces to 'wan' and 'lan'" "info"

	mkdir -p $SDCARD/etc/udev/rules.d/
	cat <<- EOF > "${SDCARD}/etc/udev/rules.d/70-persistent-net.rules"
		SUBSYSTEM=="net", ACTION=="add", KERNELS=="fe1c0000.ethernet", NAME:="wan"
		SUBSYSTEM=="net", ACTION=="add", KERNELS=="0003:31:00.0", NAME:="lan"
	EOF
}

# Mainline U-Boot
function post_family_config__nanopi_r6c_use_mainline_uboot() {
	display_alert "$BOARD" "Using mainline U-Boot for $BOARD / $BRANCH" "info"

	declare -g BOOTCONFIG="generic-rk3588_defconfig"             # Use generic defconfig which should boot all RK3588 boards
	declare -g BOOTDELAY=1                                       # Wait for UART interrupt to enter UMS/RockUSB mode etc
	declare -g BOOTSOURCE="https://github.com/u-boot/u-boot.git" # We ❤️ Mainline U-Boot
	declare -g BOOTBRANCH="tag:v2024.07"
	declare -g BOOTPATCHDIR="v2024.07/board_${BOARD}"
	# Don't set BOOTDIR, allow shared U-Boot source directory for disk space efficiency

	declare -g UBOOT_TARGET_MAP="BL31=${RKBIN_DIR}/${BL31_BLOB} ROCKCHIP_TPL=${RKBIN_DIR}/${DDR_BLOB};;u-boot-rockchip.bin"

	# Disable stuff from rockchip64_common; we're using binman here which does all the work already
	unset uboot_custom_postprocess write_uboot_platform write_uboot_platform_mtd

	# Just use the binman-provided u-boot-rockchip.bin, which is ready-to-go
	function write_uboot_platform() {
		dd "if=$1/u-boot-rockchip.bin" "of=$2" bs=32k seek=1 conv=notrunc status=none
	}
>>>>>>> 269d7110b2e47ead78d1c6048f7467545423ad54
}
