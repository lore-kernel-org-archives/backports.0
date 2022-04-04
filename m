Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B12AC433EF
	for <backports@archiver.kernel.org>; Mon,  4 Apr 2022 09:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354562AbiDDJoX (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 4 Apr 2022 05:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244030AbiDDJoW (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 4 Apr 2022 05:44:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA793584E
        for <backports@vger.kernel.org>; Mon,  4 Apr 2022 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=YqDFtbTFJDir0b9bD4bmbUNIa+o9sv5HWRuGkME9Buo=; t=1649065347; x=1650274947; 
        b=DRu5BC//1scs52vOmRY/l3Apwpbza4Z9Sv6iSLpZ51rWy7y5t5082rjfK0hqFPXArRuKoxAyQui
        LqiFxAJDO2iujrpAmzvMhmhn5YQcu51X1FnPY0Ajr9Mer0Qrg2xUlHgPFVh1Uc9xbngAOja2yx3zE
        gE2TAuHyR373Q83YgFSWUrrLyagPdMzg7rG3/ZPD56r948EQRoGfmnQy6fddSuJZ+3lUjPhRDXsV3
        FhbHSvMnO6GGQnfiEJq3+Vf/dxe9QuXb9QmtK8gNOwHuvNeHx4MIDfVvBseS8EQksH9X3T9PS/lrh
        fDuh5c/jm3Yq/atiwP8MLglGI8Ev25uFCveA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nbJE9-004lql-FQ;
        Mon, 04 Apr 2022 11:42:25 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add netif_rx()
Date:   Mon,  4 Apr 2022 11:41:58 +0200
Message-Id: <20220404094158.131124-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We need this to auto-detect the context now, since that's
what was done upstream.

Change-Id: Ie974d61fc51bd6ae44a6a92cee7da674bb179680
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport-include/linux/netdevice.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/backport-include/linux/netdevice.h b/backport-include/linux/netdevice.h
index 6214a69a3e65..bd31c94bde76 100644
--- a/backport-include/linux/netdevice.h
+++ b/backport-include/linux/netdevice.h
@@ -247,4 +247,21 @@ struct net_device_path_ctx {
 };
 #endif /* NET_DEVICE_PATH_STACK_MAX */
 
+#if LINUX_VERSION_IS_LESS(5,18,0)
+#define netif_rx LINUX_BACKPORT(netif_rx)
+static inline int netif_rx(struct sk_buff *skb)
+{
+	bool need_bh_off = !(hardirq_count() | softirq_count());
+	int ret;
+
+	if (need_bh_off)
+		local_bh_disable();
+	ret = __netif_rx(skb);
+	if (need_bh_off)
+		local_bh_enable();
+
+	return ret;
+}
+#endif /* < 5.18.0 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
