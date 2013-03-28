Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40611 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab3C1TNn (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 28 Mar 2013 15:13:43 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/8] compat-drivers: fix signature for struct rchan_callbacks
Date: Thu, 28 Mar 2013 20:12:17 +0100
Message-Id: <1364497938-10646-7-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
References: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

the signature for struct rchan_callbacks.create_buf_file changed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/70-umode_t-api-change.patch            |   28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/70-umode_t-api-change.patch

diff --git a/patches/collateral-evolutions/network/70-umode_t-api-change.patch b/patches/collateral-evolutions/network/70-umode_t-api-change.patch
new file mode 100644
index 0000000..dd6ec68
--- /dev/null
+++ b/patches/collateral-evolutions/network/70-umode_t-api-change.patch
@@ -0,0 +1,28 @@
+--- a/drivers/net/wireless/ath/ath9k/debug.c
++++ b/drivers/net/wireless/ath/ath9k/debug.c
+@@ -1217,7 +1217,11 @@ static const struct file_operations fops
+ 
+ static struct dentry *create_buf_file_handler(const char *filename,
+ 					      struct dentry *parent,
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
+ 					      umode_t mode,
++#else
++					      int mode,
++#endif
+ 					      struct rchan_buf *buf,
+ 					      int *is_global)
+ {
+--- a/drivers/gpu/drm/drm_sysfs.c
++++ b/drivers/gpu/drm/drm_sysfs.c
+@@ -72,7 +72,11 @@ static int drm_class_resume(struct devic
+ 	return 0;
+ }
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
+ static char *drm_devnode(struct device *dev, umode_t *mode)
++#else
++static char *drm_devnode(struct device *dev, mode_t *mode)
++#endif
+ {
+ 	return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
+ }
-- 
1.7.10.4

