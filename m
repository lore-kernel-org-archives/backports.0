Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46729 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274AbaAHAfa (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:35:30 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/17] backports: add printk_ratelimited()
Date: Wed,  8 Jan 2014 01:34:29 +0100
Message-Id: <1389141274-2002-13-git-send-email-hauke@hauke-m.de> (sfid-20140108_013531_742785_8206BB37)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds the backport for some printk_ratelimited() functions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/printk.h |   91 ++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/backport/backport-include/linux/printk.h b/backport/backport-include/linux/printk.h
index 6bc9931..ff7140b 100644
--- a/backport/backport-include/linux/printk.h
+++ b/backport/backport-include/linux/printk.h
@@ -97,6 +97,97 @@ static inline __attribute__ ((format (printf, 1, 2)))
 int no_printk(const char *s, ...) { return 0; }
 #endif
 
+#ifndef printk_ratelimited
+/*
+ * ratelimited messages with local ratelimit_state,
+ * no local ratelimit_state used in the !PRINTK case
+ */
+#ifdef CONFIG_PRINTK
+#define printk_ratelimited(fmt, ...)					\
+({									\
+	static DEFINE_RATELIMIT_STATE(_rs,				\
+				      DEFAULT_RATELIMIT_INTERVAL,	\
+				      DEFAULT_RATELIMIT_BURST);		\
+									\
+	if (__ratelimit(&_rs))						\
+		printk(fmt, ##__VA_ARGS__);				\
+})
+#else
+#define printk_ratelimited(fmt, ...)					\
+	no_printk(fmt, ##__VA_ARGS__)
+#endif
+#endif /* printk_ratelimited */
+
+#ifndef pr_emerg_ratelimited
+#define pr_emerg_ratelimited(fmt, ...)					\
+	printk_ratelimited(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
+#endif /* pr_emerg_ratelimited */
+
+#ifndef pr_alert_ratelimited
+#define pr_alert_ratelimited(fmt, ...)					\
+	printk_ratelimited(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
+#endif /* pr_alert_ratelimited */
+
+#ifndef pr_crit_ratelimited
+#define pr_crit_ratelimited(fmt, ...)					\
+	printk_ratelimited(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
+#endif /* pr_crit_ratelimited */
+
+#ifndef pr_err_ratelimited
+#define pr_err_ratelimited(fmt, ...)					\
+	printk_ratelimited(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
+#endif /* pr_err_ratelimited */
+
+#ifndef pr_warn_ratelimited
+#define pr_warn_ratelimited(fmt, ...)					\
+	printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
+#endif /* pr_warn_ratelimited */
+
+#ifndef pr_notice_ratelimited
+#define pr_notice_ratelimited(fmt, ...)					\
+	printk_ratelimited(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
+#endif /* pr_notice_ratelimited */
+
+#ifndef pr_info_ratelimited
+#define pr_info_ratelimited(fmt, ...)					\
+	printk_ratelimited(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
+#endif /* pr_info_ratelimited */
+
+/* no pr_cont_ratelimited, don't do that... */
+
+#ifndef pr_devel_ratelimited
+#if defined(DEBUG)
+#define pr_devel_ratelimited(fmt, ...)					\
+	printk_ratelimited(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#else
+#define pr_devel_ratelimited(fmt, ...)					\
+	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#endif
+#endif /* pr_devel_ratelimited */
+
+#ifndef pr_debug_ratelimited
+/* If you are writing a driver, please use dev_dbg instead */
+#if defined(CONFIG_DYNAMIC_DEBUG)
+/* descriptor check is first to prevent flooding with "callbacks suppressed" */
+#define pr_debug_ratelimited(fmt, ...)					\
+do {									\
+	static DEFINE_RATELIMIT_STATE(_rs,				\
+				      DEFAULT_RATELIMIT_INTERVAL,	\
+				      DEFAULT_RATELIMIT_BURST);		\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
+	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
+	    __ratelimit(&_rs))						\
+		__dynamic_pr_debug(&descriptor, fmt, ##__VA_ARGS__);	\
+} while (0)
+#elif defined(DEBUG)
+#define pr_debug_ratelimited(fmt, ...)					\
+	printk_ratelimited(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#else
+#define pr_debug_ratelimited(fmt, ...) \
+	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#endif
+#endif /* pr_debug_ratelimited */
+
 #endif	/* _COMPAT_LINUX_PRINTK_H */
 
 /* This must be outside -- see also kernel.h */
-- 
1.7.10.4

