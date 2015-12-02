Return-path: <backports-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63249 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757376AbbLBLtP (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 2 Dec 2015 06:49:15 -0500
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 2/2] backport: add skb_ensure_writable
Date: Wed,  2 Dec 2015 13:49:10 +0200
Message-Id: <1449056950-25054-2-git-send-email-emmanuel.grumbach@intel.com> (sfid-20151202_124916_580404_5B8E7029)
In-Reply-To: <1449056950-25054-1-git-send-email-emmanuel.grumbach@intel.com>
References: <1449056950-25054-1-git-send-email-emmanuel.grumbach@intel.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added to skbuff.c in 3.19. Backport it for older
kernels.
iwlwifi will need this soon.

Change-Id: Iac6023527cdd1643dc5855406019e071843a65f0
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 backport/backport-include/linux/skbuff.h |  4 ++++
 backport/compat/backport-3.19.c          | 12 ++++++++++++
 2 files changed, 16 insertions(+)

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
index 8a241b7..258489b 100644
--- a/backport/compat/backport-3.19.c
+++ b/backport/compat/backport-3.19.c
@@ -147,4 +147,16 @@ struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_devm_seqfile);
 
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
+EXPORT_SYMBOL(skb_ensure_writable);
+
 #endif /* CONFIG_DEBUG_FS */
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
