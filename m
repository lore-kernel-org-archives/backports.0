Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44211 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXyK (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:54:10 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 02/42] backports: fix includes in backport code
Date: Sun, 14 Apr 2013 01:53:22 +0200
Message-Id: <1365897243-31214-3-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015414_609133_D5990114)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

A number of includes were missing in the backport(ed)
code since the command line includes almost everything.
As that's going to change, add missing includes to the
code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/compat-2.6.26.c  | 3 ++-
 backport/compat/compat-2.6.27.c  | 2 +-
 backport/compat/compat-2.6.28.c  | 4 +++-
 backport/compat/compat-2.6.32.c  | 1 +
 backport/compat/compat-2.6.33.c  | 3 +++
 backport/compat/compat-2.6.34.c  | 3 +--
 backport/compat/compat-2.6.35.c  | 5 +++++
 backport/compat/compat-2.6.37.c  | 2 ++
 backport/compat/compat-2.6.39.c  | 1 +
 backport/compat/compat-3.5.c     | 1 +
 backport/compat/compat-3.7.c     | 2 ++
 backport/compat/compat-3.9.c     | 1 +
 backport/compat/pm_qos_params.c  | 1 +
 backport/compat/user_namespace.c | 1 +
 14 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/backport/compat/compat-2.6.26.c b/backport/compat/compat-2.6.26.c
index f471506..5193886 100644
--- a/backport/compat/compat-2.6.26.c
+++ b/backport/compat/compat-2.6.26.c
@@ -13,7 +13,8 @@
  * Copyright (c) 2006-2007 Greg Kroah-Hartman <greg@kroah.com>
  * Copyright (c) 2006-2007 Novell Inc.
  */
-
+#include <linux/device.h>
+#include <net/sock.h>
 #include <net/compat.h>
 
 /* 2.6.24 does not have the struct kobject with a name */
diff --git a/backport/compat/compat-2.6.27.c b/backport/compat/compat-2.6.27.c
index 084bdf6..79bbed5 100644
--- a/backport/compat/compat-2.6.27.c
+++ b/backport/compat/compat-2.6.27.c
@@ -7,7 +7,7 @@
  *
  * Compatibility file for Linux wireless for kernels 2.6.27
  */
-
+#include <linux/debugfs.h>
 #include <linux/compat.h>
 #include <linux/pci.h>
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24))
diff --git a/backport/compat/compat-2.6.28.c b/backport/compat/compat-2.6.28.c
index 0ae8f46..451e614 100644
--- a/backport/compat/compat-2.6.28.c
+++ b/backport/compat/compat-2.6.28.c
@@ -11,6 +11,7 @@
 #include <linux/compat.h>
 #include <linux/usb.h>
 #include <linux/tty.h>
+#include <linux/skbuff.h>
 #include <asm/poll.h>
 
 /* 2.6.28 compat code goes here */
@@ -87,7 +88,8 @@ EXPORT_SYMBOL_GPL(usb_poison_urb);
 #endif /* CONFIG_USB */
 
 #if defined(CONFIG_PCMCIA) || defined(CONFIG_PCMCIA_MODULE)
