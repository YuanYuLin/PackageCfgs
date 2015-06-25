################################################################################
#
# iopccfg
#
################################################################################

IOPCCFG_VERSION       = f04b5c9636aeedc7cab7a3fd7da4ce6d8baddb71
IOPCCFG_SITE          = $(call github,YuanYuLin,iopccfg,$(IOPCCFG_VERSION))
IOPCCFG_LICENSE       = GPLv2+
IOPCCFG_LICENSE_FILES = COPYING

IOPCCFG_DEPENDENCIES  = host-pkgconf libiopccfg

IOPCCFG_EXTRA_CFLAGS =                                        \
	-DTARGET_LINUX -DTARGET_POSIX                           \


IOPCCFG_MAKE_ENV =                        \
	BUILDROOT=$(TOP_DIR)                \
	SDKSTAGE=$(STAGING_DIR)             \
	TARGETFS=$(TARGET_DIR)              \
	TOOLCHAIN=$(HOST_DIR)/usr           \
	HOST=$(GNU_TARGET_NAME)             \
	SYSROOT=$(STAGING_DIR)              \
	JOBS=$(PARALLEL_JOBS)               \
	$(TARGET_CONFIGURE_OPTS)            \
	CFLAGS="$(TARGET_CFLAGS) $(IOPCCFG_EXTRA_CFLAGS)"

define IOPCCFG_BUILD_CMDS
	$(IOPCCFG_MAKE_ENV) $(MAKE) -C $(@D)
endef

define IOPCCFG_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/iopccfg.elf $(TARGET_DIR)/usr/bin/iopccfg
endef

$(eval $(generic-package))
