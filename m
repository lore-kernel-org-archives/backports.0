Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51556 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbcBOPZM (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Feb 2016 10:25:12 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/12] patches: refresh on next-20160122
Date: Mon, 15 Feb 2016 16:24:59 +0100
Message-Id: <1455549899-14564-13-git-send-email-hauke@hauke-m.de> (sfid-20160215_184436_807323_7B67F5C1)
In-Reply-To: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
References: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.76              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.110             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.96             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.53             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.60             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.26             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.9               [  OK  ]
22  4.1.17              [  OK  ]
23  4.2.8               [  OK  ]
24  4.3.5               [  OK  ]
25  4.4.1               [  OK  ]
26  4.5-rc3             [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0010-add-wext-handlers-to-netdev/net_wireless_core.patch        | 4 ++--
 .../network/0013-fix-makefile-includes/st-nci-spi.patch             | 6 +++---
 .../network/0055-name_assign_type/brcmfmac.patch                    | 2 +-
 .../network/0062-acpi-gpio-remove/hci_bcm.patch                     | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index f20427d..ccc1fab 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -423,10 +423,6 @@ use_default_name:
+@@ -433,10 +433,6 @@ use_default_name:
  	INIT_WORK(&rdev->mlme_unreg_wk, cfg80211_mlme_unreg_wk);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1026,6 +1022,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1036,6 +1032,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/st-nci-spi.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/st-nci-spi.patch
index b0ff25b..1ecd161 100644
--- a/patches/collateral-evolutions/network/0013-fix-makefile-includes/st-nci-spi.patch
+++ b/patches/collateral-evolutions/network/0013-fix-makefile-includes/st-nci-spi.patch
@@ -1,10 +1,10 @@
 --- a/drivers/nfc/st-nci/spi.c
 +++ b/drivers/nfc/st-nci/spi.c
-@@ -20,6 +20,7 @@
- #include <linux/module.h>
+@@ -21,6 +21,7 @@
  #include <linux/spi/spi.h>
  #include <linux/gpio.h>
+ #include <linux/gpio/consumer.h>
 +#include <linux/of.h>
  #include <linux/of_irq.h>
  #include <linux/of_gpio.h>
- #include <linux/interrupt.h>
+ #include <linux/acpi.h>
diff --git a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
index 12f5586..b8213bc 100644
--- a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
+++ b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
-@@ -2197,7 +2197,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+@@ -2198,7 +2198,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
diff --git a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
index 24e829c..7df646f 100644
--- a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
+++ b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
@@ -64,9 +64,9 @@
 -#ifdef CONFIG_ACPI
 +#if defined(CONFIG_ACPI) && LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
  static const struct acpi_device_id bcm_acpi_match[] = {
+ 	{ "BCM2E1A", 0 },
  	{ "BCM2E39", 0 },
- 	{ "BCM2E65", 0 },
-@@ -833,7 +841,9 @@ static struct platform_driver bcm_driver
+@@ -840,7 +848,9 @@ static struct platform_driver bcm_driver
  	.remove = bcm_remove,
  	.driver = {
  		.name = "hci_bcm",
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
