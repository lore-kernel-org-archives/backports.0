Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C7DC64E7B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9EE20709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="NlQYWGkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgLAWGG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730191AbgLAWGG (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:06:06 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CF7C061A54
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:45 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Clx3J2tDfzQlXQ;
        Tue,  1 Dec 2020 23:04:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kc38p/S+5X4p77N0+dUd3BTTV2FQnUvfkPzUiGcwUkY=;
        b=NlQYWGkUQW3DC2Ny+HryDrZ8ZcY7bl64F6Zar4I4PjkTPdQUE2qEesdJCh68bJGbjPV3bk
        4oumOclHI/cIrXnQ3anSm0RYp/LJHmC1bhceBRIx57dFzbpvDHlOktNb/1IvOuIXi0vjJi
        fCQUmn+MGVT7YpDHc4BHaSHEQcEsaSFtDBUSURXq/ODgzm1fHP5TEe5J1x273Emf39r0dG
        dfXWyOvoRGBHKNQKOAWwvi+lLfuvW4QbZS0kjKAPZ0qX1jYJqqR+++KRACrok4oScu896A
        AiLmZk02E7H7m6uSZabGdSfLK7Y/BZTSlecchdhFqNNjolL4MVK8noVHg32NOw==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id Z2DovRFkf_MZ; Tue,  1 Dec 2020 23:04:41 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 29/30] backports: Add sysfs_emit()
Date:   Tue,  1 Dec 2020 23:04:14 +0100
Message-Id: <20201201220415.30582-30-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: 8CF8C1832
X-Rspamd-UID: 09fb89
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add the sysfs_emit() function which was added in Linux upstream commit
2efc459d06f1 ("sysfs: Add sysfs_emit and sysfs_emit_at to format sysfs
output") and is now used by drivers-base-devcoredump.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/sysfs.h | 14 +++++++++++++
 backport/compat/backport-5.10.c         | 27 +++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/backport/backport-include/linux/sysfs.h b/backport/backport-include/linux/sysfs.h
index 0b71db54..ad8a8229 100644
--- a/backport/backport-include/linux/sysfs.h
+++ b/backport/backport-include/linux/sysfs.h
@@ -8,4 +8,18 @@
 			 _name##_show, _name##_store)
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,10,0)
+#define sysfs_emit LINUX_BACKPORT(sysfs_emit)
+#ifdef CONFIG_SYSFS
+__printf(2, 3)
+int sysfs_emit(char *buf, const char *fmt, ...);
+#else /* CONFIG_SYSFS */
+__printf(2, 3)
+static inline int sysfs_emit(char *buf, const char *fmt, ...)
+{
+	return 0;
+}
+#endif /* CONFIG_SYSFS */
+#endif /* < 5.10 */
+
 #endif /* __BACKPORT_LINUX_SYSFS_H */
diff --git a/backport/compat/backport-5.10.c b/backport/compat/backport-5.10.c
index 141862da..c3a7b7d3 100644
--- a/backport/compat/backport-5.10.c
+++ b/backport/compat/backport-5.10.c
@@ -3,6 +3,7 @@
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <linux/sysfs.h>
 
 /**
  *	dev_fetch_sw_netstats - get per-cpu network device statistics
@@ -52,3 +53,29 @@ int netif_rx_any_context(struct sk_buff *skb)
 		return netif_rx_ni(skb);
 }
 EXPORT_SYMBOL(netif_rx_any_context);
+
+/**
+ *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
+ *	@buf:	start of PAGE_SIZE buffer.
+ *	@fmt:	format
+ *	@...:	optional arguments to @format
+ *
+ *
+ * Returns number of characters written to @buf.
+ */
+int sysfs_emit(char *buf, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+
+	if (WARN(!buf || offset_in_page(buf),
+		 "invalid sysfs_emit: buf:%p\n", buf))
+		return 0;
+
+	va_start(args, fmt);
+	len = vscnprintf(buf, PAGE_SIZE, fmt, args);
+	va_end(args);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(sysfs_emit);
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
