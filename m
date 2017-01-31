Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:50255 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752030AbdAaN4u (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 31 Jan 2017 08:56:50 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Luca Coelho <luca@coelho.fi>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] backports: adjustments: fix devcoredump patch for class_groups
Date: Tue, 31 Jan 2017 13:46:44 +0000
Message-Id: <1485870404-28663-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170131_145653_838432_40EC8097)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Since...

  commit f76d25275c314defb684fdd692239507001774bc
  Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Date:   Mon Nov 28 16:41:58 2016 +0100

     driver core: devcoredump: convert to use class_groups

it is using struct class::class_groups. Update the devcoredump
patch file accordingly.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 patches/backport-adjustments/devcoredump.patch | 43 +++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/patches/backport-adjustments/devcoredump.patch b/patches/backport-adjustments/devcoredump.patch
index f35e881..ab38ac6 100644
--- a/patches/backport-adjustments/devcoredump.patch
+++ b/patches/backport-adjustments/devcoredump.patch
@@ -10,7 +10,7 @@ index 240374f..8bb376b 100644
  
  static struct class devcd_class;
  
-@@ -40,6 +41,10 @@ static bool devcd_disabled;
+@@ -40,6 +41,10 @@
  /* if data isn't read by userspace after 5 minutes then delete it */
  #define DEVCD_TIMEOUT	(HZ * 60 * 5)
  
@@ -41,7 +41,7 @@ index 240374f..8bb376b 100644
  	device_del(&devcd->devcd_dev);
  	put_device(&devcd->devcd_dev);
  }
-@@ -115,6 +122,7 @@ static struct bin_attribute devcd_attr_data = {
+@@ -115,6 +122,7 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
  	.write = devcd_data_write,
  };
  
@@ -49,7 +49,7 @@ index 240374f..8bb376b 100644
  static struct bin_attribute *devcd_dev_bin_attrs[] = {
  	&devcd_attr_data, NULL,
  };
-@@ -126,6 +134,7 @@ static const struct attribute_group devcd_dev_group = {
+@@ -126,6 +134,7 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
  static const struct attribute_group *devcd_dev_groups[] = {
  	&devcd_dev_group, NULL,
  };
@@ -57,17 +57,44 @@ index 240374f..8bb376b 100644
  
  static int devcd_free(struct device *dev, void *data)
  {
-@@ -170,7 +179,9 @@ static struct class devcd_class = {
+@@ -160,20 +169,35 @@ static ssize_t disabled_store(struct class *class, struct class_attribute *attr,
+ 
+ 	return count;
+ }
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 10, 0)
++static struct class_attribute devcd_class_attrs[] = {
++	__ATTR_RW(disabled),
++	__ATTR_NULL
++};
++#else
+ static CLASS_ATTR_RW(disabled);
+ 
+ static struct attribute *devcd_class_attrs[] = {
+ 	&class_attr_disabled.attr,
+ 	NULL,
+ };
+-ATTRIBUTE_GROUPS(devcd_class);
++static const struct attribute_group devcd_class_group = {
++	.attrs = devcd_class_attrs,
++};
++#endif
+ 
+ static struct class devcd_class = {
  	.name		= "devcoredump",
  	.owner		= THIS_MODULE,
  	.dev_release	= devcd_dev_release,
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
  	.dev_groups	= devcd_dev_groups,
 +#endif
- 	.class_attrs	= devcd_class_attrs,
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 10, 0)
++	.class_attrs	= devcd_class_attrs,
++#else
+ 	.class_groups	= devcd_class_groups,
++#endif
  };
  
-@@ -231,6 +242,14 @@ static void devcd_free_sgtable(void *data)
+ static ssize_t devcd_readv(char *buffer, loff_t offset, size_t count,
+@@ -233,6 +257,14 @@ static void devcd_free_sgtable(void *data)
  	_devcd_free_sgtable(data);
  }
  
@@ -82,7 +109,7 @@ index 240374f..8bb376b 100644
  /**
   * devcd_read_from_table - copy data from sg_table to a given buffer
   * and return the number of bytes read
-@@ -314,6 +333,11 @@ void dev_coredumpm(struct device *dev, struct module *owner,
+@@ -316,6 +348,11 @@ void dev_coredumpm(struct device *dev, struct module *owner,
  	if (device_add(&devcd->devcd_dev))
  		goto put_device;
  
@@ -94,7 +121,7 @@ index 240374f..8bb376b 100644
  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
  			      "failing_device"))
  		/* nothing - symlink will be missing */;
-@@ -356,15 +380,13 @@ void dev_coredumpsg(struct device *dev, struct scatterlist *table,
+@@ -358,15 +395,13 @@ void dev_coredumpsg(struct device *dev, struct scatterlist *table,
  }
  EXPORT_SYMBOL_GPL(dev_coredumpsg);
  
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
