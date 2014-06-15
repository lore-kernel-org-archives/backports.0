Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44135 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbaFOQfu (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 12:35:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 019327E24
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 18:35:49 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/6] backports: fix a compile warning in devnode
Date: Sun, 15 Jun 2014 18:35:22 +0200
Message-Id: <1402850123-22382-6-git-send-email-hauke@hauke-m.de> (sfid-20140615_183556_462302_EB32735F)
In-Reply-To: <1402850123-22382-1-git-send-email-hauke@hauke-m.de>
References: <1402850123-22382-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The mode parameter type was changed in the callback function devnode in
struct device_type.

commit 2c9ede55ecec58099b72e4bb8eab719f32f72c31
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Jul 23 20:24:48 2011 -0400

    switch device_get_devnode() and ->devnode() to umode_t *

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0004-devnode_param_type/INFO                     |  8 ++++++++
 .../media/0004-devnode_param_type/ddbridge.patch           | 14 ++++++++++++++
 .../media/0004-devnode_param_type/dvb-core.patch           | 14 ++++++++++++++
 .../media/0004-devnode_param_type/rc.patch                 | 14 ++++++++++++++
 4 files changed, 50 insertions(+)
 create mode 100644 patches/collateral-evolutions/media/0004-devnode_param_type/INFO
 create mode 100644 patches/collateral-evolutions/media/0004-devnode_param_type/ddbridge.patch
 create mode 100644 patches/collateral-evolutions/media/0004-devnode_param_type/dvb-core.patch
 create mode 100644 patches/collateral-evolutions/media/0004-devnode_param_type/rc.patch

diff --git a/patches/collateral-evolutions/media/0004-devnode_param_type/INFO b/patches/collateral-evolutions/media/0004-devnode_param_type/INFO
new file mode 100644
index 0000000..192cfb8
--- /dev/null
+++ b/patches/collateral-evolutions/media/0004-devnode_param_type/INFO
@@ -0,0 +1,8 @@
+The mode parameter type was changed in the callback function devnode in
+struct device_type.
+
+commit 2c9ede55ecec58099b72e4bb8eab719f32f72c31
+Author: Al Viro <viro@zeniv.linux.org.uk>
+Date:   Sat Jul 23 20:24:48 2011 -0400
+
+    switch device_get_devnode() and ->devnode() to umode_t *
diff --git a/patches/collateral-evolutions/media/0004-devnode_param_type/ddbridge.patch b/patches/collateral-evolutions/media/0004-devnode_param_type/ddbridge.patch
new file mode 100644
index 0000000..6dd182b
--- /dev/null
+++ b/patches/collateral-evolutions/media/0004-devnode_param_type/ddbridge.patch
@@ -0,0 +1,14 @@
+--- a/drivers/media/pci/ddbridge/ddbridge-core.c
++++ b/drivers/media/pci/ddbridge/ddbridge-core.c
+@@ -1479,7 +1479,11 @@ static const struct file_operations ddb_
+ 	.open           = ddb_open,
+ };
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ static char *ddb_devnode(struct device *device, umode_t *mode)
++#else
++static char *ddb_devnode(struct device *device, mode_t *mode)
++#endif
+ {
+ 	struct ddb *dev = dev_get_drvdata(device);
+ 
diff --git a/patches/collateral-evolutions/media/0004-devnode_param_type/dvb-core.patch b/patches/collateral-evolutions/media/0004-devnode_param_type/dvb-core.patch
new file mode 100644
index 0000000..3b4385e
--- /dev/null
+++ b/patches/collateral-evolutions/media/0004-devnode_param_type/dvb-core.patch
@@ -0,0 +1,14 @@
+--- a/drivers/media/dvb-core/dvbdev.c
++++ b/drivers/media/dvb-core/dvbdev.c
+@@ -442,7 +442,11 @@ static int dvb_uevent(struct device *dev
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ static char *dvb_devnode(struct device *dev, umode_t *mode)
++#else
++static char *dvb_devnode(struct device *dev, mode_t *mode)
++#endif
+ {
+ 	struct dvb_device *dvbdev = dev_get_drvdata(dev);
+ 
diff --git a/patches/collateral-evolutions/media/0004-devnode_param_type/rc.patch b/patches/collateral-evolutions/media/0004-devnode_param_type/rc.patch
new file mode 100644
index 0000000..38acfda
--- /dev/null
+++ b/patches/collateral-evolutions/media/0004-devnode_param_type/rc.patch
@@ -0,0 +1,14 @@
+--- a/drivers/media/rc/rc-main.c
++++ b/drivers/media/rc/rc-main.c
+@@ -755,7 +755,11 @@ static void ir_close(struct input_dev *i
+ }
+ 
+ /* class for /sys/class/rc */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ static char *rc_devnode(struct device *dev, umode_t *mode)
++#else
++static char *rc_devnode(struct device *dev, mode_t *mode)
++#endif
+ {
+ 	return kasprintf(GFP_KERNEL, "rc/%s", dev_name(dev));
+ }
-- 
1.9.1

