# TWRP Device Tree for Motorola Moto G86 (nice)

This repository contains the TWRP device tree configuration for the **Motorola Moto G86 (nice)**, powered by the MediaTek MT6878 processor.

## Device Specifications

| Feature | Specification |
|:---|:---|
| SoC | MediaTek Dimensity 7300|
| CPU | 2x Cortex-A78 @ 2.5 GHz & 6x Cortex-A55 @ 2.0 GHz |
| GPU | Mali-G615 MC2 |
| Architecture | arm64-v8a |
| Screen Resolution | 1080 x 2400 |
| Storage | UFS |
| Shipping API | 35 (Android 15) |

## Build Configuration

This tree is structured to build a working bootable custom recovery image using the proper Virtual A/B configuration and dynamic partition routing specific to Motorola's implementation.

* **Status:** Work In Progress / Initial Device Tree Structure.
* **Kernel:** Prebuilt GKI / Stock Motorola Kernel.
* **Partition Scheme:** Virtual A/B with Dynamic Partitions (`system`, `system_ext`, `vendor`, `product`, `odm`, `vendor_dlkm`, `system_dlkm`).

## How to Build

To initialize your workspace and build this recovery repository, run the following commands within your minimal TWRP/OmniROM manifest environment:

```bash
# Clone this repository into your build environment
git clone [https://github.com/YOUR_GITHUB_USERNAME/device_motorola_nice.git](https://github.com/YOUR_GITHUB_USERNAME/device_motorola_nice.git) device/motorola/nice

# Initialize the build environment
source build/envsetup.sh

# Lunch the device target
lunch twrp_nice-eng

# Start building the recovery image
mka recoveryimage
