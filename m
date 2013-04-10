Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36142 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab3DJLgS (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:36:18 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so218152pbb.5
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:36:18 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 09/18] compat: backport devm_ioremap_resource()
Date: Wed, 10 Apr 2013 04:35:19 -0700
Message-Id: <1365593728-5720-10-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133620_830185_30EF4970)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

The new API gives more information to driver users but
the older kernels do not have any of these mechanisms
in place so just throw out ERR_PTR(-ENOMEM) in case
of failure.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains 75096579
v3.9-rc1~128^2~63

commit 75096579c3ac39ddc2f8b0d9a8924eba31f4d920
Author: Thierry Reding <thierry.reding@avionic-design.de>
Date:   Mon Jan 21 11:08:54 2013 +0100

    lib: devres: Introduce devm_ioremap_resource()

    The devm_request_and_ioremap() function is very useful and helps avoid a
    whole lot of boilerplate. However, one issue that keeps popping up is
    its lack of a specific error code to determine which of the steps that
    it performs failed. Furthermore, while the function gives an example and
    suggests what error code to return on failure, a wide variety of error
    codes are used throughout the tree.

    In an attempt to fix these problems, this patch adds a new function that
    drivers can transition to. The devm_ioremap_resource() returns a pointer
    to the remapped I/O memory on success or an ERR_PTR() encoded error code
    on failure. Callers can check for failure using IS_ERR() and determine
    its cause by extracting the error code using PTR_ERR().

    devm_request_and_ioremap() is implemented as a wrapper around the new
    API and return NULL on failure as before. This ensures that backwards
    compatibility is maintained until all users have been converted to the
    new API, at which point the old devm_request_and_ioremap() function
    should be removed.

    A semantic patch is included which can be used to convert from the old
    devm_request_and_ioremap() API to the new devm_ioremap_resource() API.
    Some non-trivial cases may require manual intervention, though.

    Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/compat-3.9.c        |   12 ++++++++++++
 backport/include/linux/compat-3.9.h |    4 ++++
 2 files changed, 16 insertions(+)

diff --git a/backport/compat/compat-3.9.c b/backport/compat/compat-3.9.c
index 1f24842..61a062a 100644
--- a/backport/compat/compat-3.9.c
+++ b/backport/compat/compat-3.9.c
@@ -10,6 +10,7 @@
 
 #include <linux/module.h>
 #include <linux/scatterlist.h>
+#include <linux/device.h>
 
 #ifdef __sg_page_iter_next
 
@@ -51,4 +52,15 @@ bool __sg_page_iter_next(struct sg_page_iter *piter)
 }
 EXPORT_SYMBOL_GPL(__sg_page_iter_next);
 
+void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
+{
+	void __iomem *dest_ptr;
+
+	dest_ptr = devm_ioremap_resource(dev, res);
+	if (!dest_ptr)
+		return ERR_PTR(-ENOMEM);
+	return dest_ptr;
+}
+EXPORT_SYMBOL_GPL(devm_ioremap_resource);
+
 #endif /* __sg_page_iter_next */
diff --git a/backport/include/linux/compat-3.9.h b/backport/include/linux/compat-3.9.h
index aed569c..a4362e2 100644
--- a/backport/include/linux/compat-3.9.h
+++ b/backport/include/linux/compat-3.9.h
@@ -15,6 +15,7 @@
 #include <linux/tty_flip.h>
 #include <linux/printk.h>
 #include <linux/scatterlist.h>
+#include <linux/device.h>
 
 /* include this before changing hlist_for_each_* to use the old versions. */
 #include <net/sch_generic.h>
@@ -207,6 +208,9 @@ static inline struct inode *file_inode(struct file *f)
 	return f->f_path.dentry->d_inode;
 }
 
+#define devm_ioremap_resource LINUX_BACKPORT(devm_ioremap_resource)
+void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)) */
 
 #endif /* LINUX_3_9_COMPAT_H */
-- 
1.7.10.4

