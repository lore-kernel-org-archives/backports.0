Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/23] compat: backport nla_put_be{16,32,64}()
Date: Tue, 26 Feb 2013 21:58:58 +0100
Message-Id: <1361912354-29498-8-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

I intend to use these in nl80211.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.5.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/compat-3.5.h b/include/linux/compat-3.5.h
index 9cffead..28a1209 100644
--- a/include/linux/compat-3.5.h
+++ b/include/linux/compat-3.5.h
@@ -8,6 +8,32 @@
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0))
 
+#include <net/netlink.h>
+
+/*
+ * This backports:
+ * commit 569a8fc38367dfafd87454f27ac646c8e6b54bca
+ * Author: David S. Miller <davem@davemloft.net>
+ * Date:   Thu Mar 29 23:18:53 2012 -0400
+ *
+ *     netlink: Add nla_put_be{16,32,64}() helpers.
+ */
+
+static inline int nla_put_be16(struct sk_buff *skb, int attrtype, __be16 value)
+{
+	return nla_put(skb, attrtype, sizeof(__be16), &value);
+}
+
+static inline int nla_put_be32(struct sk_buff *skb, int attrtype, __be32 value)
+{
+	return nla_put(skb, attrtype, sizeof(__be32), &value);
+}
+
+static inline int nla_put_be64(struct sk_buff *skb, int attrtype, __be64 value)
+{
+	return nla_put(skb, attrtype, sizeof(__be64), &value);
+}
+
 /*
  * This backports:
  *
-- 
1.7.10.4
