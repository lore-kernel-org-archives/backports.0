Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12123C4321E
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJKVFT (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiJKVFC (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AB521247
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=nl+S5eYJqyWINBGeW1Z1FXUCq3j5VXrV4euMMEg9dhk=;
        t=1665522299; x=1666731899; b=wbXbs+NO+g/h4TDslVleEqIPAzoNe7/pV5JklL250CMOpGs
        18ckUO8RwDrj25RbZry0m/LcZwuMZzG+l6wre8imbsLXlpco9hNsFxKbACyTQvnoweuUVclot4Jxn
        uzhucLyMwgXzWjtrqo5KZldKg68Ky3i/FKVDsD/sR7cZ3/1+93Aq8YqfpYjrsYJddNMHUz497UU7p
        92jTnQR6Sr8gcUK00T4boqo++p1qU2Fx1dbbGhvDju0cw8A0ZFPt3X6U9CaPN2VjeI8HC+3Et7tOG
        +9A2MzVS9aiQRL9DYpWT4xKbl+FvU2NPQuGoEovbNZZZ4552kMFvShzGCdFzaFrA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQp-0045LP-1h;
        Tue, 11 Oct 2022 23:04:55 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 24/38] backports: add netif_rx()
Date:   Tue, 11 Oct 2022 23:04:32 +0200
Message-Id: <20221011230356.fb36659a480f.I4b1f5287579f615582a608782b8513f2f5cb374c@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This got changed upstream to detect the context to get rid
of netif_rx_ni(), so just copy the new upstream version
with the detection.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index d2e175243560..9b3291bb7188 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -254,4 +254,21 @@ struct net_device_path_ctx {
 };
 #endif /* NET_DEVICE_PATH_STACK_MAX */
 
+#if LINUX_VERSION_IS_LESS(5,18,0)
+static inline int LINUX_BACKPORT(netif_rx)(struct sk_buff *skb)
+{
+	bool need_bh_off = !(hardirq_count() | softirq_count());
+	int ret;
+
+	if (need_bh_off)
+		local_bh_disable();
+	ret = netif_rx(skb);
+	if (need_bh_off)
+		local_bh_enable();
+
+	return ret;
+}
+#define netif_rx LINUX_BACKPORT(netif_rx)
+#endif /* < 5.18.0 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
