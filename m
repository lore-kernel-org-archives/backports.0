Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:50099 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbbDZVEc (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 26 Apr 2015 17:04:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/7] header: add clk_prepare_enable() and clk_disable_unprepare()
Date: Sun, 26 Apr 2015 23:04:20 +0200
Message-Id: <1430082264-11808-4-git-send-email-hauke@hauke-m.de> (sfid-20150426_230437_027277_6E886D3B)
In-Reply-To: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
References: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These functions are used by some media drivers since 4f528afc.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/clk.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/backport/backport-include/linux/clk.h b/backport/backport-include/linux/clk.h
index a619b66..c5c4570 100644
--- a/backport/backport-include/linux/clk.h
+++ b/backport/backport-include/linux/clk.h
@@ -86,4 +86,31 @@ static inline struct clk *clk_get_parent(struct clk *clk)
 
 #endif /* #if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+#define clk_prepare_enable LINUX_BACKPORT(clk_prepare_enable)
+/* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
+static inline int clk_prepare_enable(struct clk *clk)
+{
+	int ret;
+
+	ret = clk_prepare(clk);
+	if (ret)
+		return ret;
+	ret = clk_enable(clk);
+	if (ret)
+		clk_unprepare(clk);
+
+	return ret;
+}
+
+#define clk_disable_unprepare LINUX_BACKPORT(clk_disable_unprepare)
+/* clk_disable_unprepare helps cases using clk_disable in non-atomic context. */
+static inline void clk_disable_unprepare(struct clk *clk)
+{
+	clk_disable(clk);
+	clk_unprepare(clk);
+}
+#endif /* < 3,3,0 && >= 3,2,0 */
+
 #endif /* __LINUX_CLK_H */
-- 
1.9.1

