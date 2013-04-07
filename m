Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:40936 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161252Ab3DGCWl (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 6 Apr 2013 22:22:41 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so2111294dan.19
        for <backports@vger.kernel.org>; Sat, 06 Apr 2013 19:22:41 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 8/9] compat: backport devres_release()
Date: Sat,  6 Apr 2013 19:22:01 -0700
Message-Id: <1365301322-19327-8-git-send-email-mcgrof@do-not-panic.com> (sfid-20130407_042243_253570_BABFB4E7)
In-Reply-To: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

commit d926d0e4c74cfcb42a05e91d1cdf698b41e1e118
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Thu May 3 18:15:13 2012 +0100

    devres: Add devres_release()

    APIs using devres frequently want to implement a "remove and free the
    resource" operation so it seems sensible that they should be able to
    just have devres do the freeing for them since that's a big part of what
    devres is all about.

    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/compat-3.5.c        |   34 ++++++++++++++++++++++++++++++++++
 backport/include/linux/compat-3.5.h |    6 ++++++
 2 files changed, 40 insertions(+)

diff --git a/backport/compat/compat-3.5.c b/backport/compat/compat-3.5.c
index d7f1c27..9cc8456 100644
--- a/backport/compat/compat-3.5.c
+++ b/backport/compat/compat-3.5.c
@@ -12,6 +12,40 @@
 #include <linux/highuid.h>
 #include <linux/ktime.h>
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#include <linux/device.h>
+
+/**
+ * devres_release - Find a device resource and destroy it, calling release
+ * @dev: Device to find resource from
+ * @release: Look for resources associated with this release function
+ * @match: Match function (optional)
+ * @match_data: Data for the match function
+ *
+ * Find the latest devres of @dev associated with @release and for
+ * which @match returns 1.  If @match is NULL, it's considered to
+ * match all.  If found, the resource is removed atomically, the
+ * release function called and the resource freed.
+ *
+ * RETURNS:
+ * 0 if devres is found and freed, -ENOENT if not found.
+ */
+int devres_release(struct device *dev, dr_release_t release,
+		   dr_match_t match, void *match_data)
+{
+	void *res;
+
+	res = devres_remove(dev, release, match, match_data);
+	if (unlikely(!res))
+		return -ENOENT;
+
+	(*release)(dev, res);
+	devres_free(res);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devres_release);
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
+
 /*
  * Commit 7a4e7408c5cadb240e068a662251754a562355e3
  * exported overflowuid and overflowgid for all
diff --git a/backport/include/linux/compat-3.5.h b/backport/include/linux/compat-3.5.h
index 7e1d9b3..70ba227 100644
--- a/backport/include/linux/compat-3.5.h
+++ b/backport/include/linux/compat-3.5.h
@@ -10,6 +10,12 @@
 
 #include <net/netlink.h>
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#define devres_release LINUX_BACKPORT(devres_release)
+extern int devres_release(struct device *dev, dr_release_t release,
+			  dr_match_t match, void *match_data);
+#endif
+
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
 #include <linux/ratelimit.h>
 #define dev_level_ratelimited(dev_level, dev, fmt, ...)			\
-- 
1.7.10.4

