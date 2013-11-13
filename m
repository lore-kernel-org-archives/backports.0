Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:57407 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756293Ab3KMQIq (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 13 Nov 2013 11:08:46 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] backports: refresh on next-20131113
Date: Wed, 13 Nov 2013 17:08:38 +0100
Message-Id: <1384358918-20477-2-git-send-email-hauke@hauke-m.de> (sfid-20131113_170849_363843_BABE9093)
In-Reply-To: <1384358918-20477-1-git-send-email-hauke@hauke-m.de>
References: <1384358918-20477-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

== ckmake-report.log ==

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.10.17             [  OK  ]
19  3.11.6              [  OK  ]
20  3.12-rc7            [  OK  ]
21  3.2.52              [  OK  ]
22  3.3.8               [  OK  ]
23  3.4.67              [  OK  ]
24  3.5.7               [  OK  ]
25  3.6.11              [  OK  ]
26  3.7.10              [  OK  ]
27  3.8.13              [  OK  ]
28  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../06-header-changes/drivers_net_wireless_rtlwifi_base.patch      |    2 +-
 .../network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch |    4 ++--
 .../network/24-pcmcia/drivers_net_wireless_libertas_if_cs.patch    |    2 +-
 .../network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch        |    2 +-
 .../network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch        |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_rtlwifi_base.patch b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_rtlwifi_base.patch
index ea33c7d..d968ccb 100644
--- a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_rtlwifi_base.patch
+++ b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_rtlwifi_base.patch
@@ -6,5 +6,5 @@
  #include <linux/ip.h>
 +#include <linux/in.h>
  #include <linux/module.h>
+ #include <linux/udp.h>
  
- /*
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
index 5cf7fe8..4356f2e 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/pci.c
 +++ b/drivers/net/wireless/ath/ath9k/pci.c
-@@ -751,6 +751,9 @@ static int ath_pci_resume(struct device
+@@ -838,6 +838,9 @@ static int ath_pci_resume(struct device
  	return 0;
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(ath9k_pm_ops, ath_pci_suspend, ath_pci_resume);
  
  #define ATH9K_PM_OPS	(&ath9k_pm_ops)
-@@ -769,7 +772,12 @@ static struct pci_driver ath_pci_driver
+@@ -856,7 +859,12 @@ static struct pci_driver ath_pci_driver
  	.id_table   = ath_pci_id_table,
  	.probe      = ath_pci_probe,
  	.remove     = ath_pci_remove,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_libertas_if_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_libertas_if_cs.patch
index 79f18d6..4b01d60 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_libertas_if_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_libertas_if_cs.patch
@@ -147,7 +147,7 @@
  
  	/*
  	 * Most of the libertas cards can do unaligned register access, but some
-@@ -997,7 +1072,13 @@ MODULE_DEVICE_TABLE(pcmcia, if_cs_ids);
+@@ -998,7 +1073,13 @@ MODULE_DEVICE_TABLE(pcmcia, if_cs_ids);
  
  static struct pcmcia_driver lbs_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
index 3b7ee0e..cbe44c2 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/ath3k.c
 +++ b/drivers/bluetooth/ath3k.c
-@@ -505,7 +505,9 @@ static struct usb_driver ath3k_driver =
+@@ -507,7 +507,9 @@ static struct usb_driver ath3k_driver =
  	.probe		= ath3k_probe,
  	.disconnect	= ath3k_disconnect,
  	.id_table	= ath3k_table,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
index c2928b3..9cc0340 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1633,7 +1633,9 @@ static struct usb_driver btusb_driver =
+@@ -1634,7 +1634,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
-- 
1.7.10.4

