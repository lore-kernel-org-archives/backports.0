Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39668 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbbDWLeC (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 23 Apr 2015 07:34:02 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 2/4] backports: add passthru_features_check()
Date: Thu, 23 Apr 2015 13:33:43 +0200
Message-Id: <1429788825-18466-3-git-send-email-sassmann@kpanic.de> (sfid-20150423_133405_625437_9F927C7B)
In-Reply-To: <1429788825-18466-1-git-send-email-sassmann@kpanic.de>
References: <1429788825-18466-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is required by igb and possibly other network drivers.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/netdevice.h |  6 ++++++
 backport/compat/Makefile                    |  1 +
 backport/compat/backport-4.1.c              | 19 +++++++++++++++++++
 3 files changed, 26 insertions(+)
 create mode 100644 backport/compat/backport-4.1.c

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index abbfe1d..ae67771 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -254,4 +254,10 @@ static inline struct sk_buff *napi_alloc_skb(struct napi_struct *napi,
 #define IFF_TX_SKB_SHARING 0
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
+netdev_features_t passthru_features_check(struct sk_buff *skb,
+					  struct net_device *dev,
+					  netdev_features_t features);
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 3d905ed..f60c32b 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -25,6 +25,7 @@ compat-$(CPTCFG_KERNEL_3_15) += backport-3.15.o
 compat-$(CPTCFG_KERNEL_3_17) += backport-3.17.o
 compat-$(CPTCFG_KERNEL_3_18) += backport-3.18.o
 compat-$(CPTCFG_KERNEL_3_19) += backport-3.19.o
+compat-$(CPTCFG_KERNEL_4_1) += backport-4.1.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BPAUTO_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
diff --git a/backport/compat/backport-4.1.c b/backport/compat/backport-4.1.c
new file mode 100644
index 0000000..f9adb41
--- /dev/null
+++ b/backport/compat/backport-4.1.c
@@ -0,0 +1,19 @@
+/*
+ * Copyright (c) 2015  Stefan Assmann <sassmann@kpanic.de>
+ *
+ * Backport functionality introduced in Linux 4.1.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/netdevice.h>
+
+netdev_features_t passthru_features_check(struct sk_buff *skb,
+					  struct net_device *dev,
+					  netdev_features_t features)
+{
+	return features;
+}
+EXPORT_SYMBOL(passthru_features_check);
-- 
2.1.0

