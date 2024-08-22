# NanoPi R5C
BOARD_NAME="NanoPi R5C"
BOARDFAMILY="rk35xx"
BOOTCONFIG="nanopi-r5c-rk3568_defconfig"
BOOT_SOC="rk3568"
KERNEL_TARGET="nanopi"
BOARD_FIRMWARE_INSTALL="-full"
BOOT_LOGO="desktop"
BOOT_FDT_FILE="rockchip/rk3568-nanopi-r5c.dtb"
IMAGE_PARTITION_TABLE="gpt"
BOOT_SCENARIO="spl-blobs"
BOOTFS_TYPE="fat"
WIREGUARD="no"
ENABLE_EXTENSIONS="mesa-vpu"

DDR_BLOB="rk35/rk3568_ddr_1560MHz_v1.18.bin"
BL31_BLOB="rk35/rk3568_bl31_v1.43.elf"

function post_family_config__use_orangepi_uboot() {
        BOOTSOURCE='https://github.com/liwei19920307/u-boot-orangepi.git'
        BOOTBRANCH='branch:v2017.09-rk3588'
        BOOTDIR="u-boot-${BOARD}"
        BOOTPATCHDIR="u-boot-${BOARD}"
        BOOTDELAY=3
}
