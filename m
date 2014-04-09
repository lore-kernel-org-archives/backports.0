Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56258 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235AbaDIBTN (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 8 Apr 2014 21:19:13 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so1791281pbb.5
        for <backports@vger.kernel.org>; Tue, 08 Apr 2014 18:19:13 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Viresh Kumar <viresh.kumar@st.com>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] backports: backport 3.6 fix on non CONFIG_COMMON_CLK kernels
Date: Tue,  8 Apr 2014 18:19:07 -0700
Message-Id: <1397006347-7822-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20140409_031916_049628_FBEE78CC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit 93abe8e4 by Viresh added non CONFIG_COMMON_CLK static inlines
that should have gone in for 3.5 as 3.5 assumed some declared routines
would be exproted by the architecture, which was not true. We backport
only the non CONFIG_COMMON_CLK case as CONFIG_COMMON_CLK requires
core kernel architecture specific backport support which we currently do
not support (and perhaps shouldn't). Since 3.5 is not a supported kernel
there is no need to fix this there upstream but this then does require
a paper wrap work around for those kernels of providing an export symbol
for clk_enable() and clk_disable() for the !CONFIG_COMMON_CLK case which
older kernels failed to address.

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains 93abe8e4
v3.6-rc1~41^2~117

Cc: Viresh Kumar <viresh.kumar@st.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/clk.h | 89 +++++++++++++++++++++++++++++++++++
 backport/compat/compat-3.6.c          | 15 ++++++
 2 files changed, 104 insertions(+)
 create mode 100644 backport/backport-include/linux/clk.h

diff --git a/backport/backport-include/linux/clk.h b/backport/backport-include/linux/clk.h
new file mode 100644
index 0000000..a619b66
--- /dev/null
+++ b/backport/backport-include/linux/clk.h
@@ -0,0 +1,89 @@
+#ifndef __BACKPORT_LINUX_CLK_H
+#define __BACKPORT_LINUX_CLK_H
+#include_next <linux/clk.h>
+#include <linux/version.h>
+
+/*
+ * commit 93abe8e4 - we only backport the non CONFIG_COMMON_CLK
+ * case as the CONFIG_COMMON_CLK case requires arch support. By
+ * using the backport_ namespace for older kernels we force usage
+ * of these helpers and that's required given that 3.5 added some
+ * of these helpers expecting a few exported symbols for the non
+ * CONFIG_COMMON_CLK case. The 3.5 kernel is not supported as
+ * per kernel.org so we don't send a fix upstream for that.
+ */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+
+#ifndef CONFIG_COMMON_CLK
+
+/*
+ * Whoopsie!
+ *
+ * clk_enable() and clk_disable() have been left without
+ * a nop export symbols when !CONFIG_COMMON_CLK since its
+ * introduction on v2.6.16, but fixed until 3.6.
+ */
+#if 0
+#define clk_enable LINUX_BACKPORT(clk_enable)
+static inline int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+
+#define clk_disable LINUX_BACKPORT(clk_disable)
+static inline void clk_disable(struct clk *clk) {}
+#endif
+
+
+#define clk_get LINUX_BACKPORT(clk_get)
+static inline struct clk *clk_get(struct device *dev, const char *id)
+{
+	return NULL;
+}
+
+#define devm_clk_get LINUX_BACKPORT(devm_clk_get)
+static inline struct clk *devm_clk_get(struct device *dev, const char *id)
+{
+	return NULL;
+}
+
+#define clk_put LINUX_BACKPORT(clk_put)
+static inline void clk_put(struct clk *clk) {}
+
+#define devm_clk_put LINUX_BACKPORT(devm_clk_put)
+static inline void devm_clk_put(struct device *dev, struct clk *clk) {}
+
+#define clk_get_rate LINUX_BACKPORT(clk_get_rate)
+static inline unsigned long clk_get_rate(struct clk *clk)
+{
+	return 0;
+}
+
+#define clk_set_rate LINUX_BACKPORT(clk_set_rate)
+static inline int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	return 0;
+}
+
+#define clk_round_rate LINUX_BACKPORT(clk_round_rate)
+static inline long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	return 0;
+}
+
+#define clk_set_parent LINUX_BACKPORT(clk_set_parent)
+static inline int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	return 0;
+}
+
+#define clk_get_parent LINUX_BACKPORT(clk_get_parent)
+static inline struct clk *clk_get_parent(struct clk *clk)
+{
+	return NULL;
+}
+#endif /* CONFIG_COMMON_CLK */
+
+#endif /* #if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0) */
+
+#endif /* __LINUX_CLK_H */
diff --git a/backport/compat/compat-3.6.c b/backport/compat/compat-3.6.c
index 53991ee..c82bfb8 100644
--- a/backport/compat/compat-3.6.c
+++ b/backport/compat/compat-3.6.c
@@ -14,6 +14,7 @@
 #include <linux/bug.h>
 #include <linux/bitmap.h>
 #include <linux/i2c.h>
+#include <linux/clk.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 /**
@@ -146,3 +147,17 @@ int sg_alloc_table_from_pages(struct sg_table *sgt,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sg_alloc_table_from_pages);
+
+/* whoopsie ! */
+#ifndef CONFIG_COMMON_CLK
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL_GPL(clk_disable);
+#endif
-- 
1.8.5.3

