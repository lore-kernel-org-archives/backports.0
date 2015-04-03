Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39196 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbbDCRY2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 13:24:28 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/11] compat: wait_on_bit_timeout() function
Date: Fri,  3 Apr 2015 19:15:34 +0200
Message-Id: <1428081342-5933-4-git-send-email-hauke@hauke-m.de> (sfid-20150403_193417_407469_195B0F29)
In-Reply-To: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
References: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Some bluetooth code makes use of wait_on_bit_timeout() now. This
function was introduced in commit 44fc0e5. It was only possible to
backport this to kernel >= 3.17. This function makes use of a new
member in struct wait_bit_key which was added with kernel 3.17.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/wait.h | 44 ++++++++++++++++++++++++++++++++++
 backport/compat/backport-3.18.c        | 27 +++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
index 4057ff1..86ad2b0 100644
--- a/backport/backport-include/linux/wait.h
+++ b/backport/backport-include/linux/wait.h
@@ -32,4 +32,48 @@ long wait_woken(wait_queue_t *wait, unsigned mode, long timeout);
 int woken_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
 #endif
 
+/**
+ * For wait_on_bit_timeout() an extra member in struct wait_bit_key is needed.
+ * This was introuced in kernel 3.17 and we are only able to backport this
+ * function on these kernel versions.
+ */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
+#define out_of_line_wait_on_bit_timeout LINUX_BACKPORT(out_of_line_wait_on_bit_timeout)
+int out_of_line_wait_on_bit_timeout(void *, int, wait_bit_action_f *, unsigned, unsigned long);
+
+#define bit_wait_timeout LINUX_BACKPORT(bit_wait_timeout)
+extern int bit_wait_timeout(struct wait_bit_key *);
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,20,0)
+#define wait_on_bit_timeout LINUX_BACKPORT(wait_on_bit_timeout)
+/**
+ * wait_on_bit_timeout - wait for a bit to be cleared or a timeout elapses
+ * @word: the word being waited on, a kernel virtual address
+ * @bit: the bit of the word being waited on
+ * @mode: the task state to sleep in
+ * @timeout: timeout, in jiffies
+ *
+ * Use the standard hashed waitqueue table to wait for a bit
+ * to be cleared. This is similar to wait_on_bit(), except also takes a
+ * timeout parameter.
+ *
+ * Returned value will be zero if the bit was cleared before the
+ * @timeout elapsed, or non-zero if the @timeout elapsed or process
+ * received a signal and the mode permitted wakeup on that signal.
+ */
+static inline int
+wait_on_bit_timeout(void *word, int bit, unsigned mode, unsigned long timeout)
+{
+	might_sleep();
+	if (!test_bit(bit, word))
+		return 0;
+	return out_of_line_wait_on_bit_timeout(word, bit,
+					       bit_wait_timeout,
+					       mode, timeout);
+}
+#endif
+#endif
+
 #endif /* __BACKPORT_LINUX_WAIT_H */
diff --git a/backport/compat/backport-3.18.c b/backport/compat/backport-3.18.c
index b3c3f21..9e1a026 100644
--- a/backport/compat/backport-3.18.c
+++ b/backport/compat/backport-3.18.c
@@ -14,6 +14,7 @@
 #include <scsi/fc/fc_fcoe.h>
 #include <linux/skbuff.h>
 #include <linux/errqueue.h>
+#include <linux/wait.h>
 
 /**
  * eth_get_headlen - determine the the length of header for an ethernet frame
@@ -194,3 +195,29 @@ void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
 }
 EXPORT_SYMBOL_GPL(skb_complete_wifi_ack);
 #endif
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+int __sched out_of_line_wait_on_bit_timeout(
+	void *word, int bit, wait_bit_action_f *action,
+	unsigned mode, unsigned long timeout)
+{
+	wait_queue_head_t *wq = bit_waitqueue(word, bit);
+	DEFINE_WAIT_BIT(wait, word, bit);
+
+	wait.key.private = jiffies + timeout;
+	return __wait_on_bit(wq, &wait, action, mode);
+}
+EXPORT_SYMBOL_GPL(out_of_line_wait_on_bit_timeout);
+
+__sched int bit_wait_timeout(struct wait_bit_key *word)
+{
+	unsigned long now = ACCESS_ONCE(jiffies);
+	if (signal_pending_state(current->state, current))
+		return 1;
+	if (time_after_eq(now, word->private))
+		return -EAGAIN;
+	schedule_timeout(word->private - now);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bit_wait_timeout);
+#endif
-- 
1.9.1

