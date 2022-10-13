Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5FCC433FE
	for <backports@archiver.kernel.org>; Thu, 13 Oct 2022 08:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJMIx5 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJMIxz (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 13 Oct 2022 04:53:55 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF4616EB49
        for <backports@vger.kernel.org>; Thu, 13 Oct 2022 01:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qdneihZ2agBkYvk0f+ILa6ho04CtK/F48q5fIYw05DI=; b=mRaO06HfP3Fy0iAyK4enR3g0fi
        DPZBSi3e7kKRUWUYFGTh5tjJIxF1G8/L1Sm5zzWRB2fMWU9qaIJqZp72AVs8Ky7iymbzYCIiuY8T5
        aqm2Uux8wTK+wKXZml9XpLSJzKqCWrTtRm9dI1pUT+AGuXupNPJvNdHBtKwkiYwsB7S4=;
Received: from p200300daa7301d0028e1e1004b08c350.dip0.t-ipconnect.de ([2003:da:a730:1d00:28e1:e100:4b08:c350] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oityS-00CO7a-Jp
        for backports@vger.kernel.org; Thu, 13 Oct 2022 10:53:52 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     backports@vger.kernel.org
Subject: [PATCH 3/8] headers: add txq_trans_cond_update
Date:   Thu, 13 Oct 2022 10:53:46 +0200
Message-Id: <20221013085351.14516-3-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221013085351.14516-1-nbd@nbd.name>
References: <20221013085351.14516-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/netdevice.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index c0c6a97945b1..1d2ac66b403b 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -254,6 +254,17 @@ struct net_device_path_ctx {
 };
 #endif /* NET_DEVICE_PATH_STACK_MAX */
 
+#if LINUX_VERSION_IS_LESS(5,17,0)
+static inline void backport_txq_trans_cond_update(struct netdev_queue *txq)
+{
+	unsigned long now = jiffies;
+
+	if (READ_ONCE(txq->trans_start) != now)
+		WRITE_ONCE(txq->trans_start, now);
+}
+#define txq_trans_cond_update LINUX_BACKPORT(txq_trans_cond_update)
+#endif /* < 5.17 */
+
 #if LINUX_VERSION_IS_LESS(5,18,0)
 static inline int LINUX_BACKPORT(netif_rx)(struct sk_buff *skb)
 {
-- 
2.36.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
