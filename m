Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0D6C433EF
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510D561052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhJSVqL (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhJSVqG (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:06 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB796C061746
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:52 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLb48T2zQjgT;
        Tue, 19 Oct 2021 23:43:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q7Gyy0jhZS6iKwESGrV4teBJskqubdoThUDzZ7LE764=;
        b=z1GVcMwKtQ+Dih9Xk4PEBczzYGRIRnBkTZNVHTIMRemQnCtLUQZJcWbL5Tx47GukCg3NWo
        0YdvcU5pNY0MBLjQEHN+VSTXgfnxrFiZaKO0GWPHz4uffThxXSrTtYJq6UxLk7eeEvGDMR
        w6ZF9/63Tgb2BSsvPIutbEIuRMDsuC3zakO0kC7K1EAPzlmg6BNhEPkJnNTawa6vS35PcI
        oZC+2Mc5zva0IF+7b2W1BraNlyNF4twkG6i8mMwTRKkIxvu98ybpJrW2iWqTCS/falIV19
        /B7B16DHsd8kg3mUJbPD/fNFufB1BOKKbPPeE9PNtnqXQnywiOzEh3oTqMvq1Q==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 35/47] backports: Remove prism54 driver
Date:   Tue, 19 Oct 2021 23:43:08 +0200
Message-Id: <20211019214320.2035704-36-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DF3151313
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This driver was removed from upstream kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi                  |  1 -
 patches/0094-ndo-tx-timeout/prism54.patch | 23 -----------------------
 2 files changed, 24 deletions(-)
 delete mode 100644 patches/0094-ndo-tx-timeout/prism54.patch

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 86e3bd6e..ea0aee71 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -76,7 +76,6 @@ CPTCFG_P54_COMMON=m
 CPTCFG_P54_PCI=m
 CPTCFG_P54_SPI=m
 CPTCFG_P54_USB=m
-CPTCFG_PRISM54=m
 CPTCFG_PCI_ATMEL=m
 CPTCFG_PCI_HERMES=m
 CPTCFG_PCMCIA_ATMEL=m
diff --git a/patches/0094-ndo-tx-timeout/prism54.patch b/patches/0094-ndo-tx-timeout/prism54.patch
deleted file mode 100644
index 1e55f03c..00000000
--- a/patches/0094-ndo-tx-timeout/prism54.patch
+++ /dev/null
@@ -1,23 +0,0 @@
---- a/drivers/net/wireless/intersil/prism54/islpci_eth.h
-+++ b/drivers/net/wireless/intersil/prism54/islpci_eth.h
-@@ -54,6 +54,7 @@ void islpci_eth_cleanup_transmit(islpci_
- netdev_tx_t islpci_eth_transmit(struct sk_buff *, struct net_device *);
- int islpci_eth_receive(islpci_private *);
- void islpci_eth_tx_timeout(struct net_device *, unsigned int txqueue);
-+void bp_islpci_eth_tx_timeout(struct net_device *);
- void islpci_do_reset_and_wake(struct work_struct *);
- 
- #endif				/* _ISL_GEN_H */
---- a/drivers/net/wireless/intersil/prism54/islpci_eth.c
-+++ b/drivers/net/wireless/intersil/prism54/islpci_eth.c
-@@ -487,3 +487,10 @@ islpci_eth_tx_timeout(struct net_device
- 			"%s: tx_timeout, waiting for reset", ndev->name);
- 	}
- }
-+
-+#if LINUX_VERSION_IS_LESS(5,6,0)
-+void bp_islpci_eth_tx_timeout(struct net_device *dev) {
-+	islpci_eth_tx_timeout(dev, 0);
-+}
-+EXPORT_SYMBOL_GPL(bp_islpci_eth_tx_timeout);
-+#endif
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
