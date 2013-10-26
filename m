Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47123 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab3JZKNk (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 26 Oct 2013 06:13:40 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] backports: remove struct platform_device_id from wcn36xx
Date: Sat, 26 Oct 2013 12:13:08 +0200
Message-Id: <1382782389-4859-4-git-send-email-hauke@hauke-m.de> (sfid-20131026_121343_122602_367BA9A1)
In-Reply-To: <1382782389-4859-1-git-send-email-hauke@hauke-m.de>
References: <1382782389-4859-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drivers_net_wireless_ath_wcn36xx_main.patch    |   28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch

diff --git a/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch b/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch
new file mode 100644
index 0000000..a6f0c6b
--- /dev/null
+++ b/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch
@@ -0,0 +1,28 @@
+--- a/drivers/net/wireless/ath/wcn36xx/main.c
++++ b/drivers/net/wireless/ath/wcn36xx/main.c
+@@ -999,6 +999,7 @@ static int wcn36xx_remove(struct platfor
+ 
+ 	return 0;
+ }
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
+ static const struct platform_device_id wcn36xx_platform_id_table[] = {
+ 	{
+ 		.name = "wcn36xx",
+@@ -1007,6 +1008,7 @@ static const struct platform_device_id w
+ 	{}
+ };
+ MODULE_DEVICE_TABLE(platform, wcn36xx_platform_id_table);
++#endif
+ 
+ static struct platform_driver wcn36xx_driver = {
+ 	.probe      = wcn36xx_probe,
+@@ -1015,7 +1017,9 @@ static struct platform_driver wcn36xx_dr
+ 		.name   = "wcn36xx",
+ 		.owner  = THIS_MODULE,
+ 	},
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
+ 	.id_table    = wcn36xx_platform_id_table,
++#endif
+ };
+ 
+ static int __init wcn36xx_init(void)
-- 
1.7.10.4

