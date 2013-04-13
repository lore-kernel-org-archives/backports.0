Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44215 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab3DMXyK (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:54:10 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 04/42] backports: move header files
Date: Sun, 14 Apr 2013 01:53:24 +0200
Message-Id: <1365897243-31214-5-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015416_433268_479B5579)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This first step in reorganising the header files moves all the
header files into a new backport-include/ directory that gets
priority over the regular include/ where we copy the files we
want to backport from the kernel. This will help split all the
header files into logical units.

While at it, move and rename compat_2.6.h and compat_autoconf.h
to backport/backport.h and backport/autoconf.h respectively.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/.gitignore                                            |  2 +-
 backport/Makefile.kernel                                       |  3 ++-
 backport/Makefile.real                                         |  8 ++++----
 .../compat-2.6.h => backport-include/backport/backport.h}      | 10 +++++-----
 .../backport_checks.h => backport-include/backport/checks.h}   |  0
 backport/{include => backport-include}/crypto/aes.h            |  0
 backport/{include => backport-include}/linux/atomic.h          |  0
 backport/{include => backport-include}/linux/average.h         |  0
 backport/{include => backport-include}/linux/bitops.h          |  0
 backport/{include => backport-include}/linux/compat-2.6.14.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.18.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.19.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.20.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.21.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.22.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.23.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.24.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.25.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.26.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.27.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.28.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.29.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.30.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.31.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.32.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.33.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.34.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.35.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.36.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.37.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.38.h   |  0
 backport/{include => backport-include}/linux/compat-2.6.39.h   |  0
 backport/{include => backport-include}/linux/compat-3.0.h      |  0
 backport/{include => backport-include}/linux/compat-3.1.h      |  0
 backport/{include => backport-include}/linux/compat-3.10.h     |  0
 backport/{include => backport-include}/linux/compat-3.2.h      |  0
 backport/{include => backport-include}/linux/compat-3.3.h      |  0
 backport/{include => backport-include}/linux/compat-3.4.h      |  0
 backport/{include => backport-include}/linux/compat-3.5.h      |  0
 backport/{include => backport-include}/linux/compat-3.6.h      |  0
 backport/{include => backport-include}/linux/compat-3.7.h      |  0
 backport/{include => backport-include}/linux/compat-3.8.h      |  0
 backport/{include => backport-include}/linux/compat-3.9.h      |  0
 backport/{include => backport-include}/linux/cordic.h          |  0
 backport/{include => backport-include}/linux/crc8.h            |  0
 backport/{include => backport-include}/linux/export.h          |  0
 backport/{include => backport-include}/linux/gpio.h            |  0
 backport/{include => backport-include}/linux/kfifo.h           |  0
 backport/{include => backport-include}/linux/kmemleak.h        |  0
 backport/{include => backport-include}/linux/math64.h          |  0
 backport/{include => backport-include}/linux/of.h              |  0
 backport/{include => backport-include}/linux/olpc-ec.h         |  0
 backport/{include => backport-include}/linux/pci-aspm.h        |  0
 backport/{include => backport-include}/linux/pm_qos.h          |  0
 backport/{include => backport-include}/linux/pm_qos_params.h   |  0
 backport/{include => backport-include}/linux/pm_runtime.h      |  0
 backport/{include => backport-include}/linux/printk.h          |  0
 backport/{include => backport-include}/linux/rfkill.h          |  0
 backport/{include => backport-include}/linux/semaphore.h       |  0
 backport/{include => backport-include}/linux/tracepoint.h      |  0
 backport/{include => backport-include}/linux/u64_stats_sync.h  |  0
 backport/{include => backport-include}/linux/uidgid.h          |  0
 .../{include => backport-include}/linux/unaligned/access_ok.h  |  0
 .../linux/unaligned/be_byteshift.h                             |  0
 .../{include => backport-include}/linux/unaligned/be_memmove.h |  0
 .../{include => backport-include}/linux/unaligned/be_struct.h  |  0
 .../{include => backport-include}/linux/unaligned/generic.h    |  0
 .../linux/unaligned/le_byteshift.h                             |  0
 .../{include => backport-include}/linux/unaligned/le_memmove.h |  0
 .../{include => backport-include}/linux/unaligned/le_struct.h  |  0
 .../{include => backport-include}/linux/unaligned/memmove.h    |  0
 .../linux/unaligned/packed_struct.h                            |  0
 backport/{include => backport-include}/linux/vga_switcheroo.h  |  0
 backport/{include => backport-include}/linux/wireless.h        |  0
 backport/{include => backport-include}/net/codel.h             |  0
 backport/{include => backport-include}/net/flow_keys.h         |  0
 backport/{include => backport-include}/net/net_namespace.h     |  0
 backport/{include => backport-include}/pcmcia/cistpl.h         |  0
 backport/{include => backport-include}/trace/define_trace.h    |  0
 devel/doc/makefile-operation                                   |  2 +-
 gentree.py                                                     |  2 +-
 81 files changed, 14 insertions(+), 13 deletions(-)
 rename backport/{include/linux/compat-2.6.h => backport-include/backport/backport.h} (94%)
 rename backport/{include/linux/backport_checks.h => backport-include/backport/checks.h} (100%)
 rename backport/{include => backport-include}/crypto/aes.h (100%)
 rename backport/{include => backport-include}/linux/atomic.h (100%)
 rename backport/{include => backport-include}/linux/average.h (100%)
 rename backport/{include => backport-include}/linux/bitops.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.14.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.18.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.19.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.20.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.21.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.22.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.23.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.24.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.25.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.26.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.27.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.28.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.29.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.30.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.31.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.32.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.33.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.34.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.35.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.36.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.37.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.38.h (100%)
 rename backport/{include => backport-include}/linux/compat-2.6.39.h (100%)
 rename backport/{include => backport-include}/linux/compat-3.0.h (100%)
 rename backport/{include => backport-include}/linux/compat-3.1.h (100%)
 rename backport/{include => backport-include}/linux/compat-3.10.h (100%)
 rename backport/{include => backport-include}/linux/compat-3.2.h (100%)
 rename backport/{include => backport-include}/linux/compat-3.3.h (100%)
 rename backport/{include => backport-include}/linux/compat-3.4.h (100%)
 rename backport/{include => backport-include}/linux/compat-3.5.h (100%)
 rename backport/{include => backport-include}/linux/compat-3.6.h (100%)
 rename backport/{include => backport-include}/linux/compat-3.7.h (100%)
 rename backport/{include => backport-include}/linux/compat-3.8.h (100%)
 rename backport/{include => backport-include}/linux/compat-3.9.h (100%)
 rename backport/{include => backport-include}/linux/cordic.h (100%)
 rename backport/{include => backport-include}/linux/crc8.h (100%)
 rename backport/{include => backport-include}/linux/export.h (100%)
 rename backport/{include => backport-include}/linux/gpio.h (100%)
 rename backport/{include => backport-include}/linux/kfifo.h (100%)
 rename backport/{include => backport-include}/linux/kmemleak.h (100%)
 rename backport/{include => backport-include}/linux/math64.h (100%)
 rename backport/{include => backport-include}/linux/of.h (100%)
 rename backport/{include => backport-include}/linux/olpc-ec.h (100%)
 rename backport/{include => backport-include}/linux/pci-aspm.h (100%)
 rename backport/{include => backport-include}/linux/pm_qos.h (100%)
 rename backport/{include => backport-include}/linux/pm_qos_params.h (100%)
 rename backport/{include => backport-include}/linux/pm_runtime.h (100%)
 rename backport/{include => backport-include}/linux/printk.h (100%)
 rename backport/{include => backport-include}/linux/rfkill.h (100%)
 rename backport/{include => backport-include}/linux/semaphore.h (100%)
 rename backport/{include => backport-include}/linux/tracepoint.h (100%)
 rename backport/{include => backport-include}/linux/u64_stats_sync.h (100%)
 rename backport/{include => backport-include}/linux/uidgid.h (100%)
 rename backport/{include => backport-include}/linux/unaligned/access_ok.h (100%)
 rename backport/{include => backport-include}/linux/unaligned/be_byteshift.h (100%)
 rename backport/{include => backport-include}/linux/unaligned/be_memmove.h (100%)
 rename backport/{include => backport-include}/linux/unaligned/be_struct.h (100%)
 rename backport/{include => backport-include}/linux/unaligned/generic.h (100%)
 rename backport/{include => backport-include}/linux/unaligned/le_byteshift.h (100%)
 rename backport/{include => backport-include}/linux/unaligned/le_memmove.h (100%)
 rename backport/{include => backport-include}/linux/unaligned/le_struct.h (100%)
 rename backport/{include => backport-include}/linux/unaligned/memmove.h (100%)
 rename backport/{include => backport-include}/linux/unaligned/packed_struct.h (100%)
 rename backport/{include => backport-include}/linux/vga_switcheroo.h (100%)
 rename backport/{include => backport-include}/linux/wireless.h (100%)
 rename backport/{include => backport-include}/net/codel.h (100%)
 rename backport/{include => backport-include}/net/flow_keys.h (100%)
 rename backport/{include => backport-include}/net/net_namespace.h (100%)
 rename backport/{include => backport-include}/pcmcia/cistpl.h (100%)
 rename backport/{include => backport-include}/trace/define_trace.h (100%)

