#
# Copyright (C) 2026 The Android Open Source Project
# Device configuration for Motorola mt6878 (nice)
#

# Device identifier
PRODUCT_DEVICE := nice
PRODUCT_NAME := twrp_nice
PRODUCT_BRAND := motorola
PRODUCT_MODEL := Moto G86
PRODUCT_MANUFACTURER := motorola
PRODUCT_RELEASE_NAME := Moto G86

# Device specific configs (Apontando corretamente para a sua árvore)
$(call inherit-product, device/motorola/nice/device.mk)

# Configure virtual_ab_ota.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Configure twrp config common.mk
$(call inherit-product, vendor/twrp/config/common.mk)

# Configure emulated_storage.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Configure launch_with_vendor_ramdisk.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Configure base.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Configure core_64_bit.mk (Garante a herança correta de bibliotecas de execução)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# FUSE passthrough & TWRP Flags
PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.vendor_boot=true \
    persist.sys.fuse.passthrough.enable=true
