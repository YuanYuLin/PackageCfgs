################################################################################
#
# libiopccfg
#
################################################################################

LIBIOPCCFG_VERSION       = b45d4e3c525269a612b7b3ea11b176a21ff4c723
LIBIOPCCFG_SITE          = $(call github,YuanYuLin,libiopccfg,$(LIBIOPCCFG_VERSION))
LIBIOPCCFG_LICENSE       = GPLv2+
LIBIOPCCFG_LICENSE_FILES = COPYING
LIBIOPCCFG_INSTALL_STAGING = YES

LIBIOPCCFG_DEPENDENCIES  = host-pkgconf json-c

LIBIOPCCFG_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


LIBIOPCCFG_MAKE_ENV =                        \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(TARGET_DIR)              \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(LIBIOPCCFG_EXTRA_CFLAGS)"

define LIBIOPCCFG_BUILD_CMDS
	$(LIBIOPCCFG_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBIOPCCFG_INSTALL_STAGING_CMDS
	$(INSTALL) -m 0755 -D $(@D)/libiopccfg.so* $(STAGING_DIR)/usr/lib/
	@mkdir -p $(STAGING_DIR)/usr/include/iopccfg
	$(INSTALL) -m 0644 -D $(@D)/*.h $(STAGING_DIR)/usr/include/iopccfg
endef

define LIBIOPCCFG_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/libiopccfg.so $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
