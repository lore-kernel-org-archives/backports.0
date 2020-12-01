Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F681C64E7A
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F1320709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Z3jBg3uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgLAWF0 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbgLAWFZ (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:25 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922ECC061A47
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:36 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Clx371lCgzQlMH;
        Tue,  1 Dec 2020 23:04:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPLUzBNA+h18yV+tcQqwtCklbNQDSuPCnpenVLdke2Y=;
        b=Z3jBg3uvgYqLxIDlmjIJxAUpCZUvHzL6O0SHSr2dQLCE1YQaCHpEGnfF2rNOKf/efu1lZa
        U1BNcJaMi8f77d4oaJQ7HMa18uyznwrc93SMQww9uz00SK+laKmMfvRYKc11knU2zB6jSL
        E0dhLHLNZQEerU7JRsCsxlrYpcUxPdQ2g3i6HnK8pRxa8pxe5MmyQH+ARidNKY4BzRrfJT
        G3rDsVZqLfG+SElC3Icv+nJk9fDjTzz3CEnCHpTctRrHlKf0c2cvutNWp3hYgvDM81gjBT
        /nFJcYedHqAtH5Lv8Hl7Bv24yKkmKrT+2FKd8n6X6Jxcs50PnZ4tE6/ZsCxDxg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id xCf1j1dFtheE; Tue,  1 Dec 2020 23:04:31 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Shay Bar <shay.bar@celeno.com>
Subject: [PATCH 07/30] backports: Add time64_to_tm and ipv6_mc_check_mld
Date:   Tue,  1 Dec 2020 23:03:52 +0100
Message-Id: <20201201220415.30582-8-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: *
X-Rspamd-Score: 1.07 / 15.00 / 15.00
X-Rspamd-Queue-Id: 37C2B1832
X-Rspamd-UID: 0d5484
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Shay Bar <shay.bar@celeno.com>

ipv6_mc_check_mld() was added in kernel version 4.2.0.
The 2nd parameter was removed in kernel version 5.1.0.

time64_to_tm() was added in kernel version 4.8.0.

Signed-off-by: Shay Bar <shay.bar@celeno.com>
---
 backport/backport-include/linux/time.h   |  8 ++++++++
 backport/backport-include/net/addrconf.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/backport/backport-include/linux/time.h b/backport/backport-include/linux/time.h
index 3191047d..ce8a1b03 100644
--- a/backport/backport-include/linux/time.h
+++ b/backport/backport-include/linux/time.h
@@ -4,4 +4,12 @@
 
 #include <linux/time64.h>
 
+#if LINUX_VERSION_IS_LESS(4,8,0)
+static inline void time64_to_tm(time64_t totalsecs, int offset,
+				struct tm *result)
+{
+	time_to_tm((time_t)totalsecs, 0, result);
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_TIME_H */
diff --git a/backport/backport-include/net/addrconf.h b/backport/backport-include/net/addrconf.h
index f1e8e627..67d44e19 100644
--- a/backport/backport-include/net/addrconf.h
+++ b/backport/backport-include/net/addrconf.h
@@ -22,4 +22,19 @@ static inline bool ipv6_addr_is_solict_mult(const struct in6_addr *addr)
 }
 #endif /* LINUX_VERSION_IS_LESS(3,9,0) */
 
+#if LINUX_VERSION_IS_LESS(4,2,0)
+static inline int ipv6_mc_check_mld(struct sk_buff *skb)
+{
+	WARN_ON(1);
+
+	return -1;
+}
+#elif LINUX_VERSION_IS_LESS(5,1,0)
+static inline int backport_ipv6_mc_check_mld(struct sk_buff *skb)
+{
+	return ipv6_mc_check_mld(skb, NULL);
+}
+#define ipv6_mc_check_mld LINUX_BACKPORT(ipv6_mc_check_mld)
+#endif
+
 #endif	/* _BACKPORT_NET_ADDRCONF_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
