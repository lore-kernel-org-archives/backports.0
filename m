Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35246 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927AbaFGT3q (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Jun 2014 15:29:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 49D9D7E74
	for <backports@vger.kernel.org>; Sat,  7 Jun 2014 21:29:45 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/7] backports: add mmc_card_hs()
Date: Sat,  7 Jun 2014 21:29:14 +0200
Message-Id: <1402169356-1267-6-git-send-email-hauke@hauke-m.de> (sfid-20140607_212947_602199_3594D7A7)
In-Reply-To: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
References: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by the RSI driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mmc/host.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 backport/backport-include/linux/mmc/host.h

diff --git a/backport/backport-include/linux/mmc/host.h b/backport/backport-include/linux/mmc/host.h
new file mode 100644
index 0000000..49d7049
--- /dev/null
+++ b/backport/backport-include/linux/mmc/host.h
@@ -0,0 +1,16 @@
+#ifndef _BACKPORTLINUX_MMC_HOST_H
+#define _BACKPORTLINUX_MMC_HOST_H
+#include_next <linux/mmc/host.h>
+#include <linux/version.h>
+#include <linux/mmc/card.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
+#define mmc_card_hs LINUX_BACKPORT(mmc_card_hs)
+static inline int mmc_card_hs(struct mmc_card *card)
+{
+	return card->host->ios.timing == MMC_TIMING_SD_HS ||
+		card->host->ios.timing == MMC_TIMING_MMC_HS;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0) */
+
+#endif /* _BACKPORTLINUX_MMC_HOST_H */
-- 
1.9.1

