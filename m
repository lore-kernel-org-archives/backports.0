Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D27C4167B
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A2B61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhJSVqN (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhJSVqJ (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:09 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183F8C061749
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:56 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLf5fwTzQkj1;
        Tue, 19 Oct 2021 23:43:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KoOYEe2W0T1RFDdZ8/I9rALzQfr1DGJQroAAy5k5F0=;
        b=VS7MqBsGIrXOOYWcWjRcGLYJW2xvtgdzUlFdHzrU0WLNhBW+pem68zxDO98aW11IVEEZja
        v69Rkbbe0mCKCZ5m6OOINsqEUIsfZzu7LsjIb6ht4FVu2euNRSDSyeyM2JHvNsBHEZ3tqu
        GRSxoAI36ZgsnF8lyTWjo3m+j3/X5iTiCEYaRSF7snpYaOBwNnVaIBe66Ou5HFHd9gxA3b
        38VhCCDqDPqCnaHH64yMPT/rN8dUd7y3y+ub/XL/4nXl9pe/eD/XTbI52YWhp1ip/DHFsw
        KDMp3yF2GyKxUDZn37AdY3jF9s94qKiVuCw9ru3yhE9pro2zfGe0b9iK8ARZ+w==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 43/47] backports: Add new r8188eu driver
Date:   Tue, 19 Oct 2021 23:43:16 +0200
Message-Id: <20211019214320.2035704-44-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 125D01317
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This driver replaces the rtl8188eu driver which was removed upstream.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi                       |  1 +
 copy-list                                      |  1 +
 .../0013-fix-makefile-includes/r8188eu.patch   | 12 ++++++++++++
 patches/0028-select_queue/r8188eu.patch        | 18 ++++++++++++++++++
 4 files changed, 32 insertions(+)
 create mode 100644 patches/0013-fix-makefile-includes/r8188eu.patch
 create mode 100644 patches/0028-select_queue/r8188eu.patch

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index be74147d..936203d9 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -87,6 +87,7 @@ CPTCFG_PCMCIA_HERMES=m
 CPTCFG_PCMCIA_SPECTRUM=m
 CPTCFG_PLX_HERMES=m
 CPTCFG_QTNFMAC_PCIE=m
+CPTCFG_R8188EU=m
 CPTCFG_RSI_91X=m
 CPTCFG_RT2400PCI=m
 CPTCFG_RT2500PCI=m
diff --git a/copy-list b/copy-list
index b9fdd2ff..be8539d4 100644
--- a/copy-list
+++ b/copy-list
@@ -126,6 +126,7 @@ drivers/net/usb/usbnet.c
 
 drivers/staging/Makefile
 drivers/staging/Kconfig
+drivers/staging/r8188eu/
 drivers/staging/rtl8723bs/
 
 drivers/usb/class/Makefile
diff --git a/patches/0013-fix-makefile-includes/r8188eu.patch b/patches/0013-fix-makefile-includes/r8188eu.patch
new file mode 100644
index 00000000..b1c32f21
--- /dev/null
+++ b/patches/0013-fix-makefile-includes/r8188eu.patch
@@ -0,0 +1,12 @@
+Needed for kernel <= 5.7
+
+--- a/drivers/staging/r8188eu/core/rtw_security.c
++++ b/drivers/staging/r8188eu/core/rtw_security.c
+@@ -7,6 +7,7 @@
+ #include "../include/drv_types.h"
+ #include "../include/wifi.h"
+ #include "../include/osdep_intf.h"
++#include <linux/crc32.h>
+ 
+ /* WEP related ===== */
+ 
diff --git a/patches/0028-select_queue/r8188eu.patch b/patches/0028-select_queue/r8188eu.patch
new file mode 100644
index 00000000..d12fa9c4
--- /dev/null
+++ b/patches/0028-select_queue/r8188eu.patch
@@ -0,0 +1,18 @@
+--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
++++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
+@@ -635,7 +635,15 @@ static unsigned int rtw_classify8021d(st
+ 	return dscp >> 5;
+ }
+ 
++#if LINUX_VERSION_IS_GEQ(5,2,0)
+ static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb, struct net_device *sb_dev)
++#elif LINUX_VERSION_IS_GEQ(4,19,0)
++static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb, struct net_device *sb_dev,
++			    select_queue_fallback_t fallback)
++#else
++static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb, void *accel_priv,
++			    select_queue_fallback_t fallback)
++#endif
+ {
+ 	struct adapter	*padapter = rtw_netdev_priv(dev);
+ 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
