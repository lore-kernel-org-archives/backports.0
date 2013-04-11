Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37192 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3DKXnB (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:01 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 07/24] backports: move skb_add_rx_frag
Date: Fri, 12 Apr 2013 01:42:34 +0200
Message-Id: <1365723771-10660-8-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014307_219704_E7A8030A)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-2.6.28.h |  3 ---
 backport/backport-include/linux/compat-3.4.h    |  8 --------
 backport/backport-include/linux/skbuff.h        | 16 ++++++++++++++++
 3 files changed, 16 insertions(+), 11 deletions(-)
 create mode 100644 backport/backport-include/linux/skbuff.h

diff --git a/backport/backport-include/linux/compat-2.6.28.h b/backport/backport-include/linux/compat-2.6.28.h
index 3b5f3ea..60f56f4 100644
--- a/backport/backport-include/linux/compat-2.6.28.h
+++ b/backport/backport-include/linux/compat-2.6.28.h
@@ -276,9 +276,6 @@ static inline void skb_queue_splice_tail(const struct sk_buff_head *list,
 #define round_jiffies_up LINUX_BACKPORT(round_jiffies_up)
 unsigned long round_jiffies_up(unsigned long j);
 
-extern void v2_6_28_skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page,
-			    int off, int size);
-
 #define wake_up_interruptible_poll(x, m)			\
 	__wake_up(x, TASK_INTERRUPTIBLE, 1, (void *) (m))
 
diff --git a/backport/backport-include/linux/compat-3.4.h b/backport/backport-include/linux/compat-3.4.h
index 45aef72..fafec0c 100644
--- a/backport/backport-include/linux/compat-3.4.h
+++ b/backport/backport-include/linux/compat-3.4.h
@@ -102,14 +102,6 @@ static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
 extern const struct i2c_algorithm i2c_bit_algo;
 #endif
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28))
-#define skb_add_rx_frag(skb, i, page, off, size, truesize) \
-	v2_6_28_skb_add_rx_frag(skb, i, page, off, size)
-#else
-#define skb_add_rx_frag(skb, i, page, off, size, truesize) \
-	skb_add_rx_frag(skb, i, page, off, size)
-#endif
-
 #ifdef CONFIG_X86_X32_ABI
 #define COMPAT_USE_64BIT_TIME \
 	(!!(task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT))
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
new file mode 100644
index 0000000..0c09f9b
--- /dev/null
+++ b/backport/backport-include/linux/skbuff.h
@@ -0,0 +1,16 @@
+#ifndef __BACKPORT_SKBUFF_H
+#define __BACKPORT_SKBUFF_H
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28))
+extern void v2_6_28_skb_add_rx_frag(struct sk_buff *skb, int i,
+				    struct page *page,
+				    int off, int size);
+
+#define skb_add_rx_frag(skb, i, page, off, size, truesize) \
+	v2_6_28_skb_add_rx_frag(skb, i, page, off, size)
+#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+#define skb_add_rx_frag(skb, i, page, off, size, truesize) \
+	skb_add_rx_frag(skb, i, page, off, size)
+#endif
+
+#endif /* __BACKPORT_SKBUFF_H */
-- 
1.8.0

