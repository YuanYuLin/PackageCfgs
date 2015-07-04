################################################################################
#
# libiopccfg_host
#
################################################################################

LIBIOPCCFG_HOST_VERSION       = caf8600b7455a0c10a68397e4925333a1d91c735
LIBIOPCCFG_HOST_SITE          = $(call github,YuanYuLin,libiopccfg_host,$(LIBIOPCCFG_HOST_VERSION))
LIBIOPCCFG_HOST_LICENSE       = GPLv2+
LIBIOPCCFG_HOST_LICENSE_FILES = COPYING

LIBIOPCCFG_HOST_DEPENDENCIES  = iopccfg


define LIBIOPCCFG_HOST_INSTALL_TARGET_CMDS
	echo "Adam Test"
	mkdir -p $(TARGET_DIR)/opt/iopc/defconfig/
	mkdir -p $(TARGET_DIR)/opt/iopc/scripts/
	$(INSTALL) -m 0755 -D $(@D)/def_cfgs/*	$(TARGET_DIR)/opt/iopc/defconfig/
	$(INSTALL) -m 0755 -D $(@D)/scripts/*	$(TARGET_DIR)/opt/iopc/scripts/
endef

$(eval $(generic-package))
