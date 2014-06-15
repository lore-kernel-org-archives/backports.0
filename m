Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44876 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbaFOVWY (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id D1D0C7E5B
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:22 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/19] backports: remove usage of get_ts_info in cdc_ncm.c
Date: Sun, 15 Jun 2014 23:21:39 +0200
Message-Id: <1402867307-31337-12-git-send-email-hauke@hauke-m.de> (sfid-20140615_232226_396759_13D71572)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0017-get_ts_info/cdc_ncm.patch                   | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0017-get_ts_info/cdc_ncm.patch

diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/cdc_ncm.patch b/patches/collateral-evolutions/network/0017-get_ts_info/cdc_ncm.patch
new file mode 100644
index 0000000..14101f2
--- /dev/null
+++ b/patches/collateral-evolutions/network/0017-get_ts_info/cdc_ncm.patch
@@ -0,0 +1,12 @@
+--- a/drivers/net/usb/cdc_ncm.c
++++ b/drivers/net/usb/cdc_ncm.c
+@@ -137,7 +137,9 @@ static const struct ethtool_ops cdc_ncm_
+ 	.get_drvinfo       = usbnet_get_drvinfo,
+ 	.get_msglevel      = usbnet_get_msglevel,
+ 	.set_msglevel      = usbnet_set_msglevel,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.get_ts_info       = ethtool_op_get_ts_info,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+ 	.get_sset_count    = cdc_ncm_get_sset_count,
+ 	.get_strings       = cdc_ncm_get_strings,
+ 	.get_ethtool_stats = cdc_ncm_get_ethtool_stats,
-- 
1.9.1

