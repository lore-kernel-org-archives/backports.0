Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B9EC71156
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DEA320709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="oF6jU4LX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbgLAWGg (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389671AbgLAWGf (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:06:35 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B80C094240
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:05:09 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Clx3H0df0zQjZj;
        Tue,  1 Dec 2020 23:04:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZ5TL2HP+L9LOLLf+mFQQQB8YoBVyEsKakKEMhA6m/E=;
        b=oF6jU4LXhKPBLdtZsiCMj8dFwDWc+MKWMrfIL+zY1XkQ5pcLEGXrZbsjlgWtz31Yg3graB
        TfUfxTjvz/8eY3LvQm6DcD7FM6cOHyBd1AYJRCvb3pE4FoF6wBWwRtXoX4Pb6hOXJDIQ+x
        Cq87+5qh8SrD4veoCmAnLmZkVOcaG7MeYzMAotihGJCF2bq86zK+YQ7MO0SqjRA+6esp2A
        /AoK9O7XTPjmpwOyOx3L/AYvzg9R15euIHz1N7NV3nI3Gnw5/0AVD3a1Xu9I3mqFUck0GJ
        NDhIqBkW4Ja63k3ylVh4uuzxo3UZthohqMtLSKoaK2ayLqpn9BvMNVc1IX9RAg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id OFbLS1PEjrcK; Tue,  1 Dec 2020 23:04:40 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 27/30] backports: Add dev_fetch_sw_netstats()
Date:   Tue,  1 Dec 2020 23:04:12 +0100
Message-Id: <20201201220415.30582-28-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: 3CCBC185A
X-Rspamd-UID: 03d5ee
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add the dev_fetch_sw_netstats which was added in commit 44fa32f008ab
("net: add function dev_fetch_sw_netstats for fetching
pcpu_sw_netstats") in kernel 5.10. This is used by qmi_wwan, usbnet,
qtnfmac and mac80211.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h |  4 +++
 backport/compat/backport-5.10.c             | 34 +++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 411757d2..ed691961 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -401,6 +401,10 @@ static inline bool netif_is_bridge_port(const struct net_device *dev)
 #endif
 
 #if LINUX_VERSION_IS_LESS(5,10,0)
+#define dev_fetch_sw_netstats LINUX_BACKPORT(dev_fetch_sw_netstats)
+void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
+			   const struct pcpu_sw_netstats __percpu *netstats);
+
 #define netif_rx_any_context LINUX_BACKPORT(netif_rx_any_context)
 int netif_rx_any_context(struct sk_buff *skb);
 #endif /* < 5.10 */
diff --git a/backport/compat/backport-5.10.c b/backport/compat/backport-5.10.c
index a83907f4..141862da 100644
--- a/backport/compat/backport-5.10.c
+++ b/backport/compat/backport-5.10.c
@@ -4,6 +4,40 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 
+/**
+ *	dev_fetch_sw_netstats - get per-cpu network device statistics
+ *	@s: place to store stats
+ *	@netstats: per-cpu network stats to read from
+ *
+ *	Read per-cpu network statistics and populate the related fields in @s.
+ */
+void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
+			   const struct pcpu_sw_netstats __percpu *netstats)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		const struct pcpu_sw_netstats *stats;
+		struct pcpu_sw_netstats tmp;
+		unsigned int start;
+
+		stats = per_cpu_ptr(netstats, cpu);
+		do {
+			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			tmp.rx_packets = stats->rx_packets;
+			tmp.rx_bytes   = stats->rx_bytes;
+			tmp.tx_packets = stats->tx_packets;
+			tmp.tx_bytes   = stats->tx_bytes;
+		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+
+		s->rx_packets += tmp.rx_packets;
+		s->rx_bytes   += tmp.rx_bytes;
+		s->tx_packets += tmp.tx_packets;
+		s->tx_bytes   += tmp.tx_bytes;
+	}
+}
+EXPORT_SYMBOL_GPL(dev_fetch_sw_netstats);
+
 int netif_rx_any_context(struct sk_buff *skb)
 {
 	/*
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
