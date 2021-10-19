Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4F6C433F5
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5569C61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhJSVqA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSVpz (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:55 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C6BC06161C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:41 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HYnLL3XWRzQk1x;
        Tue, 19 Oct 2021 23:43:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7RRFdXEg6vBWrkb14NAUrb5iHqWnjZAMd08yLlf2Os=;
        b=q2UaNJaJeKPpmnw79cksa9q8PQWfckaiMnaK5Lry90LCU8WNvTS/3eRgknO84qgfRXORmx
        QOGbijHUFWqNC7m9WuneC4bJHI4OsszfAhMgeJVbY2LFTSctw3f3FvSdP/a+qG143I92D/
        WF/GDR/wwuW4w/65igFnKXg6ehPOnBKC33L4Ax+gBLsZkB+jhyA4ofLneQmoW//0fIaX4G
        I3K1AD840DvRdI15/mv8jOhWVCkI7CEHkHBJFpO9soUydeQI/npvj2mNqdafN77AQLp9GQ
        EXQlOmPV8ZtBb0AkxxR5VNBmmqaIeg0I5ajylmpiI5GIolXvEm+/NEUzTUbtIQ==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/47] backports: Add dev_get_tstats64() and bp_dev_get_tstats64()
Date:   Tue, 19 Oct 2021 23:42:35 +0200
Message-Id: <20211019214320.2035704-3-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C5E411317
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

dev_get_tstats64() was added as a generic function for .ndo_get_stats64.
The signature of this callback function changed with kernel 4.11, add
the bp_dev_get_tstats64() function on such older kernel version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 10 ++++++++++
 backport/compat/Makefile                    |  2 ++
 backport/compat/backport-4.11.c             | 12 ++++++++++++
 backport/compat/backport-5.11.c             | 19 +++++++++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 backport/compat/backport-4.11.c
 create mode 100644 backport/compat/backport-5.11.c

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index e9c07a91..d854faef 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -113,4 +113,14 @@ void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
 int netif_rx_any_context(struct sk_buff *skb);
 #endif /* < 5.10 */
 
+#if LINUX_VERSION_IS_LESS(5,11,0)
+#define dev_get_tstats64 LINUX_BACKPORT(dev_get_tstats64)
+void dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
+#endif /* < 5.11 */
+
+#if LINUX_VERSION_IS_LESS(4,11,0)
+struct rtnl_link_stats64 *
+bp_dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
+#endif /* < 4.11 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index bbedd49c..e927a0c8 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -12,11 +12,13 @@ compat-$(CPTCFG_KERNEL_4_6) += backport-4.6.o
 compat-$(CPTCFG_KERNEL_4_7) += backport-4.7.o
 compat-$(CPTCFG_KERNEL_4_8) += backport-4.8.o
 compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
+compat-$(CPTCFG_KERNEL_4_11) += backport-4.11.o
 compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
 compat-$(CPTCFG_KERNEL_5_2) += backport-5.2.o backport-genetlink.o
 compat-$(CPTCFG_KERNEL_5_3) += backport-5.3.o
 compat-$(CPTCFG_KERNEL_5_5) += backport-5.5.o
 compat-$(CPTCFG_KERNEL_5_10) += backport-5.10.o
+compat-$(CPTCFG_KERNEL_5_11) += backport-5.11.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7.asn1.o
diff --git a/backport/compat/backport-4.11.c b/backport/compat/backport-4.11.c
new file mode 100644
index 00000000..83445856
--- /dev/null
+++ b/backport/compat/backport-4.11.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/netdevice.h>
+
+struct rtnl_link_stats64 *
+bp_dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s)
+{
+	dev_get_tstats64(dev, s);
+	return s;
+}
+EXPORT_SYMBOL_GPL(bp_dev_get_tstats64);
diff --git a/backport/compat/backport-5.11.c b/backport/compat/backport-5.11.c
new file mode 100644
index 00000000..e60f35cf
--- /dev/null
+++ b/backport/compat/backport-5.11.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/netdevice.h>
+
+/**
+ *	dev_get_tstats64 - ndo_get_stats64 implementation
+ *	@dev: device to get statistics from
+ *	@s: place to store stats
+ *
+ *	Populate @s from dev->stats and dev->tstats. Can be used as
+ *	ndo_get_stats64() callback.
+ */
+void dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s)
+{
+	netdev_stats_to_stats64(s, &dev->stats);
+	dev_fetch_sw_netstats(s, dev->tstats);
+}
+EXPORT_SYMBOL_GPL(dev_get_tstats64);
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
