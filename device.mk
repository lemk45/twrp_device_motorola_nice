#
# Copyright (C) 2026 The Android Open Source Project
# Device configuration for Motorola mt6878 (nice)
#

DEVICE_PATH := device/motorola/nice

# Configurações de API e SDK desativadas para evitar conflitos com a base twrp-12.1
# O TWRP não precisa dessas definições de nível de envio para compilar o .img

# A/B Updates & Virtual A/B Configurations
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    init_boot \
    vendor_boot \
    dtbo \
    product \
    system \
    system_ext \
    vendor \
    vbmeta \
    vbmeta_system

# Enable Virtual A/B with compression and io_uring
PRODUCT_VIRTUAL_AB_ENABLED := true
PRODUCT_VIRTUAL_AB_COMPRESSION_METHOD := zstd
PRODUCT_PACKAGES += \
    snapuserd.rc

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(DEVICE_PATH)/overlay

# Boot Control HAL (Necessário para recuperação e atualizações A/B)
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-service \
    android.hardware.boot@1.2-mtkimpl \
    android.hardware.boot@1.2-mtkimpl.recovery

# Storage/F2FS Tools (Baseado na criptografia inline e projid do fstab)
PRODUCT_PACKAGES += \
    fsck.f2fs \
    make_f2fs \
    f2fs_io \
    f2fs-tools

# USB Configuration
PRODUCT_PACKAGES += \
    android.hardware.usb-service

# Arquivos de inicialização e partições (fstab)
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/fstab.mt6878:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.mt6878 \
    $(DEVICE_PATH)/rootdir/etc/fstab.mt6878:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6878
