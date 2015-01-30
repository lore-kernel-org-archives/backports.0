Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:29248 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763110AbbA3UMq (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 30 Jan 2015 15:12:46 -0500
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH 2/2] backport: add backport file for the next kernel release
Date: Fri, 30 Jan 2015 21:12:38 +0100
Message-ID: <1422648758-31361-2-git-send-email-arend@broadcom.com> (sfid-20150130_211248_858610_757440B4)
In-Reply-To: <1422648758-31361-1-git-send-email-arend@broadcom.com>
References: <1422648758-31361-1-git-send-email-arend@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In mac80211-next a call to get_net_ns_by_fd() has been added in cfg80211
which resides in networking core. This function has been backported
such that it will always fail, ie. as it would when CONFIG_NET_NS
is not defined. The call was added by:

   commit 4b681c82d2f9bef121c912ffcaac89a004af3f2c
   Author: Vadim Kochan <vadim4j@gmail.com>
   Date: Mon Jan 12 16:34:05 2015 +0200

     nl80211: Allow set network namespace by fd

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 backport/compat/Makefile        |  1 +
 backport/compat/backport-3.20.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 backport/compat/backport-3.20.c

diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 3d905ed..b6f1d12 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -25,6 +25,7 @@ compat-$(CPTCFG_KERNEL_3_15) += backport-3.15.o
 compat-$(CPTCFG_KERNEL_3_17) += backport-3.17.o
 compat-$(CPTCFG_KERNEL_3_18) += backport-3.18.o
 compat-$(CPTCFG_KERNEL_3_19) += backport-3.19.o
+compat-$(CPTCFG_KERNEL_3_20) += backport-3.20.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BPAUTO_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
diff --git a/backport/compat/backport-3.20.c b/backport/compat/backport-3.20.c
new file mode 100644
index 0000000..ce119fd
--- /dev/null
+++ b/backport/compat/backport-3.20.c
@@ -0,0 +1,17 @@
+/*
+ * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 3.19.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/export.h>
+#include <linux/net.h>
+
+struct net *get_net_ns_by_fd(int fd)
+{
+	return ERR_PTR(-EINVAL);
+}
+EXPORT_SYMBOL_GPL(get_net_ns_by_fd);
-- 
1.9.1

