Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E542C4332F
	for <backports@archiver.kernel.org>; Thu, 13 Oct 2022 08:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJMIyA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiJMIx5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 13 Oct 2022 04:53:57 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520E916EB5A
        for <backports@vger.kernel.org>; Thu, 13 Oct 2022 01:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=++chvALTAUMuOjOCEJXNSIsPCl5oQ146XTSIUhluO38=; b=rkqXZAH+QUz1jZy5BGrlN3pjtC
        8zykArSM3GzktnHmlynOfGuOQvOeNyf8z44cfrIGWuJbEPgYvhpTuYZgjANvMJ3MKzU9cdiUg2fKP
        uoA5Z1zxGE4dgBqsGZLjs7j0ITtoA/4EMslp3nkT075heI9s0W5Iwwrx6Osx7o009TTE=;
Received: from p200300daa7301d0028e1e1004b08c350.dip0.t-ipconnect.de ([2003:da:a730:1d00:28e1:e100:4b08:c350] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oityT-00CO7a-AY
        for backports@vger.kernel.org; Thu, 13 Oct 2022 10:53:53 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     backports@vger.kernel.org
Subject: [PATCH 7/8] headers: backport device_get_mac_address api change
Date:   Thu, 13 Oct 2022 10:53:50 +0200
Message-Id: <20221013085351.14516-7-nbd@nbd.name>
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
 backport/backport-include/linux/etherdevice.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index f6fa51f3829c..51a7d6d73f7e 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -2,6 +2,7 @@
 #define _BACKPORT_LINUX_ETHERDEVICE_H
 #include_next <linux/etherdevice.h>
 #include <linux/version.h>
+#include <linux/property.h>
 
 
 #if LINUX_VERSION_IS_LESS(4,11,0)
@@ -52,4 +53,15 @@ static inline void eth_hw_addr_set(struct net_device *dev, const u8 *addr)
 }
 #endif /* LINUX_VERSION_IS_LESS(5,15,0) */
 
+#if LINUX_VERSION_IS_LESS(5,16,0)
+static inline int backport_device_get_mac_address(struct device *dev, char *addr)
+{
+	if (!device_get_mac_address(dev, addr, ETH_ALEN))
+		return -ENOENT;
+
+	return 0;
+}
+#define device_get_mac_address LINUX_BACKPORT(device_get_mac_address)
+#endif /* LINUX_VERSION_IS_LESS(5,16,0) */
+
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
-- 
2.36.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
