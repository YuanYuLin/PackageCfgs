################################################################################
#
# iopcmsgbus
#
################################################################################

IOPCMSGBUS_VERSION       = 8cba44a967d22795b3214532e3eb651f9b03ff23
IOPCMSGBUS_SITE          = $(call github,YuanYuLin,iopcmsgbus,$(IOPCMSGBUS_VERSION))
IOPCMSGBUS_LICENSE       = GPLv2+
IOPCMSGBUS_LICENSE_FILES = COPYING

IOPCMSGBUS_DEPENDENCIES  = host-pkgconf libiopcmsgbus

IOPCMSGBUS_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \
	$(shell $(PKG_CONFIG_HOST_BINARY) --cflags bcm_host)    \
	$(shell $(PKG_CONFIG_HOST_BINARY) --cflags freetype2)   \


IOPCMSGBUS_MAKE_ENV =                        \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(TARGET_DIR)              \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(IOPCMSGBUS_EXTRA_CFLAGS)"

define IOPCMSGBUS_BUILD_CMDS
	$(IOPCMSGBUS_MAKE_ENV) $(MAKE) -C $(@D)
endef

define IOPCMSGBUS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/iopcmsgbus.elf $(TARGET_DIR)/usr/bin/iopcmsgbus
endef

$(eval $(generic-package))
