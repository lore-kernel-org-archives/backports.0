Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:37389 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab3EKSyj (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 11 May 2013 14:54:39 -0400
Received: by mail-pb0-f48.google.com with SMTP id md4so453461pbc.7
        for <backports@vger.kernel.org>; Sat, 11 May 2013 11:54:38 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 1/5] backports: backport rfkill properly
Date: Sat, 11 May 2013 11:54:25 -0700
Message-Id: <1368298469-29143-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_205441_823866_D64BDE66)
In-Reply-To: <1368298469-29143-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368298469-29143-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

rfkill was being backported using a strategy similar
to the way backports was changed recently with the
only difference that rfkill_backport.h was being used.
Adjust this to enable backporting rfkill as we do with
other modules.

In summary of how we backport rfkill now:

rfkill was re-implemented completely on 2.6.31. As we move on
with new kernels they'll get support for new rfkill types.
We port rfkill to older kernels with this strategy then:

  * For kernels < 2.6.31:
        o use backport_ prefix for exported symbols
        o use:
                /dev/rfkill_backport
                /sys/class/rfkill_backport
  * For kernels >= 2.6.31:
        o use the standard
                /dev/rfkill
                /sys/class/rfkill

Worth mentioning NFC rfkill support was added on next-20130423.

commit 44b3decb414919760c7327df05e63372c1bf5d9a
Author: Samuel Ortiz <sameo@linux.intel.com>
Date:   Thu Apr 11 11:51:36 2013 +0200

    rfkill: Add NFC to the list of supported radios

    And return the proper string for it.

    Acked-by: Johannes Berg <johannes@sipsolutions.net>
    Acked-by: Marcel Holtmann <marcel@holtmann.org>
    Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/rfkill.h           |   13 +++-----
 copy-list                                          |    4 +--
 .../network/0007-ksize-orinoco.patch               |    1 +
 .../network/0008-rfkill.patch                      |   34 +++++++++++++-------
 .../network/66-uapi-changes/INFO                   |   18 -----------
 .../include_linux_rfkill_backport.patch            |   11 -------
 6 files changed, 30 insertions(+), 51 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/66-uapi-changes/INFO
 delete mode 100644 patches/collateral-evolutions/network/66-uapi-changes/include_linux_rfkill_backport.patch

diff --git a/backport/backport-include/linux/rfkill.h b/backport/backport-include/linux/rfkill.h
index 01d18f1..09f8aae 100644
--- a/backport/backport-include/linux/rfkill.h
+++ b/backport/backport-include/linux/rfkill.h
@@ -1,10 +1,7 @@
-#ifndef __COMPAT_RFKILL_H
-#define __COMPAT_RFKILL_H
+#ifndef __BACKPORT_RFKILL_H
+#define __BACKPORT_RFKILL_H
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
-#include_next <linux/rfkill.h>
-#else
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
 #define rfkill_get_led_trigger_name LINUX_BACKPORT(rfkill_get_led_trigger_name)
 #define rfkill_set_led_trigger_name LINUX_BACKPORT(rfkill_set_led_trigger_name)
@@ -20,7 +17,7 @@
 #define rfkill_unregister LINUX_BACKPORT(rfkill_unregister)
 #define rfkill_destroy LINUX_BACKPORT(rfkill_destroy)
 #endif
-#include <linux/rfkill_backport.h>
-#endif
 
-#endif
+#include_next <linux/rfkill.h>
+
+#endif /* __BACKPORT_RFKILL_H */
diff --git a/copy-list b/copy-list
index 8b3de0c..a7c48ca 100644
--- a/copy-list
+++ b/copy-list
@@ -30,8 +30,8 @@ include/linux/spi/libertas_spi.h
 include/linux/platform_data/brcmfmac-sdio.h
 
 include/uapi/linux/nl80211.h
-include/linux/rfkill.h -> include/linux/rfkill_backport.h
-include/uapi/linux/rfkill.h -> include/uapi/linux/rfkill_backport.h
+include/linux/rfkill.h
+include/uapi/linux/rfkill.h
 
 include/net/cfg80211.h
 include/net/cfg80211-wext.h
diff --git a/patches/collateral-evolutions/network/0007-ksize-orinoco.patch b/patches/collateral-evolutions/network/0007-ksize-orinoco.patch
index 934e2fa..8d5bb7f 100644
--- a/patches/collateral-evolutions/network/0007-ksize-orinoco.patch
+++ b/patches/collateral-evolutions/network/0007-ksize-orinoco.patch
@@ -1,3 +1,4 @@
+
 ksize() was added as of 2.6.29, it gives you the actual
 size of the allocated data. Since we have no support for
 this we simply do not optimize for it and deal with