diff --git a/backport/.gitignore b/backport/.gitignore
index b3c3260..c906800 100644
--- a/backport/.gitignore
+++ b/backport/.gitignore
@@ -12,7 +12,7 @@ Kconfig.versions
 *.tmp
 *.ver
 modules.order
-include/linux/compat_autoconf.h
+backport-include/backport/autoconf.h
 modules
 kconfig/mconf
 kconfig/conf
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 096e80c..a58442a 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -4,10 +4,11 @@ backport-cc-disable-warning = $(call try-run,\
 	$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
 
 NOSTDINC_FLAGS := \
+	-I$(M)/backport-include/ \
 	-I$(M)/include/ \
 	-I$(M)/include/uapi \
 	-I$(M)/include/drm \
-	-include $(M)/include/linux/compat-2.6.h \
+	-include $(M)/backport-include/backport/backport.h \
 	$(call backport-cc-disable-warning, unused-but-set-variable) \
 	-DBACKPORTS_VERSION=\"$(BACKPORTS_VERSION)\" \
 	-DBACKPORTED_KERNEL_VERSION=\"$(BACKPORTED_KERNEL_VERSION)\" \
diff --git a/backport/Makefile.real b/backport/Makefile.real
index 0040ec7..81164da 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -52,9 +52,9 @@ defconfig-%::
 	echo "\--"							;\
 	false )
 
