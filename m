Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:37431 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689Ab3H0VfQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 17:35:16 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so5421948pdj.29
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 14:35:16 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 3/4] backports: refresh patches for next-20130802 again
Date: Tue, 27 Aug 2013 14:44:24 -0700
Message-Id: <1377639864-25672-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130827_233525_936233_2F4FF7F2)
In-Reply-To: <1377639864-25672-1-git-send-email-mcgrof@do-not-panic.com>
References: <1377639864-25672-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

For some reason some other changes were picked up again now.

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
16  3.0.79              [  OK  ]
17  3.1.10              [  OK  ]
18  3.10-rc1            [  OK  ]
19  3.2.45              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.46              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.13              [  OK  ]
26  3.9.3               [  OK  ]

real    34m47.737s
user    937m23.708s
sys     129m50.928s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch    |    4 ++--
 .../network/16-bluetooth/net_bluetooth_hci_sysfs.patch           |    2 +-
 .../network/16-bluetooth/net_bluetooth_rfcomm_tty.patch          |    6 +++---
 .../drivers_net_ethernet_atheros_alx_main.patch                  |    2 +-
 .../network/63-tty-termios/net_bluetooth_rfcomm_tty.patch        |    2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
index 0b32146..318cc34 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1403,6 +1403,9 @@ static int alx_resume(struct device *dev
+@@ -1401,6 +1401,9 @@ static int alx_resume(struct device *dev
  	return __alx_open(alx, true);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(alx_pm_ops, alx_suspend, alx_resume);
  #define ALX_PM_OPS      (&alx_pm_ops)
  #else
-@@ -1505,7 +1508,12 @@ static struct pci_driver alx_driver = {
+@@ -1503,7 +1506,12 @@ static struct pci_driver alx_driver = {
  	.probe       = alx_probe,
  	.remove      = alx_remove,
  	.err_handler = &alx_err_handlers,
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
index b4f7b1d..e78767e 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
@@ -12,7 +12,7 @@
  	&bt_link_group,
  	NULL
  };
-@@ -378,7 +386,11 @@ static struct attribute_group bt_host_gr
+@@ -378,7 +382,11 @@ static struct attribute_group bt_host_gr
  	.attrs = bt_host_attrs,
  };
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
index dac5ace..52e4945 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/rfcomm/tty.c
 +++ b/net/bluetooth/rfcomm/tty.c
-@@ -809,7 +817,11 @@ static int rfcomm_tty_write_room(struct
+@@ -809,7 +809,11 @@ static int rfcomm_tty_write_room(struct
  	return room;
  }
  
@@ -12,7 +12,7 @@
  {
  	BT_DBG("tty %p cmd 0x%02x", tty, cmd);
  
-@@ -1068,7 +1080,11 @@ static void rfcomm_tty_hangup(struct tty
+@@ -1068,7 +1072,11 @@ static void rfcomm_tty_hangup(struct tty
  	}
  }
  
@@ -24,7 +24,7 @@
  {
  	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
  
-@@ -1077,7 +1093,11 @@ static int rfcomm_tty_tiocmget(struct tt
+@@ -1077,7 +1085,11 @@ static int rfcomm_tty_tiocmget(struct tt
  	return dev->modem_status;
  }
  
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
index dbc4d50..742ae0f 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
@@ -44,7 +44,7 @@
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller    = alx_poll_controller,
  #endif
-@@ -1305,7 +1319,11 @@ static int alx_probe(struct pci_dev *pde
+@@ -1303,7 +1317,11 @@ static int alx_probe(struct pci_dev *pde
  		}
  	}
  
diff --git a/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
index f9a6c83..cfc21d5 100644
--- a/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
+++ b/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/rfcomm/tty.c
 +++ b/net/bluetooth/rfcomm/tty.c
-@@ -868,7 +868,11 @@ static int rfcomm_tty_ioctl(struct tty_s
+@@ -860,7 +860,11 @@ static int rfcomm_tty_ioctl(struct tty_s
  
  static void rfcomm_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
  {
-- 
1.7.10.4

