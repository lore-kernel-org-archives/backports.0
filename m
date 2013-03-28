Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40617 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893Ab3C1TN3 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 28 Mar 2013 15:13:29 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/8] compat-drivers: fix signature for struct bin_attribute
Date: Thu, 28 Mar 2013 20:12:18 +0100
Message-Id: <1364497938-10646-8-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
References: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The signature for struct bin_attribute.read changed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/71-bin_attribute-api-change.patch            |   14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/71-bin_attribute-api-change.patch

diff --git a/patches/collateral-evolutions/network/71-bin_attribute-api-change.patch b/patches/collateral-evolutions/network/71-bin_attribute-api-change.patch
new file mode 100644
index 0000000..2425660
--- /dev/null
+++ b/patches/collateral-evolutions/network/71-bin_attribute-api-change.patch
@@ -0,0 +1,14 @@
+--- a/drivers/net/wireless/ti/wlcore/main.c
++++ b/drivers/net/wireless/ti/wlcore/main.c
+@@ -5518,7 +5518,11 @@ static ssize_t wl1271_sysfs_show_hw_pg_v
+ static DEVICE_ATTR(hw_pg_ver, S_IRUGO,
+ 		   wl1271_sysfs_show_hw_pg_ver, NULL);
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+ static ssize_t wl1271_sysfs_read_fwlog(struct file *filp, struct kobject *kobj,
++#else
++static ssize_t wl1271_sysfs_read_fwlog(struct kobject *kobj,
++#endif
+ 				       struct bin_attribute *bin_attr,
+ 				       char *buffer, loff_t pos, size_t count)
+ {
-- 
1.7.10.4

