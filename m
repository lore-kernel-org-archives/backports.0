Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD63C4332F
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145D061052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhJSVqK (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSVqF (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:05 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77738C06161C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:52 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLb1H2yzQjgJ;
        Tue, 19 Oct 2021 23:43:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=la/p5bEjCEdSy4H5m3NnfuQb4qEKt8XsjCxMSGPmp+U=;
        b=S9YEQRCywtStLIHUtkDWppRBXy5D/6SQDYXbvASIl2ivLqPdH131CNDjfHT/jJfEisH0nP
        PjaPgP2PkYdGyyZROy04Pd2aVgF40cX4TrQ4nI8IYF7cDVDE08UB+FJPCfSoK5A1pXSQri
        dP33Idfq5rhitlORNVM0tUbJzKabXBkCLnl9ONkF96JJ81yLa1Lb/Q+aqwcrdvD62g56Bp
        MPsNr/iFlG45ghDhY51kD7a0kJ6qoAouWbAxyqUynVkDadkLEBtdI93AtucU+BFmxudxNV
        hFtUsgPKiXJbrjIoTv9d6cInqlKM3DP1X5O0uZdBmHWxPkzDhpXBQuNJN7dLAQ==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 34/47] backports: Remove rtl8188eu driver
Date:   Tue, 19 Oct 2021 23:43:07 +0200
Message-Id: <20211019214320.2035704-35-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 70BA71318
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This driver was removed from upstream kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi                  |  1 -
 copy-list                                 |  1 -
 patches/0028-select_queue/rtl8188eu.patch | 21 ---------------------
 3 files changed, 23 deletions(-)
 delete mode 100644 patches/0028-select_queue/rtl8188eu.patch

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 8f7b9f58..86e3bd6e 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -85,7 +85,6 @@ CPTCFG_PCMCIA_SPECTRUM=m
 CPTCFG_PLX_HERMES=m
 CPTCFG_RSI_91X=m
 CPTCFG_QTNFMAC_PCIE=m
-CPTCFG_R8188EU=m
 CPTCFG_RT2400PCI=m
 CPTCFG_RT2500PCI=m
 CPTCFG_RT2500USB=m
diff --git a/copy-list b/copy-list
index 8c787e06..63ea7eda 100644
--- a/copy-list
+++ b/copy-list
@@ -124,7 +124,6 @@ drivers/net/usb/usbnet.c
 
 drivers/staging/Makefile
 drivers/staging/Kconfig
-drivers/staging/rtl8188eu/
 drivers/staging/rtl8723bs/
 
 drivers/usb/class/Makefile
diff --git a/patches/0028-select_queue/rtl8188eu.patch b/patches/0028-select_queue/rtl8188eu.patch
deleted file mode 100644
index 7d3c7b95..00000000
--- a/patches/0028-select_queue/rtl8188eu.patch
+++ /dev/null
@@ -1,21 +0,0 @@
---- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
-+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
-@@ -243,8 +243,18 @@ static unsigned int rtw_classify8021d(st
- 	return dscp >> 5;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(5,2,0)
- static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
- 			    struct net_device *sb_dev)
-+#elif LINUX_VERSION_IS_GEQ(4,19,0)
-+static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
-+			    struct net_device *sb_dev,
-+			    select_queue_fallback_t fallback)
-+#else
-+static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
-+			    void *accel_priv,
-+			    select_queue_fallback_t fallback)
-+#endif
- {
- 	struct adapter *padapter = netdev_priv(dev);
- 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
