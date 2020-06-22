Return-Path: <SRS0=/q2A=AD=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A51C433E2
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17E02075A
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgFVVia (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgFVVia (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 22 Jun 2020 17:38:30 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEA0C061796
        for <backports@vger.kernel.org>; Mon, 22 Jun 2020 14:38:29 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 49rN7m34LmzKmVB;
        Mon, 22 Jun 2020 23:38:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id Kh_oo0IrcqEw; Mon, 22 Jun 2020 23:38:25 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/7] backports: Add read_poll_timeout{_atomic}()
Date:   Mon, 22 Jun 2020 23:38:00 +0200
Message-Id: <20200622213804.26477-4-hauke@hauke-m.de>
In-Reply-To: <20200622213804.26477-1-hauke@hauke-m.de>
References: <20200622213804.26477-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -4.02 / 15.00 / 15.00
X-Rspamd-Queue-Id: 869E917FB
X-Rspamd-UID: 58fd19
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

These defines are used by the rtw88 driver.

These defines are copied from Linux commit 5f5323a14cad ("iopoll:
introduce read_poll_timeout macro") and 57a29df34146 ("iopoll: Introduce
read_poll_timeout_atomic macro")

linux/iopoll.h was only added in kernel 4.20, do not include the
original file in older versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/iopoll.h | 98 ++++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 backport/backport-include/linux/iopoll.h

diff --git a/backport/backport-include/linux/iopoll.h b/backport/backport-include/linux/iopoll.h
new file mode 100644
index 00000000..f50187ad
--- /dev/null
+++ b/backport/backport-include/linux/iopoll.h
@@ -0,0 +1,98 @@
+#ifndef _BACKPORTS_LINUX_IOPOLL_H
+#define _BACKPORTS_LINUX_IOPOLL_H 1
+
+#if LINUX_VERSION_IS_GEQ(4,0,0)
+#include_next <linux/iopoll.h>
+#endif
+
+#ifndef read_poll_timeout
+/**
+ * read_poll_timeout - Periodically poll an address until a condition is
+ *			met or a timeout occurs
+ * @op: accessor function (takes @args as its arguments)
+ * @val: Variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @sleep_us: Maximum time to sleep between reads in us (0
+ *            tight-loops).  Should be less than ~20ms since usleep_range
+ *            is used (see Documentation/timers/timers-howto.rst).
+ * @timeout_us: Timeout in us, 0 means never timeout
+ * @sleep_before_read: if it is true, sleep @sleep_us before read.
+ * @args: arguments for @op poll
+ *
+ * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @args is stored in @val. Must not
+ * be called from atomic context if sleep_us or timeout_us are used.
+ *
+ * When available, you'll probably want to use one of the specialized
+ * macros defined below rather than this macro directly.
+ */
+#define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
+				sleep_before_read, args...) \
+({ \
+	u64 __timeout_us = (timeout_us); \
+	unsigned long __sleep_us = (sleep_us); \
+	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
+	might_sleep_if((__sleep_us) != 0); \
+	if (sleep_before_read && __sleep_us) \
+		usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
+	for (;;) { \
+		(val) = op(args); \
+		if (cond) \
+			break; \
+		if (__timeout_us && \
+		    ktime_compare(ktime_get(), __timeout) > 0) { \
+			(val) = op(args); \
+			break; \
+		} \
+		if (__sleep_us) \
+			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
+	} \
+	(cond) ? 0 : -ETIMEDOUT; \
+})
+#endif /* read_poll_timeout */
+
+#ifndef read_poll_timeout_atomic
+/**
+ * read_poll_timeout_atomic - Periodically poll an address until a condition is
+ * 				met or a timeout occurs
+ * @op: accessor function (takes @addr as its only argument)
+ * @addr: Address to poll
+ * @val: Variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @delay_us: Time to udelay between reads in us (0 tight-loops).  Should
+ *            be less than ~10us since udelay is used (see
+ *            Documentation/timers/timers-howto.rst).
+ * @timeout_us: Timeout in us, 0 means never timeout
+ * @delay_before_read: if it is true, delay @delay_us before read.
+ *
+ * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @args is stored in @val.
+ *
+ * When available, you'll probably want to use one of the specialized
+ * macros defined below rather than this macro directly.
+ */
+#define read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, \
+					delay_before_read, args...) \
+({ \
+	u64 __timeout_us = (timeout_us); \
+	unsigned long __delay_us = (delay_us); \
+	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
+	if (delay_before_read && __delay_us) \
+		udelay(__delay_us); \
+	for (;;) { \
+		(val) = op(args); \
+		if (cond) \
+			break; \
+		if (__timeout_us && \
+		    ktime_compare(ktime_get(), __timeout) > 0) { \
+			(val) = op(args); \
+			break; \
+		} \
+		if (__delay_us) \
+			udelay(__delay_us); \
+	} \
+	(cond) ? 0 : -ETIMEDOUT; \
+})
+#endif /* read_poll_timeout_atomic */
+
+#endif /* _BACKPORTS_LINUX_IOPOLL_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
