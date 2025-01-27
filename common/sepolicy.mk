#
# This policy configuration will be used by all products that
# inherit from Custom
#

ifeq ($(TARGET_COPY_OUT_VENDOR), vendor)
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
TARGET_USES_PREBUILT_VENDOR_SEPOLICY ?= true
endif
endif

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += \
    device/custom/sepolicy/common/public

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/custom/sepolicy/common/private

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/custom/sepolicy/common/dynamic \
    device/custom/sepolicy/common/system
else
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/custom/sepolicy/common/dynamic \
    device/custom/sepolicy/common/vendor
endif

# Selectively include legacy rules defined by the products
-include device/custom/sepolicy/legacy-common/sepolicy.mk

# Include atv rules on atv product
ifeq ($(PRODUCT_IS_ATV), true)
include device/custom/sepolicy/atv/sepolicy.mk
endif

# Pixel common
TARGET_INCLUDE_PIXEL_SEPOLICY ?= true
ifeq ($(TARGET_INCLUDE_PIXEL_SEPOLICY), true)
BOARD_SEPOLICY_DIRS += \
    device/custom/sepolicy/common/private/google

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/custom/sepolicy/common/system/google
else
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/custom/sepolicy/common/vendor/google
endif

# Flipendo
BOARD_SEPOLICY_DIRS += \
    hardware/google/pixel-sepolicy/flipendo

# google_battery service
BOARD_SEPOLICY_DIRS += \
    hardware/google/pixel-sepolicy/googlebattery

# turbo_adapter
BOARD_SEPOLICY_DIRS += \
    hardware/google/pixel-sepolicy/turbo_adapter
endif
