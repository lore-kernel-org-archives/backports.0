Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49570 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841Ab3JENYo (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 09:24:44 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/8] backports: backport new sysfs api in media
Date: Sat,  5 Oct 2013 15:23:49 +0200
Message-Id: <1380979435-5430-3-git-send-email-hauke@hauke-m.de> (sfid-20131005_152445_582299_ABA5ACD7)
In-Reply-To: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
References: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0004-sysfs-api.patch                     |   32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 patches/collateral-evolutions/media/0004-sysfs-api.patch

diff --git a/patches/collateral-evolutions/media/0004-sysfs-api.patch b/patches/collateral-evolutions/media/0004-sysfs-api.patch
new file mode 100644
index 0000000..1fcc610
--- /dev/null
+++ b/patches/collateral-evolutions/media/0004-sysfs-api.patch
@@ -0,0 +1,32 @@
+diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
+index b0f49b0..461e3e1 100644
+--- a/drivers/media/v4l2-core/v4l2-dev.c
++++ b/drivers/media/v4l2-core/v4l2-dev.c
+@@ -86,6 +86,7 @@ static struct attribute *video_device_at
+ 	&dev_attr_index.attr,
+ 	NULL,
+ };
++#define BP_ATTR_GRP_STRUCT device_attribute
+ ATTRIBUTE_GROUPS(video_device);
+ 
+ /*
+@@ -221,7 +222,11 @@ static void v4l2_device_release(struct d
+ 
+ static struct class video_class = {
+ 	.name = VIDEO_NAME,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
+ 	.dev_groups = video_device_groups,
++#else
++	.dev_attrs = video_device_dev_attrs,
++#endif
+ };
+ 
+ struct video_device *video_devdata(struct file *file)
+@@ -991,6 +996,7 @@ static int __init videodev_init(void)
+ 		return ret;
+ 	}
+ 
++	init_video_device_attrs();
+ 	ret = class_register(&video_class);
+ 	if (ret < 0) {
+ 		unregister_chrdev_region(dev, VIDEO_NUM_DEVICES);
-- 
1.7.10.4