-include/linux/compat_autoconf.h: .config
+backport-include/backport/autoconf.h: .config
 	@$(MAKE) oldconfig
-	@echo -n "Building include/linux/compat_autoconf.h ..."
+	@echo -n "Building backport-include/backport/autoconf.h ..."
 	@grep -f .local-symbols .config | (				\
 		echo "#ifndef COMPAT_AUTOCONF_INCLUDED"			;\
 		echo "#define COMPAT_AUTOCONF_INCLUDED"			;\
@@ -75,11 +75,11 @@ include/linux/compat_autoconf.h: .config
 			esac						;\
 		done							;\
 		echo "#endif /* COMPAT_AUTOCONF_INCLUDED */"		;\
-	) > include/linux/compat_autoconf.h
+	) > backport-include/backport/autoconf.h
 	@echo " done."
 
 .PHONY: modules
-modules: include/linux/compat_autoconf.h
+modules: backport-include/backport/autoconf.h
 	@$(MAKE) -f Makefile.build modules
 
 .PHONY: install
diff --git a/backport/include/linux/compat-2.6.h b/backport/backport-include/backport/backport.h
similarity index 94%
rename from backport/include/linux/compat-2.6.h
rename to backport/backport-include/backport/backport.h
index f9e0e74..6bbf4a7 100644
--- a/backport/include/linux/compat-2.6.h
+++ b/backport/backport-include/backport/backport.h
@@ -1,10 +1,10 @@
-#ifndef LINUX_26_COMPAT_H
-#define LINUX_26_COMPAT_H
+#ifndef LINUX_BACKPORT_H
+#define LINUX_BACKPORT_H
 
 #ifndef __ASSEMBLY__
 
 #define LINUX_BACKPORT(__sym) backport_ ##__sym
