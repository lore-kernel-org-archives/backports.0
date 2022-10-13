Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAA3C43219
	for <backports@archiver.kernel.org>; Thu, 13 Oct 2022 08:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJMIx6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJMIxz (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 13 Oct 2022 04:53:55 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B80015DB20
        for <backports@vger.kernel.org>; Thu, 13 Oct 2022 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KaqsC1UJdP6R2hYZy1HKfj9PL4LSoZTGmp0mCmN0I6c=; b=aJ+h0BzQOt0DVpShgGccyA2KT/
        lHLf+SwXgHFShwAf30H9u7FniLohtTVrrRT6f/O9jSKTG3nx60KdIzE0mzcUrKJrPedraZai1XS1d
        mvnmJK+zazYp6bWS5hap5CRCwf0ERmXNxzfAGBonP+a8ozSu87Iarum3Sml36wbblRkk=;
Received: from p200300daa7301d0028e1e1004b08c350.dip0.t-ipconnect.de ([2003:da:a730:1d00:28e1:e100:4b08:c350] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oityS-00CO7a-81
        for backports@vger.kernel.org; Thu, 13 Oct 2022 10:53:52 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     backports@vger.kernel.org
Subject: [PATCH 1/8] headers: backport napi add functions
Date:   Thu, 13 Oct 2022 10:53:44 +0200
Message-Id: <20221013085351.14516-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Deal with the removed weight argument

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/netdevice.h | 38 ++++++++++-----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 9b3291bb7188..c0c6a97945b1 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -23,27 +23,27 @@ static inline bool backport_napi_complete(struct napi_struct *n)
 #define napi_complete LINUX_BACKPORT(napi_complete)
 #endif /* < 4.10 */
 
-#if LINUX_VERSION_IS_LESS(4,5,0)
-#define netif_tx_napi_add LINUX_BACKPORT(netif_tx_napi_add)
-/**
- *	netif_tx_napi_add - initialize a napi context
- *	@dev:  network device
- *	@napi: napi context
- *	@poll: polling function
- *	@weight: default weight
- *
- * This variant of netif_napi_add() should be used from drivers using NAPI
- * to exclusively poll a TX queue.
- * This will avoid we add it into napi_hash[], thus polluting this hash table.
- */
-static inline void netif_tx_napi_add(struct net_device *dev,
-				     struct napi_struct *napi,
-				     int (*poll)(struct napi_struct *, int),
-				     int weight)
+#if LINUX_VERSION_IS_LESS(6,1,0)
+static inline void backport_netif_napi_add(struct net_device *dev,
+					   struct napi_struct *napi,
+					   int (*poll)(struct napi_struct *, int))
+{
+	netif_napi_add(dev, napi, poll, NAPI_POLL_WEIGHT);
+}
+#define netif_napi_add LINUX_BACKPORT(netif_napi_add)
+
+static inline void backport_netif_napi_add_tx(struct net_device *dev,
+					      struct napi_struct *napi,
+					      int (*poll)(struct napi_struct *, int))
 {
-	netif_napi_add(dev, napi, poll, weight);
+#if LINUX_VERSION_IS_LESS(4,5,0)
+	netif_napi_add(dev, napi, poll);
+#else
+	netif_tx_napi_add(dev, napi, poll, NAPI_POLL_WEIGHT);
+#endif
 }
-#endif /* < 4.5 */
+#define netif_napi_add_tx LINUX_BACKPORT(netif_napi_add_tx)
+#endif /* < 6.1 */
 
 #ifndef NETIF_F_CSUM_MASK
 #define NETIF_F_CSUM_MASK NETIF_F_ALL_CSUM
-- 
2.36.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
