Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:41284 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380Ab3JXTsR (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 24 Oct 2013 15:48:17 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] backports: refresh patches on next-20130920
Date: Thu, 24 Oct 2013 21:48:02 +0200
Message-Id: <1382644082-14032-4-git-send-email-hauke@hauke-m.de> (sfid-20131024_214819_009130_FCA255AE)
In-Reply-To: <1382644082-14032-1-git-send-email-hauke@hauke-m.de>
References: <1382644082-14032-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

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
16  3.0.98              [  OK  ]
17  3.1.10              [  OK  ]
18  3.10.14             [  OK  ]
19  3.11.3              [  OK  ]
20  3.12-rc3            [  OK  ]
21  3.2.51              [  OK  ]
22  3.3.8               [  OK  ]
23  3.4.64              [  OK  ]
24  3.5.7               [  OK  ]
25  3.6.11              [  OK  ]
26  3.7.10              [  OK  ]
27  3.8.13              [  OK  ]
28  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/collateral-evolutions/network/0001-netdev_ops/alx.patch    |    2 +-
 .../11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch      |    4 ++--
 .../network/16-bluetooth/net_bluetooth_l2cap_sock.patch            |    4 ++--
 .../network/16-bluetooth/net_bluetooth_rfcomm_sock.patch           |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch                    |    2 +-
 .../network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch      |    2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch b/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
index 465c4de..a0eca03 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1261,7 +1261,7 @@ static int alx_probe(struct pci_dev *pde
+@@ -1256,7 +1256,7 @@ static int alx_probe(struct pci_dev *pde
  		goto out_free_netdev;
  	}
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
index 318cc34..d2d6c0d 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1401,6 +1401,9 @@ static int alx_resume(struct device *dev
+@@ -1396,6 +1396,9 @@ static int alx_resume(struct device *dev
  	return __alx_open(alx, true);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(alx_pm_ops, alx_suspend, alx_resume);
  #define ALX_PM_OPS      (&alx_pm_ops)
  #else
-@@ -1503,7 +1506,12 @@ static struct pci_driver alx_driver = {
+@@ -1498,7 +1501,12 @@ static struct pci_driver alx_driver = {
  	.probe       = alx_probe,
  	.remove      = alx_remove,
  	.err_handler = &alx_err_handlers,
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
index 16bcee3..ff615f8 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
@@ -14,7 +14,7 @@
  {
  	struct sock *sk = sock->sk;
  	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-@@ -1231,8 +1236,12 @@ static struct sock *l2cap_sock_alloc(str
+@@ -1237,8 +1242,12 @@ static struct sock *l2cap_sock_alloc(str
  	return sk;
  }
  
@@ -27,7 +27,7 @@
  {
  	struct sock *sk;
  
-@@ -1244,7 +1253,11 @@ static int l2cap_sock_create(struct net
+@@ -1250,7 +1259,11 @@ static int l2cap_sock_create(struct net
  	    sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
  		return -ESOCKTNOSUPPORT;
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
index 8fe9af5..a370d93 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
@@ -14,7 +14,7 @@
  {
  	struct sock *sk;
  
-@@ -661,7 +666,11 @@ static int rfcomm_sock_setsockopt_old(st
+@@ -666,7 +671,11 @@ static int rfcomm_sock_setsockopt_old(st
  	return err;
  }
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
index 742ae0f..5360471 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
@@ -44,7 +44,7 @@
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller    = alx_poll_controller,
  #endif
-@@ -1303,7 +1317,11 @@ static int alx_probe(struct pci_dev *pde
+@@ -1298,7 +1312,11 @@ static int alx_probe(struct pci_dev *pde
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
index 2fd4eed..467d4c6 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/cdc_ether.c
 +++ b/drivers/net/usb/cdc_ether.c
-@@ -757,7 +757,9 @@ static struct usb_driver cdc_driver = {
+@@ -726,7 +726,9 @@ static struct usb_driver cdc_driver = {
  	.resume =	usbnet_resume,
  	.reset_resume =	usbnet_resume,
  	.supports_autosuspend = 1,
-- 
1.7.10.4

