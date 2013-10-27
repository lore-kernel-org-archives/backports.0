Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49295 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754247Ab3J0Nkk (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Oct 2013 09:40:40 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] backports: refresh on next-20131018
Date: Sun, 27 Oct 2013 14:40:01 +0100
Message-Id: <1382881202-16709-5-git-send-email-hauke@hauke-m.de> (sfid-20131027_144042_571303_D3F81307)
In-Reply-To: <1382881202-16709-1-git-send-email-hauke@hauke-m.de>
References: <1382881202-16709-1-git-send-email-hauke@hauke-m.de>
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
 .../drivers_net_ethernet_atheros_alx_main.patch        |    4 ++--
 .../16-bluetooth/drivers_bluetooth_hci_ldisc.patch     |    4 ++--
 .../16-bluetooth/net_bluetooth_af_bluetooth.patch      |    2 +-
 .../16-bluetooth/net_bluetooth_l2cap_sock.patch        |    6 +++---
 .../16-bluetooth/net_bluetooth_rfcomm_sock.patch       |    4 ++--
 .../network/16-bluetooth/net_bluetooth_sco.patch       |    4 ++--
 .../24-pcmcia/drivers_bluetooth_bluecard_cs.patch      |   12 ++++++------
 .../network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch  |   12 ++++++------
 .../24-pcmcia/drivers_bluetooth_btuart_cs.patch        |   14 +++++++-------
 .../network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch  |   16 ++++++++--------
 .../network/24-pcmcia/drivers_ssb_main.patch           |    2 +-
 .../net_mac80211_ieee80211_i.patch                     |    2 +-
 .../52-tty-dev/drivers_bluetooth_hci_ldisc.patch       |    2 +-
 .../62-usb_driver_lpm/drivers_bluetooth_bfusb.patch    |    2 +-
 .../62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch   |    2 +-
 .../62-usb_driver_lpm/drivers_bluetooth_btusb.patch    |    2 +-
 .../62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch   |    2 +-
 .../network/77-led-blink-api/mac80211.patch            |    2 +-
 .../network/78-usb-sg/usbnet.patch                     |    2 +-
 19 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
