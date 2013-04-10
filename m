Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:35704 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933890Ab3DJLfo (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:35:44 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so219308pbc.2
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:35:43 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 02/18] compat: backport dev_level_ratelimited()
Date: Wed, 10 Apr 2013 04:35:12 -0700
Message-Id: <1365593728-5720-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133546_102012_1985325B)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains 6ca04593
v3.5-rc1~147^2~7

This is only enabled for kernels where ratelimit.h was added.

commit 6ca045930338485a8cdef117e74372aa1678009d
Author: Hiroshi DOYU <hdoyu@nvidia.com>
Date:   Mon May 14 10:47:57 2012 +0300

    driver core: Add dev_*_ratelimited() family

    Add dev_*_ratelimited() family, dev_* version of pr_*_ratelimited().

    Using Joe Perches's proposal/implementation.

    Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
    Cc: Joe Perches <joe@perches.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/include/linux/compat-3.5.h |   36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/backport/include/linux/compat-3.5.h b/backport/include/linux/compat-3.5.h
index 7e9e65a..dbf8f00 100644
--- a/backport/include/linux/compat-3.5.h
+++ b/backport/include/linux/compat-3.5.h
@@ -10,6 +10,42 @@
 
 #include <net/netlink.h>
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
+#include <linux/ratelimit.h>
+#define dev_level_ratelimited(dev_level, dev, fmt, ...)			\
+do {									\
+	static DEFINE_RATELIMIT_STATE(_rs,				\
+				      DEFAULT_RATELIMIT_INTERVAL,	\
+				      DEFAULT_RATELIMIT_BURST);		\
+	if (__ratelimit(&_rs))						\
+		dev_level(dev, fmt, ##__VA_ARGS__);			\
+} while (0)
+
+#define dev_emerg_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_emerg, dev, fmt, ##__VA_ARGS__)
+#define dev_alert_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_alert, dev, fmt, ##__VA_ARGS__)
+
+
+#if defined(CONFIG_DYNAMIC_DEBUG) || defined(DEBUG)
+#define dev_dbg_ratelimited(dev, fmt, ...)				\
+do {									\
+	static DEFINE_RATELIMIT_STATE(_rs,				\
+				      DEFAULT_RATELIMIT_INTERVAL,	\
+				      DEFAULT_RATELIMIT_BURST);		\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
+	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
+	    __ratelimit(&_rs))						\
+		__dynamic_pr_debug(&descriptor, pr_fmt(fmt),		\
+				   ##__VA_ARGS__);			\
+} while (0)
+#else
+#define dev_dbg_ratelimited(dev, fmt, ...)			\
+	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#endif
+
+#endif
+
 /*
  * This backports:
  * commit 569a8fc38367dfafd87454f27ac646c8e6b54bca
-- 
1.7.10.4