-#include <linux/backport_checks.h>
+#include <backport/checks.h>
 
 #include <linux/version.h>
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
@@ -14,7 +14,7 @@
 #else
 #include <linux/autoconf.h>
 #endif
-#include <linux/compat_autoconf.h>
+#include <backport/autoconf.h>
 #include <linux/init.h>
 #include <linux/uidgid.h>
 #include <linux/module.h>
@@ -88,4 +88,4 @@ void backport_dependency_symbol(void);
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* LINUX_26_COMPAT_H */
+#endif /* LINUX_BACKPORT_H */
diff --git a/backport/include/linux/backport_checks.h b/backport/backport-include/backport/checks.h
similarity index 100%
rename from backport/include/linux/backport_checks.h
rename to backport/backport-include/backport/checks.h
diff --git a/backport/include/crypto/aes.h b/backport/backport-include/crypto/aes.h
similarity index 100%
rename from backport/include/crypto/aes.h
rename to backport/backport-include/crypto/aes.h
diff --git a/backport/include/linux/atomic.h b/backport/backport-include/linux/atomic.h
similarity index 100%
rename from backport/include/linux/atomic.h
rename to backport/backport-include/linux/atomic.h
diff --git a/backport/include/linux/average.h b/backport/backport-include/linux/average.h
similarity index 100%
rename from backport/include/linux/average.h
rename to backport/backport-include/linux/average.h
diff --git a/backport/include/linux/bitops.h b/backport/backport-include/linux/bitops.h
similarity index 100%
rename from backport/include/linux/bitops.h
rename to backport/backport-include/linux/bitops.h
diff --git a/backport/include/linux/compat-2.6.14.h b/backport/backport-include/linux/compat-2.6.14.h
similarity index 100%
rename from backport/include/linux/compat-2.6.14.h
rename to backport/backport-include/linux/compat-2.6.14.h
diff --git a/backport/include/linux/compat-2.6.18.h b/backport/backport-include/linux/compat-2.6.18.h
similarity index 100%
rename from backport/include/linux/compat-2.6.18.h
rename to backport/backport-include/linux/compat-2.6.18.h
diff --git a/backport/include/linux/compat-2.6.19.h b/backport/backport-include/linux/compat-2.6.19.h
similarity index 100%
rename from backport/include/linux/compat-2.6.19.h
rename to backport/backport-include/linux/compat-2.6.19.h
diff --git a/backport/include/linux/compat-2.6.20.h b/backport/backport-include/linux/compat-2.6.20.h
similarity index 100%
rename from backport/include/linux/compat-2.6.20.h
rename to backport/backport-include/linux/compat-2.6.20.h
diff --git a/backport/include/linux/compat-2.6.21.h b/backport/backport-include/linux/compat-2.6.21.h
similarity index 100%
rename from backport/include/linux/compat-2.6.21.h
rename to backport/backport-include/linux/compat-2.6.21.h
diff --git a/backport/include/linux/compat-2.6.22.h b/backport/backport-include/linux/compat-2.6.22.h
similarity index 100%
rename from backport/include/linux/compat-2.6.22.h
rename to backport/backport-include/linux/compat-2.6.22.h
diff --git a/backport/include/linux/compat-2.6.23.h b/backport/backport-include/linux/compat-2.6.23.h
similarity index 100%
rename from backport/include/linux/compat-2.6.23.h
rename to backport/backport-include/linux/compat-2.6.23.h
diff --git a/backport/include/linux/compat-2.6.24.h b/backport/backport-include/linux/compat-2.6.24.h
similarity index 100%
rename from backport/include/linux/compat-2.6.24.h
rename to backport/backport-include/linux/compat-2.6.24.h
diff --git a/backport/include/linux/compat-2.6.25.h b/backport/backport-include/linux/compat-2.6.25.h
similarity index 100%
rename from backport/include/linux/compat-2.6.25.h
rename to backport/backport-include/linux/compat-2.6.25.h
diff --git a/backport/include/linux/compat-2.6.26.h b/backport/backport-include/linux/compat-2.6.26.h
similarity index 100%
rename from backport/include/linux/compat-2.6.26.h
rename to backport/backport-include/linux/compat-2.6.26.h
diff --git a/backport/include/linux/compat-2.6.27.h b/backport/backport-include/linux/compat-2.6.27.h
similarity index 100%
rename from backport/include/linux/compat-2.6.27.h
rename to backport/backport-include/linux/compat-2.6.27.h
diff --git a/backport/include/linux/compat-2.6.28.h b/backport/backport-include/linux/compat-2.6.28.h
similarity index 100%
rename from backport/include/linux/compat-2.6.28.h
rename to backport/backport-include/linux/compat-2.6.28.h
diff --git a/backport/include/linux/compat-2.6.29.h b/backport/backport-include/linux/compat-2.6.29.h
similarity index 100%
rename from backport/include/linux/compat-2.6.29.h
rename to backport/backport-include/linux/compat-2.6.29.h
diff --git a/backport/include/linux/compat-2.6.30.h b/backport/backport-include/linux/compat-2.6.30.h
similarity index 100%
rename from backport/include/linux/compat-2.6.30.h
rename to backport/backport-include/linux/compat-2.6.30.h
diff --git a/backport/include/linux/compat-2.6.31.h b/backport/backport-include/linux/compat-2.6.31.h
similarity index 100%
rename from backport/include/linux/compat-2.6.31.h
rename to backport/backport-include/linux/compat-2.6.31.h
diff --git a/backport/include/linux/compat-2.6.32.h b/backport/backport-include/linux/compat-2.6.32.h
similarity index 100%
rename from backport/include/linux/compat-2.6.32.h
rename to backport/backport-include/linux/compat-2.6.32.h
diff --git a/backport/include/linux/compat-2.6.33.h b/backport/backport-include/linux/compat-2.6.33.h
similarity index 100%
rename from backport/include/linux/compat-2.6.33.h
rename to backport/backport-include/linux/compat-2.6.33.h
diff --git a/backport/include/linux/compat-2.6.34.h b/backport/backport-include/linux/compat-2.6.34.h
similarity index 100%
rename from backport/include/linux/compat-2.6.34.h
rename to backport/backport-include/linux/compat-2.6.34.h
diff --git a/backport/include/linux/compat-2.6.35.h b/backport/backport-include/linux/compat-2.6.35.h
similarity index 100%
rename from backport/include/linux/compat-2.6.35.h
rename to backport/backport-include/linux/compat-2.6.35.h
diff --git a/backport/include/linux/compat-2.6.36.h b/backport/backport-include/linux/compat-2.6.36.h
similarity index 100%
rename from backport/include/linux/compat-2.6.36.h
rename to backport/backport-include/linux/compat-2.6.36.h
diff --git a/backport/include/linux/compat-2.6.37.h b/backport/backport-include/linux/compat-2.6.37.h
similarity index 100%
rename from backport/include/linux/compat-2.6.37.h
rename to backport/backport-include/linux/compat-2.6.37.h
diff --git a/backport/include/linux/compat-2.6.38.h b/backport/backport-include/linux/compat-2.6.38.h
similarity index 100%
rename from backport/include/linux/compat-2.6.38.h
rename to backport/backport-include/linux/compat-2.6.38.h
diff --git a/backport/include/linux/compat-2.6.39.h b/backport/backport-include/linux/compat-2.6.39.h
similarity index 100%
rename from backport/include/linux/compat-2.6.39.h
rename to backport/backport-include/linux/compat-2.6.39.h
diff --git a/backport/include/linux/compat-3.0.h b/backport/backport-include/linux/compat-3.0.h
similarity index 100%
rename from backport/include/linux/compat-3.0.h
rename to backport/backport-include/linux/compat-3.0.h
diff --git a/backport/include/linux/compat-3.1.h b/backport/backport-include/linux/compat-3.1.h
similarity index 100%
rename from backport/include/linux/compat-3.1.h
rename to backport/backport-include/linux/compat-3.1.h
diff --git a/backport/include/linux/compat-3.10.h b/backport/backport-include/linux/compat-3.10.h
similarity index 100%
rename from backport/include/linux/compat-3.10.h
rename to backport/backport-include/linux/compat-3.10.h
diff --git a/backport/include/linux/compat-3.2.h b/backport/backport-include/linux/compat-3.2.h
similarity index 100%
rename from backport/include/linux/compat-3.2.h
rename to backport/backport-include/linux/compat-3.2.h
diff --git a/backport/include/linux/compat-3.3.h b/backport/backport-include/linux/compat-3.3.h
similarity index 100%
rename from backport/include/linux/compat-3.3.h
rename to backport/backport-include/linux/compat-3.3.h
diff --git a/backport/include/linux/compat-3.4.h b/backport/backport-include/linux/compat-3.4.h
similarity index 100%
rename from backport/include/linux/compat-3.4.h
rename to backport/backport-include/linux/compat-3.4.h
diff --git a/backport/include/linux/compat-3.5.h b/backport/backport-include/linux/compat-3.5.h
similarity index 100%
rename from backport/include/linux/compat-3.5.h
rename to backport/backport-include/linux/compat-3.5.h
diff --git a/backport/include/linux/compat-3.6.h b/backport/backport-include/linux/compat-3.6.h
similarity index 100%
rename from backport/include/linux/compat-3.6.h
rename to backport/backport-include/linux/compat-3.6.h
diff --git a/backport/include/linux/compat-3.7.h b/backport/backport-include/linux/compat-3.7.h
similarity index 100%
rename from backport/include/linux/compat-3.7.h
rename to backport/backport-include/linux/compat-3.7.h
diff --git a/backport/include/linux/compat-3.8.h b/backport/backport-include/linux/compat-3.8.h
similarity index 100%
rename from backport/include/linux/compat-3.8.h
rename to backport/backport-include/linux/compat-3.8.h
diff --git a/backport/include/linux/compat-3.9.h b/backport/backport-include/linux/compat-3.9.h
similarity index 100%
rename from backport/include/linux/compat-3.9.h
rename to backport/backport-include/linux/compat-3.9.h
diff --git a/backport/include/linux/cordic.h b/backport/backport-include/linux/cordic.h
similarity index 100%
rename from backport/include/linux/cordic.h
rename to backport/backport-include/linux/cordic.h
diff --git a/backport/include/linux/crc8.h b/backport/backport-include/linux/crc8.h
similarity index 100%
rename from backport/include/linux/crc8.h
rename to backport/backport-include/linux/crc8.h
diff --git a/backport/include/linux/export.h b/backport/backport-include/linux/export.h
similarity index 100%
rename from backport/include/linux/export.h
rename to backport/backport-include/linux/export.h
diff --git a/backport/include/linux/gpio.h b/backport/backport-include/linux/gpio.h
similarity index 100%
rename from backport/include/linux/gpio.h
rename to backport/backport-include/linux/gpio.h
diff --git a/backport/include/linux/kfifo.h b/backport/backport-include/linux/kfifo.h
similarity index 100%
rename from backport/include/linux/kfifo.h
rename to backport/backport-include/linux/kfifo.h
diff --git a/backport/include/linux/kmemleak.h b/backport/backport-include/linux/kmemleak.h
similarity index 100%
rename from backport/include/linux/kmemleak.h
rename to backport/backport-include/linux/kmemleak.h
diff --git a/backport/include/linux/math64.h b/backport/backport-include/linux/math64.h
similarity index 100%
rename from backport/include/linux/math64.h
rename to backport/backport-include/linux/math64.h
diff --git a/backport/include/linux/of.h b/backport/backport-include/linux/of.h
similarity index 100%
rename from backport/include/linux/of.h
rename to backport/backport-include/linux/of.h
diff --git a/backport/include/linux/olpc-ec.h b/backport/backport-include/linux/olpc-ec.h
similarity index 100%
rename from backport/include/linux/olpc-ec.h
rename to backport/backport-include/linux/olpc-ec.h
diff --git a/backport/include/linux/pci-aspm.h b/backport/backport-include/linux/pci-aspm.h
similarity index 100%
rename from backport/include/linux/pci-aspm.h
rename to backport/backport-include/linux/pci-aspm.h
diff --git a/backport/include/linux/pm_qos.h b/backport/backport-include/linux/pm_qos.h
similarity index 100%
rename from backport/include/linux/pm_qos.h
rename to backport/backport-include/linux/pm_qos.h
diff --git a/backport/include/linux/pm_qos_params.h b/backport/backport-include/linux/pm_qos_params.h
similarity index 100%
rename from backport/include/linux/pm_qos_params.h
rename to backport/backport-include/linux/pm_qos_params.h
diff --git a/backport/include/linux/pm_runtime.h b/backport/backport-include/linux/pm_runtime.h
similarity index 100%
rename from backport/include/linux/pm_runtime.h
rename to backport/backport-include/linux/pm_runtime.h
diff --git a/backport/include/linux/printk.h b/backport/backport-include/linux/printk.h
similarity index 100%
rename from backport/include/linux/printk.h
rename to backport/backport-include/linux/printk.h
diff --git a/backport/include/linux/rfkill.h b/backport/backport-include/linux/rfkill.h
similarity index 100%
rename from backport/include/linux/rfkill.h
rename to backport/backport-include/linux/rfkill.h
diff --git a/backport/include/linux/semaphore.h b/backport/backport-include/linux/semaphore.h
similarity index 100%
rename from backport/include/linux/semaphore.h
rename to backport/backport-include/linux/semaphore.h
diff --git a/backport/include/linux/tracepoint.h b/backport/backport-include/linux/tracepoint.h
similarity index 100%
rename from backport/include/linux/tracepoint.h
rename to backport/backport-include/linux/tracepoint.h
diff --git a/backport/include/linux/u64_stats_sync.h b/backport/backport-include/linux/u64_stats_sync.h
similarity index 100%
rename from backport/include/linux/u64_stats_sync.h
rename to backport/backport-include/linux/u64_stats_sync.h
diff --git a/backport/include/linux/uidgid.h b/backport/backport-include/linux/uidgid.h
similarity index 100%
rename from backport/include/linux/uidgid.h
rename to backport/backport-include/linux/uidgid.h
diff --git a/backport/include/linux/unaligned/access_ok.h b/backport/backport-include/linux/unaligned/access_ok.h
similarity index 100%
rename from backport/include/linux/unaligned/access_ok.h
rename to backport/backport-include/linux/unaligned/access_ok.h
diff --git a/backport/include/linux/unaligned/be_byteshift.h b/backport/backport-include/linux/unaligned/be_byteshift.h
similarity index 100%
rename from backport/include/linux/unaligned/be_byteshift.h
rename to backport/backport-include/linux/unaligned/be_byteshift.h
diff --git a/backport/include/linux/unaligned/be_memmove.h b/backport/backport-include/linux/unaligned/be_memmove.h
similarity index 100%
rename from backport/include/linux/unaligned/be_memmove.h
rename to backport/backport-include/linux/unaligned/be_memmove.h
diff --git a/backport/include/linux/unaligned/be_struct.h b/backport/backport-include/linux/unaligned/be_struct.h
similarity index 100%
rename from backport/include/linux/unaligned/be_struct.h
rename to backport/backport-include/linux/unaligned/be_struct.h
diff --git a/backport/include/linux/unaligned/generic.h b/backport/backport-include/linux/unaligned/generic.h
similarity index 100%
rename from backport/include/linux/unaligned/generic.h
rename to backport/backport-include/linux/unaligned/generic.h
diff --git a/backport/include/linux/unaligned/le_byteshift.h b/backport/backport-include/linux/unaligned/le_byteshift.h
similarity index 100%
rename from backport/include/linux/unaligned/le_byteshift.h
rename to backport/backport-include/linux/unaligned/le_byteshift.h
diff --git a/backport/include/linux/unaligned/le_memmove.h b/backport/backport-include/linux/unaligned/le_memmove.h
similarity index 100%
rename from backport/include/linux/unaligned/le_memmove.h
rename to backport/backport-include/linux/unaligned/le_memmove.h
diff --git a/backport/include/linux/unaligned/le_struct.h b/backport/backport-include/linux/unaligned/le_struct.h
similarity index 100%
rename from backport/include/linux/unaligned/le_struct.h
rename to backport/backport-include/linux/unaligned/le_struct.h
diff --git a/backport/include/linux/unaligned/memmove.h b/backport/backport-include/linux/unaligned/memmove.h
similarity index 100%
rename from backport/include/linux/unaligned/memmove.h
rename to backport/backport-include/linux/unaligned/memmove.h
diff --git a/backport/include/linux/unaligned/packed_struct.h b/backport/backport-include/linux/unaligned/packed_struct.h
similarity index 100%
rename from backport/include/linux/unaligned/packed_struct.h
rename to backport/backport-include/linux/unaligned/packed_struct.h
diff --git a/backport/include/linux/vga_switcheroo.h b/backport/backport-include/linux/vga_switcheroo.h
similarity index 100%
rename from backport/include/linux/vga_switcheroo.h
rename to backport/backport-include/linux/vga_switcheroo.h
diff --git a/backport/include/linux/wireless.h b/backport/backport-include/linux/wireless.h
similarity index 100%
rename from backport/include/linux/wireless.h
rename to backport/backport-include/linux/wireless.h
diff --git a/backport/include/net/codel.h b/backport/backport-include/net/codel.h
similarity index 100%
rename from backport/include/net/codel.h
rename to backport/backport-include/net/codel.h
diff --git a/backport/include/net/flow_keys.h b/backport/backport-include/net/flow_keys.h
similarity index 100%
rename from backport/include/net/flow_keys.h
rename to backport/backport-include/net/flow_keys.h
diff --git a/backport/include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
similarity index 100%
rename from backport/include/net/net_namespace.h
rename to backport/backport-include/net/net_namespace.h
diff --git a/backport/include/pcmcia/cistpl.h b/backport/backport-include/pcmcia/cistpl.h
similarity index 100%
rename from backport/include/pcmcia/cistpl.h
rename to backport/backport-include/pcmcia/cistpl.h
diff --git a/backport/include/trace/define_trace.h b/backport/backport-include/trace/define_trace.h
similarity index 100%
rename from backport/include/trace/define_trace.h
rename to backport/backport-include/trace/define_trace.h
diff --git a/devel/doc/makefile-operation b/devel/doc/makefile-operation
index 6a96ded..38cf4e7 100644
--- a/devel/doc/makefile-operation
+++ b/devel/doc/makefile-operation
@@ -23,7 +23,7 @@ Once these are in place, the configuration process can start with any of
 the tools -- menuconfig, defconfig-*, ...
 
 When the configuration is complete and exists in .config, the autoconf
-header (include/linux/compat_autoconf.h) must be generated. This step is
+header (backport-include/backport/autoconf.h) must be generated. This step is
 also done in the make system (by a small embedded shell script) and needs
 the .local-symbols so it only includes the symbols from the backport.
 
diff --git a/gentree.py b/gentree.py
index 204fffd..3ba73ea 100755
--- a/gentree.py
+++ b/gentree.py
@@ -323,7 +323,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
     # do the copy
     backport_files = [(x, x) for x in [
         'Kconfig', 'Makefile', 'Makefile.build', 'Makefile.kernel', '.gitignore',
-        'Makefile.real', 'compat/', 'include/', 'kconfig/', 'defconfigs/',
+        'Makefile.real', 'compat/', 'backport-include/', 'kconfig/', 'defconfigs/',
         'scripts/', '.blacklist.map', 'udev/',
     ]]
     if not args.git_revision:
-- 
1.8.0

