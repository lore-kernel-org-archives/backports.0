Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DC2C43219
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856C960EDF
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhJKWZK (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhJKWZB (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:25:01 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB106C061570
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:22:58 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HStbP0Wc2zQkhQ;
        Tue, 12 Oct 2021 00:22:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCpzf5V8kvDOk/AAU9HbP2InULI+WRhyRyZw3JCojxc=;
        b=vCuiFo/d1hZgKOKg3BxMXZYOib9MD7gM0M2Q0fXsa4Uz/QTH2kpi59X9B7c8iZsC7MiZoj
        c6jwTS1HwR6jS+T51tAE1nDK301cZn/oubU2QoMhpbIOCc2JnmAdGnrjhHZoMs/HJZft4Q
        K86VZW3es5P3sOe37beUU80UiP4XUvN5Zwrv2lPqMs9SFSFmEjNGVUJxcgnr2WCGwRZKCh
        w2wdTCNtymTRWzA+yJomMzuaSGHA6A7Hr6U26yP8Za3Jz9R1FjZROGv0TFbnwnsdodf2/W
        jmEMFr8Z+fH71P0vFMeBRiJfL4Vvwn/Efq91ujgEEKx3YjZaUm+zEAZgF7iPOQ==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/14] backports: Remove coredump subsystem backport
Date:   Tue, 12 Oct 2021 00:22:22 +0200
Message-Id: <20211011222227.1189850-10-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4D96E18B8
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This is not needed on kernel 4.0 and later. These kernel versions
already ship a compatible coredump system.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../linux/{bp-devcoredump.h => devcoredump.h} |  6 +-
 backport/compat/Kconfig                       | 11 ---
 backport/compat/backport-4.7.c                | 11 +--
 backport/compat/backports.h                   | 16 -----
 backport/compat/main.c                        | 11 ---
 patches/devcoredump.patch                     | 67 -------------------
 6 files changed, 5 insertions(+), 117 deletions(-)
 rename backport/backport-include/linux/{bp-devcoredump.h => devcoredump.h} (86%)
 delete mode 100644 backport/compat/backports.h
 delete mode 100644 patches/devcoredump.patch

diff --git a/backport/backport-include/linux/bp-devcoredump.h b/backport/backport-include/linux/devcoredump.h
similarity index 86%
rename from backport/backport-include/linux/bp-devcoredump.h
rename to backport/backport-include/linux/devcoredump.h
index 4a8c228b..49b7c30d 100644
--- a/backport/backport-include/linux/bp-devcoredump.h
+++ b/backport/backport-include/linux/devcoredump.h
@@ -1,5 +1,6 @@
 #ifndef __BACKPORT_LINUX_DEVCOREDUMP_H
 #define __BACKPORT_LINUX_DEVCOREDUMP_H
+#include_next <linux/devcoredump.h>
 #include <linux/version.h>
 #include <linux/scatterlist.h>
 
@@ -15,10 +16,9 @@ void backport_dev_coredumpm(struct device *dev, struct module *owner,
 					    size_t datalen),
 			    void (*free_fn)(void *data))
 {
-	return dev_coredumpm(dev, owner, (const void *)data, datalen, gfp,
-			     (void *)read_fn, (void *)free_fn);
+	dev_coredumpm(dev, owner, (const void *)data, datalen, gfp,
+		      (void *)read_fn, (void *)free_fn);
 }
-
 #define dev_coredumpm LINUX_BACKPORT(dev_coredumpm)
 
 #define dev_coredumpsg LINUX_BACKPORT(dev_coredumpsg)
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 625b605e..98752f6f 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -76,17 +76,6 @@ config BPAUTO_USERSEL_BUILD_ALL
 	  It's only really useful for compat testing, so
 	  you probably shouldn't enable it.
 
-config BPAUTO_WANT_DEV_COREDUMP
-	bool
-
-config BPAUTO_BUILD_WANT_DEV_COREDUMP
-	bool
-	default n if DEV_COREDUMP
-	default n if DISABLE_DEV_COREDUMP
-	default y if BPAUTO_WANT_DEV_COREDUMP
-	#h-file linux/devcoredump.h
-	#c-file drivers/base/devcoredump.c
-
 config BPAUTO_RHASHTABLE
 	bool
 	# current API of rhashtable was introduced in version 4.9
diff --git a/backport/compat/backport-4.7.c b/backport/compat/backport-4.7.c
index b47764e6..d261abe6 100644
--- a/backport/compat/backport-4.7.c
+++ b/backport/compat/backport-4.7.c
@@ -8,9 +8,11 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/devcoredump.h>
 #include <linux/export.h>
 #include <linux/list.h>
 #include <linux/rcupdate.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/skbuff.h>
@@ -116,14 +118,6 @@ int nla_put_64bit(struct sk_buff *skb, int attrtype, int attrlen,
 }
 EXPORT_SYMBOL_GPL(nla_put_64bit);
 
-/*
- * Below 3.18 or if the kernel has devcoredump disabled, we copied the
- * entire devcoredump, so no need to define these functions.
- */
-#if !defined(CPTCFG_BPAUTO_BUILD_WANT_DEV_COREDUMP)
-#include <linux/devcoredump.h>
-#include <linux/scatterlist.h>
-
 static void devcd_free_sgtable(void *data)
 {
 	struct scatterlist *table = data;
@@ -180,4 +174,3 @@ void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 		      (void *)devcd_free_sgtable);
 }
 EXPORT_SYMBOL_GPL(dev_coredumpsg);
