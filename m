Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:52101 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab3ENT3C (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 14 May 2013 15:29:02 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: sameo@linux.intel.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] backports: don't backport rfkill, only API
Date: Tue, 14 May 2013 21:28:56 +0200
Message-Id: <1368559736-14602-1-git-send-email-johannes@sipsolutions.net> (sfid-20130514_212904_539236_35FDB1E5)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

There's not much point in backporting rfkill, if the base kernel
doesn't have it then providing the it as /dev/rfkill_backport
won't be picked up by any apps, and if the base kernel has it
then it would cause odd behaviour as the base kernel's platform
drivers using the rfkill API would not talk to the backported
modules rfkill.

An unusable backported rfkill isn't much better than not having
it at all, so change the way we backport rfkill and don't carry
the code but simply provide the API as wrappers.

If the base kernel is 3.10 or higher (the current version) then
don't change anything at all.

If the base kernel is 2.6.33 or higher (with the new rfkill API)
then just wrap the API and disable rfkill registrations for any
types that the base kernel doesn't know about.

For all other kernels, provide only static inlines that behave
like the rfkill API when rfkill isn't compiled in.

The downside is that we need to copy the rfkill API. This is,
however, very very stable (it essentially hasn't changed since
2.6.33), so that's not a problem.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/rfkill.h           | 186 +++++++++++++++++++--
 copy-list                                          |   3 -
 .../network/0008-rfkill.patch                      |  52 ------
 .../network/66-uapi-changes/INFO                   |  18 --
 .../include_linux_rfkill_backport.patch            |  11 --
 5 files changed, 169 insertions(+), 101 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0008-rfkill.patch
 delete mode 100644 patches/collateral-evolutions/network/66-uapi-changes/INFO
 delete mode 100644 patches/collateral-evolutions/network/66-uapi-changes/include_linux_rfkill_backport.patch

