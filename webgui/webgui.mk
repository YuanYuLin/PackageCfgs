################################################################################
#
# webgui
#
################################################################################

WEBGUI_VERSION       = b310650de540855ab8f4b239fa34dad21a0c31ff
WEBGUI_SITE          = $(call github,popcornmix,omxplayer,$(WEBGUI_VERSION))
WEBGUI_LICENSE       = GPLv2+
WEBGUI_LICENSE_FILES = COPYING

WEBGUI_DEPENDENCIES  = lighttpd


$(INSTALL) -m 0755 -D $(@D)/ $(TARGET_DIR)/var/www

$(eval $(generic-package))