-#endif /* !CPTCFG_BPAUTO_BUILD_WANT_DEV_COREDUMP */
diff --git a/backport/compat/backports.h b/backport/compat/backports.h
deleted file mode 100644
index 53848888..00000000
--- a/backport/compat/backports.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef LINUX_BACKPORTS_PRIVATE_H
-#define LINUX_BACKPORTS_PRIVATE_H
-
-#include <linux/version.h>
-
-#ifdef CPTCFG_BPAUTO_BUILD_WANT_DEV_COREDUMP
-int devcoredump_init(void);
-void devcoredump_exit(void);
-#else
-static inline int devcoredump_init(void)
-{ return 0; }
-static inline void devcoredump_exit(void)
-{}
-#endif
-
-#endif /* LINUX_BACKPORTS_PRIVATE_H */
diff --git a/backport/compat/main.c b/backport/compat/main.c
index 0bf04201..2540e757 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -2,7 +2,6 @@
 #include <linux/init.h>
 #include <linux/pm_qos.h>
 #include <linux/workqueue.h>
-#include "backports.h"
 
 MODULE_AUTHOR("Luis R. Rodriguez");
 MODULE_DESCRIPTION("Kernel backport module");
@@ -53,10 +52,6 @@ EXPORT_SYMBOL_GPL(backport_dependency_symbol);
 
 static int __init backport_init(void)
 {
-	int ret = devcoredump_init();
-	if (ret)
-		return ret;
-
 	printk(KERN_INFO "Loading modules backported from " CPTCFG_KERNEL_NAME
 #ifndef BACKPORTS_GIT_TRACKED
 		" version " CPTCFG_KERNEL_VERSION
@@ -77,9 +72,3 @@ static int __init backport_init(void)
         return 0;
 }
 subsys_initcall(backport_init);
-
-static void __exit backport_exit(void)
-{
-	devcoredump_exit();
-}
-module_exit(backport_exit);
diff --git a/patches/devcoredump.patch b/patches/devcoredump.patch
deleted file mode 100644
index e56d52c8..00000000
--- a/patches/devcoredump.patch
+++ /dev/null
@@ -1,67 +0,0 @@
---- a/compat/drivers-base-devcoredump.c
-+++ b/compat/drivers-base-devcoredump.c
-@@ -16,6 +16,7 @@
- #include <linux/slab.h>
- #include <linux/fs.h>
- #include <linux/workqueue.h>
-+#include "backports.h"
- 
- static struct class devcd_class;
- 
-@@ -54,8 +55,7 @@ static void devcd_dev_release(struct dev
- 	 * a struct device to know when it goes away?
- 	 */
- 	if (devcd->failing_dev->kobj.sd)
--		sysfs_delete_link(&devcd->failing_dev->kobj, &dev->kobj,
--				  "devcoredump");
-+		sysfs_remove_link(&devcd->failing_dev->kobj, "devcoredump");
- 
- 	put_device(devcd->failing_dev);
- 	kfree(devcd);
-@@ -334,15 +334,13 @@ void dev_coredumpsg(struct device *dev,
- }
- EXPORT_SYMBOL_GPL(dev_coredumpsg);
- 
--static int __init devcoredump_init(void)
-+int __init devcoredump_init(void)
- {
- 	return class_register(&devcd_class);
- }
--__initcall(devcoredump_init);
- 
--static void __exit devcoredump_exit(void)
-+void __exit devcoredump_exit(void)
- {
- 	class_for_each_device(&devcd_class, NULL, NULL, devcd_free);
- 	class_unregister(&devcd_class);
- }
--__exitcall(devcoredump_exit);
---- a/include/linux/backport-devcoredump.h
-+++ b/include/linux/backport-devcoredump.h
-@@ -51,7 +51,7 @@ static inline void _devcd_free_sgtable(s
- }
- 
- 
--#ifdef CONFIG_DEV_COREDUMP
-+#ifdef CPTCFG_BPAUTO_WANT_DEV_COREDUMP
- void dev_coredumpv(struct device *dev, void *data, size_t datalen,
- 		   gfp_t gfp);
- 
-@@ -85,6 +85,6 @@ static inline void dev_coredumpsg(struct
- {
- 	_devcd_free_sgtable(table);
- }
--#endif /* CONFIG_DEV_COREDUMP */
-+#endif /* CPTCFG_BPAUTO_WANT_DEV_COREDUMP */
- 
- #endif /* __DEVCOREDUMP_H */
---- a/include/linux/devcoredump.h
-+++ b/include/linux/devcoredump.h
-@@ -1,6 +1,7 @@
- /* Automatically created during backport process */
- #ifndef CPTCFG_BPAUTO_BUILD_WANT_DEV_COREDUMP
- #include_next <linux/devcoredump.h>
-+#include <linux/bp-devcoredump.h>
- #else
- #undef dev_coredumpv
- #define dev_coredumpv LINUX_BACKPORT(dev_coredumpv)
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
