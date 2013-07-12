Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44414 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209Ab3GLAwb (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Jul 2013 20:52:31 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so8370881pad.30
        for <backports@vger.kernel.org>; Thu, 11 Jul 2013 17:52:31 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] backports: add make help and defconfig-help targets
Date: Thu, 11 Jul 2013 17:52:25 -0700
Message-Id: <1373590345-13880-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130712_025233_597001_B4C2AB3D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Throw users a bone by helping them compile specific target
drivers. Hauke did some good work in providing tons of
defconfigs, provide a command to let users query these
easily with 'make defconfig-help'. Also provide a more
generic 'make help' target.

Screenshot of make defconfig-help:

mcgrof@frijol ~/backports-20130618 $ make defconfig-help
Driver or subsystem configuration targets:
  defconfig-alx
  defconfig-ar5523
  defconfig-ath5k
  defconfig-ath6kl
  defconfig-ath9k
  defconfig-ath10k
  defconfig-b43
  defconfig-b43legacy
  defconfig-brcmfmac
  defconfig-brcmsmac
  defconfig-carl9170
  defconfig-drm
  defconfig-ieee802154
  defconfig-iwlwifi
  defconfig-media
  defconfig-nfc
  defconfig-regulator
  defconfig-rtlwifi
  defconfig-wifi
  defconfig-wil6210

Running 'make help' will provide the above and in addition to that
something similar to what the Linux kernel provides with the
list of supported targets backports provides.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/Makefile |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/backport/Makefile b/backport/Makefile
index 421a4f6..ca69f41 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -112,6 +112,53 @@ mrproper:
 	echo "$(CONFIG_MD5)" > .kernel_config_md5
 	@$(MAKE) -f Makefile.real "$@"
 
+.PHONY: defconfig-help
+defconfig-help:
+	@echo "Driver or subsystem configuration targets:"
+	@set -e						;\
+		bk_configs="$$(ls defconfigs/*)" 	;\
+		for cfg in $$bk_configs; do		\
+			echo "  defconfig-$${cfg##defconfigs/}"	;\
+		done
+	@echo ""
+
+.PHONY: help
+help: defconfig-help
+	@echo "Cleaning targets:"
+	@echo "  clean           - Remove most generated files but keep the config and"
+	@echo "                    enough build support to build external modules"
+	@echo "  mrproper        - Remove all generated files + config + various backup files"
+	@echo ""
+	@echo "Driver configuration help:"
+	@echo "  defconfig-help  - List all prearranged defconfig-targets we have"
+	@echo "                    designed for you. You can use this to find"
+	@echo "                    driver specific configs in case all you really"
+	@echo "                    need is to just compile one or a small group "
+	@echo "                    of drivers."
+	@echo ""
+	@echo "Configuration targets:"
+	@echo "  menuconfig      - Update current config utilising a menu based program"
+	@echo "  allyesconfig    - New config where all options are accepted with yes"
+	@echo "  oldconfig       - Update current config utilising a provided .config as base"
+	@echo "  oldaskconfig    - ??"
+	@echo "  silentoldconfig - Same as oldconfig, but quietly, additionally update deps"
+	@echo "  allnoconfig     - New config where all options are answered with no"
+	@echo "  allyesconfig    - New config where all options are accepted with yes"
+	@echo "  allmodconfig    - New config selecting modules when possible"
+	@echo "  alldefconfig    - New config with all symbols set to default"
+	@echo "  randconfig      - New config with random answer to all options"
+	@echo "  listnewconfig   - List new options"
+	@echo "  olddefconfig    - Same as silentoldconfig but sets new symbols to their default value"
+	@echo ""
+	@echo "Other generic targets:"
+	@echo "  all             - Build all targets marked with [*]"
+	@echo "* modules         - Build all modules"
+	@echo ""
+	@echo "Architecture specific targets:"
+	@echo "  install         - Install modules"
+	@echo "  uninstall       - Uninstall modules"
+	@echo ""
+	@echo "Execute "make" or "make all" to build all targets marked with [*]"
 else
 include $(BACKPORT_PWD)/Makefile.kernel
 endif
-- 
1.7.10.4

