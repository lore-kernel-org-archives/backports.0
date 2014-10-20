Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58024 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbaJTVeR (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 20 Oct 2014 17:34:17 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] backports: add skb_clone_sk()
Date: Mon, 20 Oct 2014 23:33:45 +0200
Message-Id: <1413840827-9142-4-git-send-email-hauke@hauke-m.de> (sfid-20141020_233420_934663_848D01CA)
In-Reply-To: <1413840827-9142-1-git-send-email-hauke@hauke-m.de>
References: <1413840827-9142-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

skb_clone_sk() is now used by mac80211 and this change also needs some
changes to skb_complete_wifi_ack(), so I replaced it with our own
version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 10 +++++
 backport/compat/backport-3.18.c          | 73 ++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 4b4ca50..5a1725d 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -15,12 +15,17 @@
 #define __pskb_copy LINUX_BACKPORT(__pskb_copy)
 extern struct sk_buff *__pskb_copy(struct sk_buff *skb,
 				   int headroom, gfp_t gfp_mask);
+#endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
 #define skb_complete_wifi_ack LINUX_BACKPORT(skb_complete_wifi_ack)
 static inline void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
 {
 	WARN_ON(1);
 }
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
+#define skb_complete_wifi_ack LINUX_BACKPORT(skb_complete_wifi_ack)
+void skb_complete_wifi_ack(struct sk_buff *skb, bool acked);
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
@@ -386,4 +391,9 @@ static inline struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb,
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
+#define skb_clone_sk LINUX_BACKPORT(skb_clone_sk)
+struct sk_buff *skb_clone_sk(struct sk_buff *skb);
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/compat/backport-3.18.c b/backport/compat/backport-3.18.c
index 8352fe0..b3c3f21 100644
--- a/backport/compat/backport-3.18.c
+++ b/backport/compat/backport-3.18.c
@@ -12,6 +12,8 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <scsi/fc/fc_fcoe.h>
+#include <linux/skbuff.h>
+#include <linux/errqueue.h>
 
 /**
  * eth_get_headlen - determine the the length of header for an ethernet frame
@@ -121,3 +123,74 @@ int eth_get_headlen(unsigned char *data, unsigned int max_len)
 		return max_len;
 }
 EXPORT_SYMBOL_GPL(eth_get_headlen);
+
+#define sock_efree LINUX_BACKPORT(sock_efree)
+static void sock_efree(struct sk_buff *skb)
+{
+	sock_put(skb->sk);
+}
+
+/**
+ * skb_clone_sk - create clone of skb, and take reference to socket
+ * @skb: the skb to clone
+ *
+ * This function creates a clone of a buffer that holds a reference on
+ * sk_refcnt.  Buffers created via this function are meant to be
+ * returned using sock_queue_err_skb, or free via kfree_skb.
+ *
+ * When passing buffers allocated with this function to sock_queue_err_skb
+ * it is necessary to wrap the call with sock_hold/sock_put in order to
+ * prevent the socket from being released prior to being enqueued on
+ * the sk_error_queue.
+ */
+struct sk_buff *skb_clone_sk(struct sk_buff *skb)
+{
+	struct sock *sk = skb->sk;
+	struct sk_buff *clone;
+
+	if (!sk || !atomic_inc_not_zero(&sk->sk_refcnt))
+		return NULL;
+
+	clone = skb_clone(skb, GFP_ATOMIC);
+	if (!clone) {
+		sock_put(sk);
+		return NULL;
+	}
+
+	clone->sk = sk;
+	clone->destructor = sock_efree;
+
+	return clone;
+}
+EXPORT_SYMBOL_GPL(skb_clone_sk);
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+/*
+ * skb_complete_wifi_ack() needs to get backported, because the version from
+ * 3.18 added the sock_hold() and sock_put() calles missing in older versions.
+ */
+void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
+{
+	struct sock *sk = skb->sk;
+	struct sock_exterr_skb *serr;
+	int err;
+
+	skb->wifi_acked_valid = 1;
+	skb->wifi_acked = acked;
+
+	serr = SKB_EXT_ERR(skb);
+	memset(serr, 0, sizeof(*serr));
+	serr->ee.ee_errno = ENOMSG;
+	serr->ee.ee_origin = SO_EE_ORIGIN_TXSTATUS;
+
+	/* take a reference to prevent skb_orphan() from freeing the socket */
+	sock_hold(sk);
+
+	err = sock_queue_err_skb(sk, skb);
+	if (err)
+		kfree_skb(skb);
+
+	sock_put(sk);
+}
+EXPORT_SYMBOL_GPL(skb_complete_wifi_ack);
+#endif
-- 
1.9.1

