################################################################################
#
# libiopcmsgbus
#
################################################################################

LIBIOPCMSGBUS_VERSION       = 89375eeba2eb71542fc3eac4125f06cc696db8cf
LIBIOPCMSGBUS_SITE          = $(call github,YuanYuLin,libiopcmsgbus,$(LIBIOPCMSGBUS_VERSION))
LIBIOPCMSGBUS_LICENSE       = GPLv2+
LIBIOPCMSGBUS_LICENSE_FILES = COPYING

LIBIOPCMSGBUS_DEPENDENCIES  = host-pkgconf 

LIBIOPCMSGBUS_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \
	$(shell $(PKG_CONFIG_HOST_BINARY) --cflags bcm_host)    \
	$(shell $(PKG_CONFIG_HOST_BINARY) --cflags freetype2)   \


LIBIOPCMSGBUS_MAKE_ENV =                        \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(TARGET_DIR)              \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(LIBIOPCMSGBUS_EXTRA_CFLAGS)"

define LIBIOPCMSGBUS_BUILD_CMDS
	$(LIBIOPCMSGBUS_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBIOPCMSGBUS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/libiopcmsgbus.so $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
