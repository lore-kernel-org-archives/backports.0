Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11801C64E7A
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AACDB2085B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="CYEjxNuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgLAWFm (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgLAWFl (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:41 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89165C061A52
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:44 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Clx3H1XLxzQlMH;
        Tue,  1 Dec 2020 23:04:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oiDHJp1rCKSSt0RpcR3g+8AYQKKUFKwuNyabBpHdOh4=;
        b=CYEjxNuk9oPp17uTQoxhKTVeCWyyRSWaxnxHkzAX8+D2BHwXsDnxhP8VML5w2w2APrm7Ki
        R/NaYoprNs7KZbnNKZ+QM2ZkzSSpGNkQCaThHx2avYvMtbZhOtPGGWY6upRtwq4bckU0sF
        twPI0/an4LLowx+FwwxLV6wufNM/Jn9xZQ2viKAxbQeLDlmPCYmK/IE6jqsQ/gm3hkBvbK
        D0973q4iszLabfMjS7xHpUY2KCOA8iAYW1OZW0jqzI9z8ChPt+78RjLpKUI+YkHVJlsdVM
        4lzV3Rler/KBaWtCyAQ7YKTrNDCsuR26pHd3nL/LKnvHv8WbheQp5ztvDon9TA==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id dGXT2VeIjpn2; Tue,  1 Dec 2020 23:04:40 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 26/30] backports: Add netif_rx_any_context()
Date:   Tue,  1 Dec 2020 23:04:11 +0100
Message-Id: <20201201220415.30582-27-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: 617D81847
X-Rspamd-UID: 1a7520
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add the netif_rx_any_context which was added in commit c11171a41338
("net: Add netif_rx_any_context()") in kernel 5.10. This is used by
libertas and mwifiex.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h |  5 +++++
 backport/compat/Makefile                    |  1 +
 backport/compat/backport-5.10.c             | 20 ++++++++++++++++++++
 3 files changed, 26 insertions(+)
 create mode 100644 backport/compat/backport-5.10.c

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 7646d6e2..411757d2 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -400,4 +400,9 @@ static inline bool netif_is_bridge_port(const struct net_device *dev)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,10,0)
+#define netif_rx_any_context LINUX_BACKPORT(netif_rx_any_context)
+int netif_rx_any_context(struct sk_buff *skb);
+#endif /* < 5.10 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 8d917622..b67ebc27 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -40,6 +40,7 @@ compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
 compat-$(CPTCFG_KERNEL_5_2) += backport-5.2.o backport-genetlink.o
 compat-$(CPTCFG_KERNEL_5_3) += backport-5.3.o
 compat-$(CPTCFG_KERNEL_5_5) += backport-5.5.o
+compat-$(CPTCFG_KERNEL_5_10) += backport-5.10.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7.asn1.o
diff --git a/backport/compat/backport-5.10.c b/backport/compat/backport-5.10.c
new file mode 100644
index 00000000..a83907f4
--- /dev/null
+++ b/backport/compat/backport-5.10.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+
+int netif_rx_any_context(struct sk_buff *skb)
+{
+	/*
+	 * If invoked from contexts which do not invoke bottom half
+	 * processing either at return from interrupt or when softrqs are
+	 * reenabled, use netif_rx_ni() which invokes bottomhalf processing
+	 * directly.
+	 */
+	if (in_interrupt())
+		return netif_rx(skb);
+	else
+		return netif_rx_ni(skb);
+}
+EXPORT_SYMBOL(netif_rx_any_context);
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
