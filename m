Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:36146 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab3JWVhN (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 17:37:13 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] backports: use correct suspend/resume function for rtl8188ee
Date: Wed, 23 Oct 2013 23:36:47 +0200
Message-Id: <1382564210-15230-6-git-send-email-hauke@hauke-m.de> (sfid-20131023_233715_166177_996E5235)
In-Reply-To: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
References: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The newly created function ends with _compat. This causes compile
warnings and probably runtime problems on kernel < 2.6.29.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch  |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch
index c377e12..219654d 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch
@@ -17,8 +17,8 @@
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
  	.driver.pm = &rtlwifi_pm_ops,
 +#elif defined(CONFIG_PM_SLEEP)
-+	.suspend = rtl_pci_suspend,
-+	.resume = rtl_pci_resume,
++	.suspend = rtl_pci_suspend_compat,
++	.resume = rtl_pci_resume_compat,
 +#endif
  };
  
-- 
1.7.10.4