diff --git a/backport/backport-include/linux/rfkill.h b/backport/backport-include/linux/rfkill.h
index 01d18f1..d9422bc 100644
--- a/backport/backport-include/linux/rfkill.h
+++ b/backport/backport-include/linux/rfkill.h
@@ -2,25 +2,177 @@
 #define __COMPAT_RFKILL_H
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
 #include_next <linux/rfkill.h>
 #else
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-#define rfkill_get_led_trigger_name LINUX_BACKPORT(rfkill_get_led_trigger_name)
-#define rfkill_set_led_trigger_name LINUX_BACKPORT(rfkill_set_led_trigger_name)
-#define rfkill_set_hw_state LINUX_BACKPORT(rfkill_set_hw_state)
-#define rfkill_set_sw_state LINUX_BACKPORT(rfkill_set_sw_state)
-#define rfkill_init_sw_state LINUX_BACKPORT(rfkill_init_sw_state)
-#define rfkill_set_states LINUX_BACKPORT(rfkill_set_states)
-#define rfkill_pause_polling LINUX_BACKPORT(rfkill_pause_polling)
-#define rfkill_resume_polling LINUX_BACKPORT(rfkill_resume_polling)
-#define rfkill_blocked LINUX_BACKPORT(rfkill_blocked)
-#define rfkill_alloc LINUX_BACKPORT(rfkill_alloc)
-#define rfkill_register LINUX_BACKPORT(rfkill_register)
-#define rfkill_unregister LINUX_BACKPORT(rfkill_unregister)
-#define rfkill_destroy LINUX_BACKPORT(rfkill_destroy)
-#endif
-#include <linux/rfkill_backport.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33)
+/* API only slightly changed since then */
+#define rfkill_type old_rfkill_type
+#define RFKILL_TYPE_ALL OLD_RFKILL_TYPE_ALL
+#define RFKILL_TYPE_WLAN OLD_RFKILL_TYPE_WLAN
+#define RFKILL_TYPE_BLUETOOTH OLD_RFKILL_TYPE_BLUETOOTH
+#define RFKILL_TYPE_UWB OLD_RFKILL_TYPE_UWB
+#define RFKILL_TYPE_WIMAX OLD_RFKILL_TYPE_WIMAX
+#define RFKILL_TYPE_WWAN OLD_RFKILL_TYPE_WWAN
+#define RFKILL_TYPE_GPS OLD_RFKILL_TYPE_GPS
+#define RFKILL_TYPE_FM OLD_RFKILL_TYPE_FM
+#define RFKILL_TYPE_NFC OLD_RFKILL_TYPE_NFC
+#define NUM_RFKILL_TYPES OLD_NUM_RFKILL_TYPES
+#include_next <linux/rfkill.h>
+#undef rfkill_type
+#undef RFKILL_TYPE_ALL
+#undef RFKILL_TYPE_WLAN
+#undef RFKILL_TYPE_BLUETOOTH
+#undef RFKILL_TYPE_UWB
+#undef RFKILL_TYPE_WIMAX
+#undef RFKILL_TYPE_WWAN
+#undef RFKILL_TYPE_GPS
+#undef RFKILL_TYPE_FM
+#undef RFKILL_TYPE_NFC
+#undef NUM_RFKILL_TYPES
+#define HAVE_OLD_RFKILL
+#else
+#undef HAVE_OLD_RFKILL
+#include <linux/device.h>
+struct rfkill;
+
+struct rfkill_ops {
+	void	(*poll)(struct rfkill *rfkill, void *data);
+	void	(*query)(struct rfkill *rfkill, void *data);
+	int	(*set_block)(void *data, bool blocked);
+};
+#endif
+
+/* this changes infrequently, backport manually */
+enum rfkill_type {
+	RFKILL_TYPE_ALL = 0,
+	RFKILL_TYPE_WLAN,
+	RFKILL_TYPE_BLUETOOTH,
+	RFKILL_TYPE_UWB,
+	RFKILL_TYPE_WIMAX,
+	RFKILL_TYPE_WWAN,
+	RFKILL_TYPE_GPS,
+	RFKILL_TYPE_FM,
+	RFKILL_TYPE_NFC,
+	NUM_RFKILL_TYPES,
+};
+
+static inline struct rfkill * __must_check
+backport_rfkill_alloc(const char *name,
+		      struct device *parent,
+		      const enum rfkill_type type,
+		      const struct rfkill_ops *ops,
+		      void *ops_data)
+{
+#ifdef HAVE_OLD_RFKILL
+	if ((unsigned int)type >= (unsigned int)OLD_NUM_RFKILL_TYPES)
+		return ERR_PTR(-ENODEV);
+	return rfkill_alloc(name, parent, type, ops, ops_data);
+#else
+	return ERR_PTR(-ENODEV);
+#endif
+}
+#define rfkill_alloc backport_rfkill_alloc
+
+static inline int __must_check backport_rfkill_register(struct rfkill *rfkill)
+{
+	if (rfkill == ERR_PTR(-ENODEV))
+		return 0;
+#ifdef HAVE_OLD_RFKILL
+	return rfkill_register(rfkill);
+#else
+	return -EINVAL;
+#endif
+}
+#define rfkill_register backport_rfkill_register
+
+static inline void backport_rfkill_pause_polling(struct rfkill *rfkill)
+{
+#ifdef HAVE_OLD_RFKILL
+	rfkill_pause_polling(rfkill);
+#endif
+}
+#define rfkill_pause_polling backport_rfkill_pause_polling
+
+static inline void backport_rfkill_resume_polling(struct rfkill *rfkill)
+{
+#ifdef HAVE_OLD_RFKILL
+	rfkill_resume_polling(rfkill);
+#endif
+}
+#define rfkill_resume_polling backport_rfkill_resume_polling
+
+static inline void backport_rfkill_unregister(struct rfkill *rfkill)
+{
+#ifdef HAVE_OLD_RFKILL
+	if (rfkill == ERR_PTR(-ENODEV))
+		return;
+	rfkill_unregister(rfkill);
+#endif
+}
+#define rfkill_unregister backport_rfkill_unregister
+
+static inline void backport_rfkill_destroy(struct rfkill *rfkill)
+{
+#ifdef HAVE_OLD_RFKILL
+	if (rfkill == ERR_PTR(-ENODEV))
+		return;
+	rfkill_destroy(rfkill);
+#endif
+}
+#define rfkill_destroy backport_rfkill_destroy
+
+static inline bool backport_rfkill_set_hw_state(struct rfkill *rfkill,
+						bool blocked)
+{
+#ifdef HAVE_OLD_RFKILL
+	if (rfkill != ERR_PTR(-ENODEV))
+		return rfkill_set_hw_state(rfkill, blocked);
+#endif
+	return blocked;
+}
+#define rfkill_set_hw_state backport_rfkill_set_hw_state
+
+static inline bool backport_rfkill_set_sw_state(struct rfkill *rfkill,
+						bool blocked)
+{
+#ifdef HAVE_OLD_RFKILL
+	if (rfkill != ERR_PTR(-ENODEV))
+		return rfkill_set_sw_state(rfkill, blocked);
+#endif
+	return blocked;
+}
+#define rfkill_set_sw_state backport_rfkill_set_sw_state
+
+static inline void backport_rfkill_init_sw_state(struct rfkill *rfkill,
+						 bool blocked)
+{
+#ifdef HAVE_OLD_RFKILL
+	if (rfkill != ERR_PTR(-ENODEV))
+		rfkill_init_sw_state(rfkill, blocked);
+#endif
+}
+#define rfkill_init_sw_state backport_rfkill_init_sw_state
+
+static inline void backport_rfkill_set_states(struct rfkill *rfkill,
+					      bool sw, bool hw)
+{
+#ifdef HAVE_OLD_RFKILL
+	if (rfkill != ERR_PTR(-ENODEV))
+		rfkill_set_states(rfkill, sw, hw);
+#endif
+}
+#define rfkill_set_states backport_rfkill_set_states
+
+static inline bool backport_rfkill_blocked(struct rfkill *rfkill)
+{
+#ifdef HAVE_OLD_RFKILL
+	if (rfkill != ERR_PTR(-ENODEV))
+		return rfkill_blocked(rfkill);
+#endif
+	return false;
+}
+#define rfkill_blocked backport_rfkill_blocked
 #endif
 
 #endif
