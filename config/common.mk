PRODUCT_BRAND ?= LineageOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Tethys.ogg \
    ro.config.alarm_alert=Oxygen.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif


ifneq ($(filter yukon rhine shinano kanuti kitakami loire tone,$(PRODUCT_PLATFORM)),)
# Disable ADB authentication on Sony Targets
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=0
else

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

ifneq ($(TARGET_BUILD_VARIANT),userdebug)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/cm/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/cm/prebuilt/common/bin/50-cm.sh:system/addon.d/50-cm.sh \
    vendor/cm/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/cm/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/cm/prebuilt/common/bin/sysinit:system/bin/sysinit

# AOSGP Tweaks support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.d/00ARCHIDROID_INITD:system/etc/init.d/00ARCHIDROID_INITD \
    vendor/cm/prebuilt/common/etc/init.d/AS00better_scrolling:system/etc/init.d/LS00better_scrolling \
    vendor/cm/prebuilt/common/etc/init.d/AS00CPU:system/etc/init.d/LS00CPU \
    vendor/cm/prebuilt/common/etc/init.d/AS00CPU_optimizer:system/etc/init.d/LS00CPU_optimizer \
    vendor/cm/prebuilt/common/etc/init.d/AS00GP_services_drainfix:system/etc/init.d/LS00GP_services_drainfix \
    vendor/cm/prebuilt/common/etc/init.d/AS00improve_battery:system/etc/init.d/LS00improve_battery \
    vendor/cm/prebuilt/common/etc/init.d/AS00Kernel_tweaks:system/etc/init.d/LS00Kernel_tweaks \
    vendor/cm/prebuilt/common/etc/init.d/AS00Kill_google_apps:system/etc/init.d/LS00Kill_google_apps \
    vendor/cm/prebuilt/common/etc/init.d/AS00Ram_manager_BL:system/etc/init.d/LS00Ram_manager_BL \
    vendor/cm/prebuilt/common/etc/init.d/AS00VM_tweaks:system/etc/init.d/LS00VM_tweaks \
    vendor/cm/prebuilt/common/etc/init.d/AX00DEFAULT:system/etc/init.d/X00DEFAULT \
    vendor/cm/prebuilt/common/etc/init.d/AX00MPS2:system/etc/init.d/X00MPS2 \
    vendor/cm/prebuilt/common/etc/init.d/AX00ZIP:system/etc/init.d/X00ZIP \
    vendor/cm/prebuilt/common/etc/init.d/98fly_engine:system/etc/init.d/98fly_engine \
    vendor/cm/prebuilt/common/etc/init.d/S98system_tweak:system/etc/init.d/S98system_tweak \
    vendor/cm/prebuilt/common/priv-app/Substratum/substratum.apk:system/priv-app/Substratum/substratum.apk \
    vendor/cm/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# CM-specific init file
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.local.rc:root/init.cm.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is CM!
PRODUCT_COPY_FILES += \
    vendor/cm/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# Include CM audio files
include vendor/cm/config/cm_audio.mk

# Theme engine
include vendor/cm/config/themes_common.mk

ifneq ($(TARGET_DISABLE_CMSDK), true)
# CMSDK
include vendor/cm/config/cmsdk_common.mk
endif

# Required CM packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    CMAudioService \
    CMParts \
    Development \
    Profiles \
    WeatherManagerService

# Optional CM packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \
    PhotoTable \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom CM packages
PRODUCT_PACKAGES += \
    AudioFX \
    CMSettingsProvider \
    CustomTiles \
    Eleven \
    ExactCalculator \
    LiveLockScreenService \
    LockClock \
    Trebuchet \
    WallpaperPicker \
    WeatherProvider \
    Snap \
    PixelLauncher \
    AOSGPWalls \
    ResurrectionOTA \
    CMFileManager \
    Jelly \
    #AOSGPSetupWizard 

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in CM
PRODUCT_PACKAGES += \
    7z \
    bash \
    bzip2 \
    curl \
    fsck.ntfs \
    gdbserver \
    htop \
    lib7z \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    oprofiled \
    pigz \
    powertop \
    sqlite3 \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank

# Conditionally build in su
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

DEVICE_PACKAGE_OVERLAYS += vendor/cm/overlay/common

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Custom crDroid packages
PRODUCT_PACKAGES += \
    OmniJaws \
    ThemeInterfacer \
    libprotobuf-cpp-full

PRODUCT_PROPERTY_OVERRIDES := \
    ro.substratum.verified=true

# Enable Google Assistant
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opa.eligible_device=true /
    ro.com.google.ime.theme_id=5

#DU Utils Library
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils
 
PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

# Proprietary latinime lib needed for swyping
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# Enable storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=1

# Product version should match Android version
PRODUCT_VERSION_MAJOR = 7
PRODUCT_VERSION_MINOR = 1.2

# AOSGP version
AOSGP_VERSION := X-2.2

LINEAGE_VERSION := aosgp-$(AOSGP_VERSION)-$(shell date -u +%Y%m%d)-$(CM_BUILD)
AOSGP_DISPLAY_VERSION := aosgp-$(AOSGP_VERSION)-$(shell date -u +%Y%m%d)-$(CM_BUILD)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.crdroid.version=$(AOSGP_DISPLAY_VERSION) \
  ro.modversion=$(AOSGP_DISPLAY_VERSION)

PRODUCT_EXTRA_RECOVERY_KEYS += \
  vendor/cm/build/target/product/security/lineage

PRODUCT_PROPERTY_OVERRIDES += \
  ro.crdroid.display.version=$(AOSGP_DISPLAY_VERSION)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/cm/config/partner_gms.mk
-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)

# include definitions for SDCLANG
  include vendor/cm/sdclang/sdclang.mk