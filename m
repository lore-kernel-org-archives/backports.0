Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:33997 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657AbaG0WKy (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Jul 2014 18:10:54 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/9] backports: revert commit for mwifiex sido.
Date: Mon, 28 Jul 2014 00:10:34 +0200
Message-Id: <1406499039-16212-5-git-send-email-hauke@hauke-m.de> (sfid-20140728_001058_416239_F57B271E)
In-Reply-To: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
References: <1406499039-16212-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Revert this commit on kernel version < 3.7

    mwifiex: card reset: enable rescan of non-removable card

    mmc_rescan will scan for non-removable cards only once, hence the card
    will not be rediscovered.

    Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
    Acked-by: Bing Zhao <bzhao@marvell.com>
    Signed-off-by: John W. Linville <linville@tuxdriver.com>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0046-mmc_rescan_entered/mwifiex.patch            | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch

diff --git a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
new file mode 100644
index 0000000..89de2fb
--- /dev/null
+++ b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
@@ -0,0 +1,12 @@
+--- a/drivers/net/wireless/mwifiex/sdio.c
++++ b/drivers/net/wireless/mwifiex/sdio.c
+@@ -1954,7 +1954,9 @@ static void mwifiex_sdio_card_reset_work
+ 	mmc_remove_host(target);
+ 	/* 20ms delay is based on experiment with sdhci controller */
+ 	mdelay(20);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ 	target->rescan_entered = 0; /* rescan non-removable cards */
++#endif
+ 	mmc_add_host(target);
+ }
+ 
-- 
1.9.1