diff --git a/copy-list b/copy-list
index 8b3de0c..f2afa15 100644
--- a/copy-list
+++ b/copy-list
@@ -30,8 +30,6 @@ include/linux/spi/libertas_spi.h
 include/linux/platform_data/brcmfmac-sdio.h
 
 include/uapi/linux/nl80211.h
-include/linux/rfkill.h -> include/linux/rfkill_backport.h
-include/uapi/linux/rfkill.h -> include/uapi/linux/rfkill_backport.h
 
 include/net/cfg80211.h
 include/net/cfg80211-wext.h
@@ -44,7 +42,6 @@ net/Makefile
 net/Kconfig
 net/wireless/
 net/mac80211/
-net/rfkill/
 
 drivers/net/wireless/ath/
 drivers/ssb/
diff --git a/patches/collateral-evolutions/network/0008-rfkill.patch b/patches/collateral-evolutions/network/0008-rfkill.patch
deleted file mode 100644
index 7e494a1..0000000
--- a/patches/collateral-evolutions/network/0008-rfkill.patch
+++ /dev/null
@@ -1,52 +0,0 @@
-rfkill was re-implemented on 2.6.31. We port it to
-older kernels with a simple hack, just rename the
-module as a new one rfkill_backport, and every
-exported symbol gets redefined with a _backport
-postfix through compat-2.6.31.h. The changes below
-are the ones we could not do through compat-2.6.31.h
-
-Do older kernels have /dev/rfkill ? I not then we can
-just keep /dev/rfkill and not /dev/rfkill_backport.
-
-Note that 2.6.31 added netdevice notifier upon interface
-dev_open() which on cfg80211 will check if checks to see
-if rfkill is enabled (or if the mode of operation is not
-supported) on the  cfg80211_netdev_notifier_call() and if
-so deny bringing the interface up. This was added via
-commit:
-
-3b8bcfd5d31ea0fec58681d035544ace707d2536
-
-Since older kernels will not have the notifier call
-on dev_open() if we *really want* to port this we could have
-mac80211's subif_open() call :
-
-	ret = call_netdevice_notifiers(NETDEV_PRE_UP, dev);
-	ret = notifier_to_errno(ret);
-	if (ret)
-		return ret;
-
-This would do the policing from within mac80211.
-
---- a/net/rfkill/core.c
-+++ b/net/rfkill/core.c
-@@ -826,7 +826,7 @@ static int rfkill_resume(struct device *
- }
- 
- static struct class rfkill_class = {
--	.name		= "rfkill",
-+	.name		= "rfkill_backport",
- 	.dev_release	= rfkill_release,
- 	.dev_attrs	= rfkill_dev_attrs,
- 	.dev_uevent	= rfkill_dev_uevent,
---- a/net/rfkill/input.c
-+++ b/net/rfkill/input.c
-@@ -230,7 +230,7 @@ static int rfkill_connect(struct input_h
- 
- 	handle->dev = dev;
- 	handle->handler = handler;
--	handle->name = "rfkill";
-+	handle->name = "rfkill_backport";
- 
- 	/* causes rfkill_start() to be called */
- 	error = input_register_handle(handle);
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
1.8.0