index d2d6c0d..b4fbfac 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1396,6 +1396,9 @@ static int alx_resume(struct device *dev
+@@ -1395,6 +1395,9 @@ static int alx_resume(struct device *dev
  	return __alx_open(alx, true);
  }
  
@@ -10,7 +10,7 @@
  static SIMPLE_DEV_PM_OPS(alx_pm_ops, alx_suspend, alx_resume);
  #define ALX_PM_OPS      (&alx_pm_ops)
  #else
-@@ -1498,7 +1501,12 @@ static struct pci_driver alx_driver = {
+@@ -1497,7 +1500,12 @@ static struct pci_driver alx_driver = {
  	.probe       = alx_probe,
  	.remove      = alx_remove,
  	.err_handler = &alx_err_handlers,
diff --git a/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch b/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch
index 4fa1912..c81496b 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/hci_ldisc.c
 +++ b/drivers/bluetooth/hci_ldisc.c
-@@ -297,8 +297,13 @@ static int hci_uart_tty_open(struct tty_
+@@ -289,8 +289,13 @@ static int hci_uart_tty_open(struct tty_
  	/* FIXME: why is this needed. Note don't use ldisc_ref here as the
  	   open path is before the ldisc is referencable */
  
@@ -14,7 +14,7 @@
  	tty_driver_flush_buffer(tty);
  
  	return 0;
-@@ -527,7 +532,11 @@ static int hci_uart_tty_ioctl(struct tty
+@@ -519,7 +524,11 @@ static int hci_uart_tty_ioctl(struct tty
  		return hu->hdev_flags;
  
  	default:
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch
index 92852d3..04a1276 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch
@@ -25,7 +25,7 @@
  		if (!err)
  			bt_sock_reclassify_lock(sock->sk, proto);
  		module_put(bt_proto[proto]->owner);
-@@ -456,7 +464,11 @@ int bt_sock_ioctl(struct socket *sock, u
+@@ -463,7 +471,11 @@ int bt_sock_ioctl(struct socket *sock, u
  		if (sk->sk_state == BT_LISTEN)
  			return -EINVAL;
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
index 0182caa..3e87fac 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -575,8 +575,13 @@ static int l2cap_sock_setsockopt_old(str
+@@ -616,8 +616,13 @@ static int l2cap_sock_setsockopt_old(str
  	return err;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct sock *sk = sock->sk;
  	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-@@ -1228,8 +1233,12 @@ static struct sock *l2cap_sock_alloc(str
+@@ -1347,8 +1352,12 @@ static struct sock *l2cap_sock_alloc(str
  	return sk;
  }
  
@@ -27,7 +27,7 @@
  {
  	struct sock *sk;
  
-@@ -1241,7 +1250,11 @@ static int l2cap_sock_create(struct net
+@@ -1360,7 +1369,11 @@ static int l2cap_sock_create(struct net
  	    sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
  		return -ESOCKTNOSUPPORT;
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
index a370d93..231ce59 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/rfcomm/sock.c
 +++ b/net/bluetooth/rfcomm/sock.c
-@@ -304,8 +304,13 @@ static struct sock *rfcomm_sock_alloc(st
+@@ -305,8 +305,13 @@ static struct sock *rfcomm_sock_alloc(st
  	return sk;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct sock *sk;
  
-@@ -666,7 +671,11 @@ static int rfcomm_sock_setsockopt_old(st
+@@ -668,7 +673,11 @@ static int rfcomm_sock_setsockopt_old(st
  	return err;
  }
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
index bc0c128..4dc6998 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/sco.c
 +++ b/net/bluetooth/sco.c
-@@ -430,8 +430,12 @@ static struct sock *sco_sock_alloc(struc
+@@ -426,8 +426,12 @@ static struct sock *sco_sock_alloc(struc
  	return sk;
  }
  
@@ -13,7 +13,7 @@
  {
  	struct sock *sk;
  
-@@ -726,7 +730,11 @@ static int sco_sock_recvmsg(struct kiocb
+@@ -722,7 +726,11 @@ static int sco_sock_recvmsg(struct kiocb
  	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
  }
  
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
index 83be629..c21f22e 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
@@ -85,7 +85,7 @@
  
  		/* Disable LED */
  		outb(0x00, iobase + 0x30);
-@@ -698,7 +727,11 @@ static int bluecard_hci_send_frame(struc
+@@ -690,7 +719,11 @@ static int bluecard_hci_send_frame(struc
  
  static int bluecard_open(bluecard_info_t *info)
  {
@@ -97,7 +97,7 @@
  	struct hci_dev *hdev;
  	unsigned char id;
  
-@@ -813,7 +846,11 @@ static int bluecard_open(bluecard_info_t
+@@ -805,7 +838,11 @@ static int bluecard_open(bluecard_info_t
  
  static int bluecard_close(bluecard_info_t *info)
  {
@@ -109,7 +109,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -848,7 +885,18 @@ static int bluecard_probe(struct pcmcia_
+@@ -840,7 +877,18 @@ static int bluecard_probe(struct pcmcia_
  	info->p_dev = link;
  	link->priv = info;
  
@@ -128,7 +128,7 @@
  
  	return bluecard_config(link);
  }
-@@ -865,15 +913,30 @@ static int bluecard_config(struct pcmcia
+@@ -857,15 +905,30 @@ static int bluecard_config(struct pcmcia
  	bluecard_info_t *info = link->priv;
  	int i, n;
  
@@ -159,7 +159,7 @@
  		if (i == 0)
  			break;
  	}
-@@ -881,9 +944,15 @@ static int bluecard_config(struct pcmcia
+@@ -873,9 +936,15 @@ static int bluecard_config(struct pcmcia
  	if (i != 0)
  		goto failed;
  
@@ -175,7 +175,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -921,7 +990,13 @@ MODULE_DEVICE_TABLE(pcmcia, bluecard_ids
+@@ -913,7 +982,13 @@ MODULE_DEVICE_TABLE(pcmcia, bluecard_ids
  
  static struct pcmcia_driver bluecard_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
index 7af65a3..d2b3221 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -466,7 +478,11 @@ static int bt3c_load_firmware(bt3c_info_
+@@ -458,7 +470,11 @@ static int bt3c_load_firmware(bt3c_info_
  	unsigned int iobase, size, addr, fcs, tmp;
  	int i, err = 0;
  
@@ -48,7 +48,7 @@
  
  	/* Reset */
  	bt3c_io_write(iobase, 0x8040, 0x0404);
-@@ -637,8 +653,27 @@ static int bt3c_probe(struct pcmcia_devi
+@@ -629,8 +645,27 @@ static int bt3c_probe(struct pcmcia_devi
  	info->p_dev = link;
  	link->priv = info;
  
@@ -76,7 +76,7 @@
  
  	return bt3c_config(link);
  }
-@@ -649,6 +684,7 @@ static void bt3c_detach(struct pcmcia_de
+@@ -641,6 +676,7 @@ static void bt3c_detach(struct pcmcia_de
  	bt3c_release(link);
  }
  
@@ -84,7 +84,7 @@
  static int bt3c_check_config(struct pcmcia_device *p_dev, void *priv_data)
  {
  	int *try = priv_data;
-@@ -687,6 +723,63 @@ static int bt3c_check_config_notpicky(st
+@@ -679,6 +715,63 @@ static int bt3c_check_config_notpicky(st
  	}
  	return -ENODEV;
  }
@@ -148,7 +148,7 @@
  
  static int bt3c_config(struct pcmcia_device *link)
  {
-@@ -710,9 +803,15 @@ static int bt3c_config(struct pcmcia_dev
+@@ -702,9 +795,15 @@ static int bt3c_config(struct pcmcia_dev
  	goto failed;
  
  found_port:
@@ -164,7 +164,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -747,7 +846,13 @@ MODULE_DEVICE_TABLE(pcmcia, bt3c_ids);
+@@ -739,7 +838,13 @@ MODULE_DEVICE_TABLE(pcmcia, bt3c_ids);
  
  static struct pcmcia_driver bt3c_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
index 0579688..be1a160 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
@@ -48,7 +48,7 @@
  
  	spin_lock_irqsave(&(info->lock), flags);
  
-@@ -464,7 +480,11 @@ static int btuart_hci_send_frame(struct
+@@ -456,7 +472,11 @@ static int btuart_hci_send_frame(struct
  static int btuart_open(btuart_info_t *info)
  {
  	unsigned long flags;
@@ -60,7 +60,7 @@
  	struct hci_dev *hdev;
  
  	spin_lock_init(&(info->lock));
-@@ -530,7 +550,11 @@ static int btuart_open(btuart_info_t *in
+@@ -522,7 +542,11 @@ static int btuart_open(btuart_info_t *in
  static int btuart_close(btuart_info_t *info)
  {
  	unsigned long flags;
@@ -72,7 +72,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -566,8 +590,27 @@ static int btuart_probe(struct pcmcia_de
+@@ -558,8 +582,27 @@ static int btuart_probe(struct pcmcia_de
  	info->p_dev = link;
  	link->priv = info;
  
@@ -100,7 +100,7 @@
  
  	return btuart_config(link);
  }
-@@ -578,6 +621,7 @@ static void btuart_detach(struct pcmcia_
+@@ -570,6 +613,7 @@ static void btuart_detach(struct pcmcia_
  	btuart_release(link);
  }
  
@@ -108,7 +108,7 @@
  static int btuart_check_config(struct pcmcia_device *p_dev, void *priv_data)
  {
  	int *try = priv_data;
-@@ -616,6 +660,63 @@ static int btuart_check_config_notpicky(
+@@ -608,6 +652,63 @@ static int btuart_check_config_notpicky(
  	}
  	return -ENODEV;
  }
@@ -172,7 +172,7 @@
  
  static int btuart_config(struct pcmcia_device *link)
  {
-@@ -639,9 +740,15 @@ static int btuart_config(struct pcmcia_d
+@@ -631,9 +732,15 @@ static int btuart_config(struct pcmcia_d
  	goto failed;
  
  found_port:
@@ -188,7 +188,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -675,7 +782,13 @@ MODULE_DEVICE_TABLE(pcmcia, btuart_ids);
+@@ -667,7 +774,13 @@ MODULE_DEVICE_TABLE(pcmcia, btuart_ids);
  
  static struct pcmcia_driver btuart_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
index 39cb54b..4fccab6 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -444,7 +456,11 @@ static int dtl1_hci_send_frame(struct sk
+@@ -436,7 +448,11 @@ static int dtl1_hci_send_frame(struct hc
  static int dtl1_open(dtl1_info_t *info)
  {
  	unsigned long flags;
@@ -48,7 +48,7 @@
  	struct hci_dev *hdev;
  
  	spin_lock_init(&(info->lock));
-@@ -487,8 +503,13 @@ static int dtl1_open(dtl1_info_t *info)
+@@ -479,8 +495,13 @@ static int dtl1_open(dtl1_info_t *info)
  	outb(UART_LCR_WLEN8, iobase + UART_LCR);	/* Reset DLAB */
  	outb((UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2), iobase + UART_MCR);
  
@@ -62,7 +62,7 @@
  
  	/* Turn on interrupts */
  	outb(UART_IER_RLSI | UART_IER_RDI | UART_IER_THRI, iobase + UART_IER);
-@@ -513,7 +534,11 @@ static int dtl1_open(dtl1_info_t *info)
+@@ -505,7 +526,11 @@ static int dtl1_open(dtl1_info_t *info)
  static int dtl1_close(dtl1_info_t *info)
  {
  	unsigned long flags;
@@ -74,7 +74,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -549,7 +574,24 @@ static int dtl1_probe(struct pcmcia_devi
+@@ -541,7 +566,24 @@ static int dtl1_probe(struct pcmcia_devi
  	info->p_dev = link;
  	link->priv = info;
  
@@ -99,7 +99,7 @@
  
  	return dtl1_config(link);
  }
-@@ -563,6 +605,7 @@ static void dtl1_detach(struct pcmcia_de
+@@ -555,6 +597,7 @@ static void dtl1_detach(struct pcmcia_de
  	pcmcia_disable_device(link);
  }
  
@@ -107,7 +107,7 @@
  static int dtl1_confcheck(struct pcmcia_device *p_dev, void *priv_data)
  {
  	if ((p_dev->resource[1]->end) || (p_dev->resource[1]->end < 8))
-@@ -573,6 +616,29 @@ static int dtl1_confcheck(struct pcmcia_
+@@ -565,6 +608,29 @@ static int dtl1_confcheck(struct pcmcia_
  
  	return pcmcia_request_io(p_dev);
  }
@@ -137,7 +137,7 @@
  
  static int dtl1_config(struct pcmcia_device *link)
  {
-@@ -580,14 +646,24 @@ static int dtl1_config(struct pcmcia_dev
+@@ -572,14 +638,24 @@ static int dtl1_config(struct pcmcia_dev
  	int ret;
  
  	/* Look for a generic full-sized window */
@@ -162,7 +162,7 @@
  
  	ret = pcmcia_enable_device(link);
  	if (ret)
-@@ -615,7 +691,13 @@ MODULE_DEVICE_TABLE(pcmcia, dtl1_ids);
+@@ -607,7 +683,13 @@ MODULE_DEVICE_TABLE(pcmcia, dtl1_ids);
  
  static struct pcmcia_driver dtl1_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_ssb_main.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_ssb_main.patch
index 4c08c4e..3320cb1 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_ssb_main.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_ssb_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/ssb/main.c
 +++ b/drivers/ssb/main.c
-@@ -517,7 +517,11 @@ static int ssb_devices_register(struct s
+@@ -520,7 +520,11 @@ static int ssb_devices_register(struct s
  			break;
  		case SSB_BUSTYPE_PCMCIA:
  #ifdef CONFIG_SSB_PCMCIAHOST
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index 1f2540b..3e32c54 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -961,7 +961,12 @@ struct ieee80211_local {
+@@ -964,7 +964,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
diff --git a/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch b/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch
index 42f16cb..cd2be92 100644
--- a/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch
+++ b/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/hci_ldisc.c
 +++ b/drivers/bluetooth/hci_ldisc.c
-@@ -424,7 +424,10 @@ static int hci_uart_register_dev(struct
+@@ -416,7 +416,10 @@ static int hci_uart_register_dev(struct
  	hdev->close = hci_uart_close;
  	hdev->flush = hci_uart_flush;
  	hdev->send  = hci_uart_send_frame;
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch
index 1fbcc45..8e4518d 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/bfusb.c
 +++ b/drivers/bluetooth/bfusb.c
-@@ -738,7 +738,9 @@ static struct usb_driver bfusb_driver =
+@@ -730,7 +730,9 @@ static struct usb_driver bfusb_driver =
  	.probe		= bfusb_probe,
  	.disconnect	= bfusb_disconnect,
  	.id_table	= bfusb_table,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch
index 5006ab4..88253a1 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/bpa10x.c
 +++ b/drivers/bluetooth/bpa10x.c
-@@ -502,7 +502,9 @@ static struct usb_driver bpa10x_driver =
+@@ -503,7 +503,9 @@ static struct usb_driver bpa10x_driver =
  	.probe		= bpa10x_probe,
  	.disconnect	= bpa10x_disconnect,
  	.id_table	= bpa10x_table,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
index 5c57bf8..c2928b3 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1632,7 +1632,9 @@ static struct usb_driver btusb_driver =
+@@ -1633,7 +1633,9 @@ static struct usb_driver btusb_driver =
  #endif
  	.id_table	= btusb_table,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
index 60cd6c1..adfeb22 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/qmi_wwan.c
 +++ b/drivers/net/usb/qmi_wwan.c
-@@ -819,7 +819,9 @@ static struct usb_driver qmi_wwan_driver
+@@ -820,7 +820,9 @@ static struct usb_driver qmi_wwan_driver
  	.resume		      =	qmi_wwan_resume,
  	.reset_resume         = qmi_wwan_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
index 72f4248..c06ba67 100644
--- a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1103,6 +1103,9 @@ struct ieee80211_local {
+@@ -1106,6 +1106,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
index afea0cb..08499d8 100644
--- a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1788,7 +1806,9 @@ int usbnet_resume (struct usb_interface
+@@ -1790,7 +1808,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
-- 
1.7.10.4

