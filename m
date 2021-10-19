Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3823CC433EF
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 178B761052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhJSVp6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJSVpz (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:55 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19715C061765
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:41 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HYnLM6zs2zQk0t;
        Tue, 19 Oct 2021 23:43:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXPI89sNJ3sjfHbcjkM6Tgv2Saidh+A1u0K+ZleN/+A=;
        b=Z2AUXl2JFZd0L9vjB3hVNS5y86KbuqSM9xMDYxqufern+9XatcNmJXKnPYExus828QIz9w
        Oyebrypwg9WNVRu56pyGiezeWx3Z1yGia93vzBWUfFG0uLpWUd9MMcsk8ddvCMOlOYIviI
        s5uhqxJpvAFJQaW47E7YK2cdTtXyADQagYHH7Mm4g5561kMADJUiYk2f2kykrYqKMzbtzA
        WOjI6H2rU0xAydgBJKPbnCrOfEsi+0OYiVE8TPDOYhesDlRS/BqSVF2IINxixK0ytt1aN3
        A34Fjqd3Ig/7TZKPsMqUuVzjN/TVpy/c+ctLT9Vcl6paYHdMtDqehW7A0z56sQ==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/47] backports: Add dev_sw_netstats_rx_add() and dev_sw_netstats_tx_add()
Date:   Tue, 19 Oct 2021 23:42:38 +0200
Message-Id: <20211019214320.2035704-6-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 41178131D
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Copy dev_sw_netstats_rx_add() and dev_sw_netstats_tx_add() from the
upstream kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 28 +++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index d854faef..5c30426d 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -113,6 +113,34 @@ void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
 int netif_rx_any_context(struct sk_buff *skb);
 #endif /* < 5.10 */
 
+#if LINUX_VERSION_IS_LESS(5,10,0)
+#define dev_sw_netstats_rx_add LINUX_BACKPORT(dev_sw_netstats_rx_add)
+static inline void dev_sw_netstats_rx_add(struct net_device *dev, unsigned int len)
+{
+	struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
+
+	u64_stats_update_begin(&tstats->syncp);
+	tstats->rx_bytes += len;
+	tstats->rx_packets++;
+	u64_stats_update_end(&tstats->syncp);
+}
+#endif /* < 5.10 */
+
+#if LINUX_VERSION_IS_LESS(5,11,0)
+#define dev_sw_netstats_tx_add LINUX_BACKPORT(dev_sw_netstats_tx_add)
+static inline void dev_sw_netstats_tx_add(struct net_device *dev,
+					  unsigned int packets,
+					  unsigned int len)
+{
+	struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
+
+	u64_stats_update_begin(&tstats->syncp);
+	tstats->tx_bytes += len;
+	tstats->tx_packets += packets;
+	u64_stats_update_end(&tstats->syncp);
+}
+#endif /* < 5.11 */
+
 #if LINUX_VERSION_IS_LESS(5,11,0)
 #define dev_get_tstats64 LINUX_BACKPORT(dev_get_tstats64)
 void dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