-
+#include <pcmcia/cistpl.h>
+#include <pcmcia/cs_types.h>
 #include <pcmcia/ds.h>
 struct pcmcia_cfg_mem {
 	tuple_t tuple;
diff --git a/backport/compat/compat-2.6.32.c b/backport/compat/compat-2.6.32.c
index b5a66a8..68ab03e 100644
--- a/backport/compat/compat-2.6.32.c
+++ b/backport/compat/compat-2.6.32.c
@@ -10,6 +10,7 @@
 
 #include <linux/compat.h>
 #include <linux/netdevice.h>
+#include <linux/time.h>
 
 int __dev_addr_add(struct dev_addr_list **list, int *count,
 		   void *addr, int alen, int glbl)
diff --git a/backport/compat/compat-2.6.33.c b/backport/compat/compat-2.6.33.c
index f584b85..565836c 100644
--- a/backport/compat/compat-2.6.33.c
+++ b/backport/compat/compat-2.6.33.c
@@ -13,6 +13,9 @@
 #include <linux/usb.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
+#include <pcmcia/cs_types.h>
+#include <pcmcia/cistpl.h>
+#include <pcmcia/ds.h>
 
 #ifdef CONFIG_USB_SUSPEND
 /**
diff --git a/backport/compat/compat-2.6.34.c b/backport/compat/compat-2.6.34.c
index 4b23c81..031d169 100644
--- a/backport/compat/compat-2.6.34.c
+++ b/backport/compat/compat-2.6.34.c
@@ -9,8 +9,7 @@
  */
 
 #include <linux/mmc/sdio_func.h>
-
-#include "compat-2.6.34.h"
+#include <linux/seq_file.h>
 
 static mmc_pm_flag_t backport_mmc_pm_flags;
 
diff --git a/backport/compat/compat-2.6.35.c b/backport/compat/compat-2.6.35.c
index 20fee85..cd556d3 100644
--- a/backport/compat/compat-2.6.35.c
+++ b/backport/compat/compat-2.6.35.c
@@ -11,6 +11,11 @@
 
 #include <linux/compat.h>
 #include <linux/ctype.h>
+#include <linux/netdevice.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <net/sch_generic.h>
 
 #ifdef CONFIG_RPS
 int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
diff --git a/backport/compat/compat-2.6.37.c b/backport/compat/compat-2.6.37.c
index 9f722a6..dadc0ac 100644
--- a/backport/compat/compat-2.6.37.c
+++ b/backport/compat/compat-2.6.37.c
@@ -13,6 +13,8 @@
 #include <net/sock.h>
 #include <linux/nsproxy.h>
 #include <linux/vmalloc.h>
+#include <net/genetlink.h>
+#include <linux/leds.h>
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)
 static const void *net_current_ns(void)
diff --git a/backport/compat/compat-2.6.39.c b/backport/compat/compat-2.6.39.c
index 5bb9322..0e36da8 100644
--- a/backport/compat/compat-2.6.39.c
+++ b/backport/compat/compat-2.6.39.c
@@ -11,6 +11,7 @@
 #include <linux/compat.h>
 #include <linux/tty.h>
 #include <linux/sched.h>
+#include <linux/module.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
 /*
diff --git a/backport/compat/compat-3.5.c b/backport/compat/compat-3.5.c
index 9cc8456..0355ed1 100644
--- a/backport/compat/compat-3.5.c
+++ b/backport/compat/compat-3.5.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/highuid.h>
 #include <linux/ktime.h>
+#include <linux/hrtimer.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 #include <linux/device.h>
diff --git a/backport/compat/compat-3.7.c b/backport/compat/compat-3.7.c
index 226d136..284e8dc 100644
--- a/backport/compat/compat-3.7.c
+++ b/backport/compat/compat-3.7.c
@@ -10,6 +10,8 @@
 
 #include <linux/workqueue.h>
 #include <linux/export.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
 
 bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
 		      unsigned long delay)
diff --git a/backport/compat/compat-3.9.c b/backport/compat/compat-3.9.c
index 56c40d3..0656015 100644
--- a/backport/compat/compat-3.9.c
+++ b/backport/compat/compat-3.9.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/scatterlist.h>
 #include <linux/device.h>
+#include <linux/err.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 /**
diff --git a/backport/compat/pm_qos_params.c b/backport/compat/pm_qos_params.c
index 42785ce..1f000ab 100644
--- a/backport/compat/pm_qos_params.c
+++ b/backport/compat/pm_qos_params.c
@@ -1,3 +1,4 @@
+#include <net/sock.h>
 #include <net/compat.h>
 
 /* This is the backport of pm-qos params for kernels <= 2.6.25 */
diff --git a/backport/compat/user_namespace.c b/backport/compat/user_namespace.c
index 0dcc4bc..288efc0 100644
--- a/backport/compat/user_namespace.c
+++ b/backport/compat/user_namespace.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/highuid.h>
+#include <linux/uidgid.h>
 #include <linux/user_namespace.h>
 
 #ifdef CONFIG_USER_NS
-- 
1.8.0

