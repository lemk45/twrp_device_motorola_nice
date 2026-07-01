#
# Copyright (C) 2026 The Android Open Source Project
# Board Configuration for Motorola mt6878 (nice)
#

DEVICE_PATH := device/motorola/nice

# Para compilar com manifest mínimo do TWRP sem erros de dependência
ALLOW_MISSING_DEPENDENCIES := true

# ==============================================================================
# Architecture
# ==============================================================================
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic

# ==============================================================================
# Platform / Hardware
# ==============================================================================
TARGET_BOARD_PLATFORM := mt6878
TARGET_BOARD_SUFFIX := _64
BOARD_USES_MTK_HARDWARE := true
_BOARD_PLATFORM := mt6878

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := mt6878
TARGET_NO_BOOTLOADER := true

# ==============================================================================
# Display / Resolution
# ==============================================================================
TARGET_SCREEN_HEIGHT := 2712
TARGET_SCREEN_WIDTH := 1220
TARGET_SCREEN_DENSITY := 440

# Hardware Features
BOARD_HAS_MMI_FPS := true       # Fingerprint sensor
BOARD_HAS_MMI_ECOMPASS := true  # E-compass
BOARD_HAS_MMI_NFC := esim_st    # STMicroelectronics NFC / eSIM stub

# ==============================================================================
# Kernel Configuration & Bootargs
# ==============================================================================
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
BOARD_RAMDISK_USE_LZ4 := true
BOARD_BOOT_HEADER_VERSION := 4
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_USES_GENERIC_KERNEL_IMAGE := true

# Endereçamentos corrigidos com base no log do hardware (MediaTek)
BOARD_KERNEL_BASE := 0x40000000
BOARD_PAGE_SIZE := 4096
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x26F08000
BOARD_TAGS_OFFSET := 0x07C88000
BOARD_DTB_OFFSET := 0x07C88000

# Linha de comando do Kernel (Bootargs unificados)
BOARD_KERNEL_CMDLINE := root=/dev/ram nosoftlockup 8250.nr_uarts=3 vmalloc=400M swiotlb=noforce transparent_hugepage=never cgroup.memory=nosocket,nokmem disable_dma32=on firmware_class.path=/vendor/firmware gpt=1 loop.max_part=7 ufshcd_core.poll_queues=0 usb2jtag_mode=0 bootopt=64S3,32N2,64N2 bootconfig
BOARD_VENDOR_CMDLINE := bootopt=64S3,32N2,64N2

# Definições nativas de Imagens Prebuilt do Kernel, DTB e DTBO
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
TARGET_NO_KERNEL_OVERRIDE := true

# Boot assembly arguments
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(BOARD_VENDOR_CMDLINE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_PAGE_SIZE) --board ""
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)

# ==============================================================================
# Módulos do Kernel e Drivers (Essencial para não dar bootloop)
# ==============================================================================
TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true
TW_LOAD_VENDOR_MODULES := $(shell echo \"$(shell ls $(DEVICE_PATH)/recovery/root/vendor/lib/modules)\")

# ==============================================================================
# Partições e Armazenamento
# ==============================================================================
# Bloco Flash adaptado para paginação moderna (BOARD_KERNEL_PAGESIZE * 64)
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_HAS_LARGE_FILESYSTEM := true

# Sistemas de arquivos dinâmicos (O TWRP lida com EXT4/EROFS via recovery.fstab)
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Super Partição Dinâmica
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product odm vendor_dlkm
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 9122611200

# Armazenamento e Criptografia
BOARD_BOOT_DEVICE := soc/112b0000.ufshci

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# ==============================================================================
# Recovery / FSTAB / Init Scripts
# ==============================================================================
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/recovery.fstab

# Carregamento do Init proprietário da MediaTek
TARGET_RECOVERY_DEVICE_MODULES += init.recovery.mt6878.rc

# ==============================================================================
# Verified Boot (AVB) e Anti-Rollback
# ==============================================================================
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Ignorar travas de Anti-Rollback para o Recovery rodar livre
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0

# ==============================================================================
# TWRP Interface / Recursos Customizados e Criptografia
# ==============================================================================
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_MAX_BRIGHTNESS := 2047
TW_NO_SCREEN_BLANK := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_CUSTOM_BATTERY_PATH := "/sys/class/power_supply/battery"
TW_Y_OFFSET := 95
TW_H_OFFSET := -95
TW_INCLUDE_PYTHON := true
TW_SUPPORT_INPUT_1_2 := true

# Criptografia Gatekeeper/Keymaster
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true

# Debug
TW_INCLUDE_LOGCAT := true
TW_USES_LOGD := true

# ==============================================================================
# Ramdisk Ramificações A/B e Vendor Boot
# ==============================================================================
BOARD_USES_RECOVERY_AS_BOOT := false
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
TW_LOAD_VENDOR_BOOT_MODULES := true

# Lista de partições para o sistema A/B de atualização do Recovery
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    system \
    system_ext \
    vendor \
    product \
    boot \
    init_boot \
    vendor_boot \
    dtbo \
    vbmeta \
    vbmeta_system \
    vendor_dlkm \
    system_dlkm
