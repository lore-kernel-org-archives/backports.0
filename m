Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1D1C433FE
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJKVFG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJKVE7 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:04:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F43621E24
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=SJhyHaZpypWm2xpCjg6mWoj073ODuIjYqbaG8Ckgq68=;
        t=1665522295; x=1666731895; b=p24G3EOIK5aZ7yeD0HK95hCxLS5W9KIOMsiaiPVItEx2Os6
        thfdpf+gpNhvSsP2a0Bklkzm0hBswSj2uMYSv3vyd6HjC3MJmiz0QQgOyvl7xOR/vyr8GrNWOpZa3
        GBxiUzv+Oq/IMdUowDwRi2+fcFYPC+Tg6K+SXatpiIbHR0mIe2PBWqpVpvOgJUbaoKc8LAobCJoZQ
        LqJc+J7n9lwCNy85HLKe7r5k97LK10ABmZyuRC1yqNLce99Nbu3+heaN/i1lSfo86CTJJIS0PC4Zo
        rOSogoSpXENdSRv6t5FsWnksDhnE56IKBpEhtyp4VQ6iSlw1oFwT2yf6XTVyeVCw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQj-0045LP-26;
        Tue, 11 Oct 2022 23:04:49 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 04/38] backport: add dev_sw_netstats_tx/rx_add() functions
Date:   Tue, 11 Oct 2022 23:04:12 +0200
Message-Id: <20221011230356.2960f8b2fb4e.I16f0b19a20bfa28f277fa171600017bbdd4ed8b2@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Two new functions were added in v5.10 and are now used in mac80211.
Add them as bakcports in netdevice.h

type=maint
ticket=jira:WIFI-95070

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/139718
---
 backport/backport-include/linux/netdevice.h | 25 +++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index e17731909ca5..c6ca8b5556d5 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -111,6 +111,31 @@ void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
 
 #define netif_rx_any_context LINUX_BACKPORT(netif_rx_any_context)
 int netif_rx_any_context(struct sk_buff *skb);
+
+static inline void dev_sw_netstats_rx_add(struct net_device *dev, unsigned int len)
+{
+	struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
+
+	u64_stats_update_begin(&tstats->syncp);
+	tstats->rx_bytes += len;
+	tstats->rx_packets++;
+	u64_stats_update_end(&tstats->syncp);
+}
+
+#endif /* < 5.10 */
+
+#if LINUX_VERSION_IS_LESS(5,10,0)
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
 #endif /* < 5.10 */
 
 #if LINUX_VERSION_IS_LESS(5,10,0)
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