diff --git a/patches/collateral-evolutions/network/0008-rfkill.patch b/patches/collateral-evolutions/network/0008-rfkill.patch
index 7e494a1..6d4da4c 100644
--- a/patches/collateral-evolutions/network/0008-rfkill.patch
+++ b/patches/collateral-evolutions/network/0008-rfkill.patch
@@ -1,12 +1,16 @@
-rfkill was re-implemented on 2.6.31. We port it to
-older kernels with a simple hack, just rename the
-module as a new one rfkill_backport, and every
-exported symbol gets redefined with a _backport
-postfix through compat-2.6.31.h. The changes below
-are the ones we could not do through compat-2.6.31.h
+rfkill was re-implemented completely on 2.6.31. As we move on
+with new kernels they'll get support for new rfkill types.
+We port rfkill to older kernels with this strategy then:
 
-Do older kernels have /dev/rfkill ? I not then we can
-just keep /dev/rfkill and not /dev/rfkill_backport.
+  * For kernels < 2.6.31:
+	o use backport_ prefix for exported symbols
+	o use:
+		/dev/rfkill_backport
+		/sys/class/rfkill_backport
+  * For kernels >= 2.6.31:
+	o use the standard
+		/dev/rfkill
+		/sys/class/rfkill
 
 Note that 2.6.31 added netdevice notifier upon interface
 dev_open() which on cfg80211 will check if checks to see
@@ -30,23 +34,29 @@ This would do the policing from within mac80211.
 
 --- a/net/rfkill/core.c
 +++ b/net/rfkill/core.c
-@@ -826,7 +826,7 @@ static int rfkill_resume(struct device *
+@@ -828,7 +828,11 @@ static int rfkill_resume(struct device *
  }
  
  static struct class rfkill_class = {
--	.name		= "rfkill",
++#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31))
 +	.name		= "rfkill_backport",
++#else
+ 	.name		= "rfkill",
++#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)) */
  	.dev_release	= rfkill_release,
  	.dev_attrs	= rfkill_dev_attrs,
  	.dev_uevent	= rfkill_dev_uevent,
 --- a/net/rfkill/input.c
 +++ b/net/rfkill/input.c
-@@ -230,7 +230,7 @@ static int rfkill_connect(struct input_h
+@@ -230,7 +230,11 @@ static int rfkill_connect(struct input_h
  
  	handle->dev = dev;
  	handle->handler = handler;
--	handle->name = "rfkill";
++#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31))
 +	handle->name = "rfkill_backport";
++#else
+ 	handle->name = "rfkill";
++#endif
  
  	/* causes rfkill_start() to be called */
  	error = input_register_handle(handle);
diff --git a/patches/collateral-evolutions/network/66-uapi-changes/INFO b/patches/collateral-evolutions/network/66-uapi-changes/INFO
deleted file mode 100644
index aac0225..0000000
--- a/patches/collateral-evolutions/network/66-uapi-changes/INFO
+++ /dev/null
@@ -1,18 +0,0 @@
-The UAPI changes split up the kernel and userspace API
-headers into separate directories. We provide backport
-support for the new rfkill module to kernels older than
-2.6.31. To allow us to dynamically provide only backport
-support for those kernels we have a trick within compat
-to provide its own include/linux/rfkill.h header which
-then will include either your own kernel's rkfill.h or
-include the one we are taking from linux-next. The one
-we take from linux-next is renamed to rfkill_backport.h.
-In order to allow the call to include your own kernel's
-rfkill.h the compat rfkill.h uses include_next. The UAPI
-changes would mean though that instead of getting your
-own kernel's rfkill.h you'd end up getting the UAPI
-header file. Fix this by ensuring that for new kernels
-we linux_next into the user's kernels rfkill.h and if
-the kernel is old we still to the rfkill_backport.h
-naming scheme.
-
diff --git a/patches/collateral-evolutions/network/66-uapi-changes/include_linux_rfkill_backport.patch b/patches/collateral-evolutions/network/66-uapi-changes/include_linux_rfkill_backport.patch
deleted file mode 100644
index f5d69d4..0000000
--- a/patches/collateral-evolutions/network/66-uapi-changes/include_linux_rfkill_backport.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/include/linux/rfkill_backport.h
-+++ b/include/linux/rfkill_backport.h
-@@ -18,7 +18,7 @@
- #ifndef __RFKILL_H
- #define __RFKILL_H
- 
--#include <uapi/linux/rfkill.h>
-+#include <uapi/linux/rfkill_backport.h>
- 
- /* don't allow anyone to use these in the kernel */
- enum rfkill_user_states {
-- 
1.7.10.4

