Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37435 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbbLFNSf (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 6 Dec 2015 08:18:35 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/12] backport: add skb_ensure_writable
Date: Sun,  6 Dec 2015 14:18:18 +0100
Message-Id: <1449407908-15547-3-git-send-email-hauke@hauke-m.de> (sfid-20151206_141838_943042_08EBC962)
In-Reply-To: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
References: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This was added to skbuff.c in 3.19. Backport it for older
kernels.
iwlwifi will need this soon.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
[move skb_ensure_writable out of CONFIG_DEBUG_FS, use EXPORT_SYMBOL_GPL(), include linux/skbuff.h]
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h |  4 ++++
 backport/compat/backport-3.19.c          | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index a21e6cc..888d2a0 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -294,6 +294,10 @@ static inline int skb_put_padto(struct sk_buff *skb, unsigned int len)
 	}
 	return 0;
 }
+
+#define skb_ensure_writable LINUX_BACKPORT(skb_ensure_writable)
+int skb_ensure_writable(struct sk_buff *skb, int write_len);
+
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
 
 #endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/compat/backport-3.19.c b/backport/compat/backport-3.19.c
index 8a241b7..3ad25bb 100644
--- a/backport/compat/backport-3.19.c
+++ b/backport/compat/backport-3.19.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/net.h>
 #include <linux/netdevice.h>
+#include <linux/skbuff.h>
 #include <linux/debugfs.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,12)
@@ -148,3 +149,15 @@ struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
 EXPORT_SYMBOL_GPL(debugfs_create_devm_seqfile);
 
 #endif /* CONFIG_DEBUG_FS */
+
+int skb_ensure_writable(struct sk_buff *skb, int write_len)
+{
+	if (!pskb_may_pull(skb, write_len))
+		return -ENOMEM;
+
+	if (!skb_cloned(skb) || skb_clone_writable(skb, write_len))
+		return 0;
+
+	return pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
+}
+EXPORT_SYMBOL_GPL(skb_ensure_writable);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
