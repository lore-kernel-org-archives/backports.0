Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38660 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbaAXUjM (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 24 Jan 2014 15:39:12 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] backports: refresh on next-20140124
Date: Fri, 24 Jan 2014 21:38:51 +0100
Message-Id: <1390595932-21877-5-git-send-email-hauke@hauke-m.de> (sfid-20140124_213914_127078_45826750)
In-Reply-To: <1390595932-21877-1-git-send-email-hauke@hauke-m.de>
References: <1390595932-21877-1-git-send-email-hauke@hauke-m.de>
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
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.2.54              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.77              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.27             [  OK  ]
27  3.11.10             [  OK  ]
28  3.12.8              [  OK  ]
29  3.13-rc8            [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../24-pcmcia/drivers_bluetooth_bluecard_cs.patch  |   26 ++++++++++----------
 .../24-pcmcia/drivers_bluetooth_bt3c_cs.patch      |   18 +++++++-------
 .../24-pcmcia/drivers_bluetooth_btuart_cs.patch    |   22 ++++++++---------
 .../24-pcmcia/drivers_bluetooth_dtl1_cs.patch      |   22 ++++++++---------
 .../regulator/0001-bt8xx-rename-dst-ops.patch      |   12 ++++-----
 5 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
index c21f22e..71375e7 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/bluecard_cs.c
 +++ b/drivers/bluetooth/bluecard_cs.c
-@@ -158,7 +158,12 @@ static void bluecard_detach(struct pcmci
+@@ -157,7 +157,12 @@ static void bluecard_detach(struct pcmci
  static void bluecard_activity_led_timeout(u_long arg)
  {
  	bluecard_info_t *info = (bluecard_info_t *)arg;
@@ -13,7 +13,7 @@
  
  	if (!test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
  		return;
-@@ -175,7 +180,11 @@ static void bluecard_activity_led_timeou
+@@ -174,7 +179,11 @@ static void bluecard_activity_led_timeou
  
  static void bluecard_enable_activity_led(bluecard_info_t *info)
  {
@@ -25,7 +25,7 @@
  
  	if (!test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
  		return;
-@@ -231,7 +240,11 @@ static void bluecard_write_wakeup(blueca
+@@ -230,7 +239,11 @@ static void bluecard_write_wakeup(blueca
  	}
  
  	do {
@@ -37,7 +37,7 @@
  		unsigned int offset;
  		unsigned char command;
  		unsigned long ready_bit;
-@@ -378,7 +391,11 @@ static void bluecard_receive(bluecard_in
+@@ -377,7 +390,11 @@ static void bluecard_receive(bluecard_in
  		return;
  	}
  
@@ -49,7 +49,7 @@
  
  	if (test_bit(XMIT_SENDING_READY, &(info->tx_state)))
  		bluecard_enable_activity_led(info);
-@@ -506,7 +523,11 @@ static irqreturn_t bluecard_interrupt(in
+@@ -505,7 +522,11 @@ static irqreturn_t bluecard_interrupt(in
  	if (!test_bit(CARD_READY, &(info->hw_state)))
  		return IRQ_HANDLED;
  
@@ -61,7 +61,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -628,7 +649,11 @@ static int bluecard_hci_open(struct hci_
+@@ -627,7 +648,11 @@ static int bluecard_hci_open(struct hci_
  		return 0;
  
  	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
@@ -73,7 +73,7 @@
  
  		/* Enable LED */
  		outb(0x08 | 0x20, iobase + 0x30);
-@@ -648,7 +673,11 @@ static int bluecard_hci_close(struct hci
+@@ -647,7 +672,11 @@ static int bluecard_hci_close(struct hci
  	bluecard_hci_flush(hdev);
  
  	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
@@ -85,7 +85,7 @@
  
  		/* Disable LED */
  		outb(0x00, iobase + 0x30);
-@@ -690,7 +719,11 @@ static int bluecard_hci_send_frame(struc
+@@ -689,7 +718,11 @@ static int bluecard_hci_send_frame(struc
  
  static int bluecard_open(bluecard_info_t *info)
  {
@@ -97,7 +97,7 @@
  	struct hci_dev *hdev;
  	unsigned char id;
  
-@@ -805,7 +838,11 @@ static int bluecard_open(bluecard_info_t
+@@ -804,7 +837,11 @@ static int bluecard_open(bluecard_info_t
  
  static int bluecard_close(bluecard_info_t *info)
  {
@@ -109,7 +109,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -840,7 +877,18 @@ static int bluecard_probe(struct pcmcia_
+@@ -839,7 +876,18 @@ static int bluecard_probe(struct pcmcia_
  	info->p_dev = link;
  	link->priv = info;
  
@@ -128,7 +128,7 @@
  
  	return bluecard_config(link);
  }
-@@ -857,15 +905,30 @@ static int bluecard_config(struct pcmcia
+@@ -856,15 +904,30 @@ static int bluecard_config(struct pcmcia
  	bluecard_info_t *info = link->priv;
  	int i, n;
  
@@ -159,7 +159,7 @@
  		if (i == 0)
  			break;
  	}
-@@ -873,9 +936,15 @@ static int bluecard_config(struct pcmcia
+@@ -872,9 +935,15 @@ static int bluecard_config(struct pcmcia
  	if (i != 0)
  		goto failed;
  
@@ -175,7 +175,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -913,7 +982,13 @@ MODULE_DEVICE_TABLE(pcmcia, bluecard_ids
+@@ -912,7 +981,13 @@ MODULE_DEVICE_TABLE(pcmcia, bluecard_ids
  
  static struct pcmcia_driver bluecard_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
index d2b3221..7f7d693 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/bt3c_cs.c
 +++ b/drivers/bluetooth/bt3c_cs.c
-@@ -186,7 +186,11 @@ static void bt3c_write_wakeup(bt3c_info_
+@@ -185,7 +185,11 @@ static void bt3c_write_wakeup(bt3c_info_
  		return;
  
  	do {
@@ -12,7 +12,7 @@
  		register struct sk_buff *skb;
  		int len;
  
-@@ -224,7 +228,11 @@ static void bt3c_receive(bt3c_info_t *in
+@@ -223,7 +227,11 @@ static void bt3c_receive(bt3c_info_t *in
  		return;
  	}
  
@@ -24,7 +24,7 @@
  
  	avail = bt3c_read(iobase, 0x7006);
  	//printk("bt3c_cs: receiving %d bytes\n", avail);
-@@ -344,7 +352,11 @@ static irqreturn_t bt3c_interrupt(int ir
+@@ -343,7 +351,11 @@ static irqreturn_t bt3c_interrupt(int ir
  		/* our irq handler is shared */
  		return IRQ_NONE;
  
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -458,7 +470,11 @@ static int bt3c_load_firmware(bt3c_info_
+@@ -457,7 +469,11 @@ static int bt3c_load_firmware(bt3c_info_
  	unsigned int iobase, size, addr, fcs, tmp;
  	int i, err = 0;
  
@@ -48,7 +48,7 @@
  
  	/* Reset */
  	bt3c_io_write(iobase, 0x8040, 0x0404);
-@@ -629,8 +645,27 @@ static int bt3c_probe(struct pcmcia_devi
+@@ -628,8 +644,27 @@ static int bt3c_probe(struct pcmcia_devi
  	info->p_dev = link;
  	link->priv = info;
  
@@ -76,7 +76,7 @@
  
  	return bt3c_config(link);
  }
-@@ -641,6 +676,7 @@ static void bt3c_detach(struct pcmcia_de
+@@ -640,6 +675,7 @@ static void bt3c_detach(struct pcmcia_de
  	bt3c_release(link);
  }
  
@@ -84,7 +84,7 @@
  static int bt3c_check_config(struct pcmcia_device *p_dev, void *priv_data)
  {
  	int *try = priv_data;
-@@ -679,6 +715,63 @@ static int bt3c_check_config_notpicky(st
+@@ -678,6 +714,63 @@ static int bt3c_check_config_notpicky(st
  	}
  	return -ENODEV;
  }
@@ -148,7 +148,7 @@
  
  static int bt3c_config(struct pcmcia_device *link)
  {
-@@ -702,9 +795,15 @@ static int bt3c_config(struct pcmcia_dev
+@@ -701,9 +794,15 @@ static int bt3c_config(struct pcmcia_dev
  	goto failed;
  
  found_port:
@@ -164,7 +164,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -739,7 +838,13 @@ MODULE_DEVICE_TABLE(pcmcia, bt3c_ids);
+@@ -738,7 +837,13 @@ MODULE_DEVICE_TABLE(pcmcia, bt3c_ids);
  
  static struct pcmcia_driver bt3c_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
index be1a160..101014a 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btuart_cs.c
 +++ b/drivers/bluetooth/btuart_cs.c
-@@ -140,7 +140,11 @@ static void btuart_write_wakeup(btuart_i
+@@ -139,7 +139,11 @@ static void btuart_write_wakeup(btuart_i
  	}
  
  	do {
@@ -12,7 +12,7 @@
  		register struct sk_buff *skb;
  		int len;
  
-@@ -181,7 +185,11 @@ static void btuart_receive(btuart_info_t
+@@ -180,7 +184,11 @@ static void btuart_receive(btuart_info_t
  		return;
  	}
  
@@ -24,7 +24,7 @@
  
  	do {
  		info->hdev->stat.byte_rx++;
-@@ -294,7 +302,11 @@ static irqreturn_t btuart_interrupt(int
+@@ -293,7 +301,11 @@ static irqreturn_t btuart_interrupt(int
  		/* our irq handler is shared */
  		return IRQ_NONE;
  
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -351,7 +363,11 @@ static void btuart_change_speed(btuart_i
+@@ -350,7 +362,11 @@ static void btuart_change_speed(btuart_i
  		return;
  	}
  
@@ -48,7 +48,7 @@
  
  	spin_lock_irqsave(&(info->lock), flags);
  
-@@ -456,7 +472,11 @@ static int btuart_hci_send_frame(struct
+@@ -455,7 +471,11 @@ static int btuart_hci_send_frame(struct
  static int btuart_open(btuart_info_t *info)
  {
  	unsigned long flags;
@@ -60,7 +60,7 @@
  	struct hci_dev *hdev;
  
  	spin_lock_init(&(info->lock));
-@@ -522,7 +542,11 @@ static int btuart_open(btuart_info_t *in
+@@ -521,7 +541,11 @@ static int btuart_open(btuart_info_t *in
  static int btuart_close(btuart_info_t *info)
  {
  	unsigned long flags;
@@ -72,7 +72,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -558,8 +582,27 @@ static int btuart_probe(struct pcmcia_de
+@@ -557,8 +581,27 @@ static int btuart_probe(struct pcmcia_de
  	info->p_dev = link;
  	link->priv = info;
  
@@ -100,7 +100,7 @@
  
  	return btuart_config(link);
  }
-@@ -570,6 +613,7 @@ static void btuart_detach(struct pcmcia_
+@@ -569,6 +612,7 @@ static void btuart_detach(struct pcmcia_
  	btuart_release(link);
  }
  
@@ -108,7 +108,7 @@
  static int btuart_check_config(struct pcmcia_device *p_dev, void *priv_data)
  {
  	int *try = priv_data;
-@@ -608,6 +652,63 @@ static int btuart_check_config_notpicky(
+@@ -607,6 +651,63 @@ static int btuart_check_config_notpicky(
  	}
  	return -ENODEV;
  }
@@ -172,7 +172,7 @@
  
  static int btuart_config(struct pcmcia_device *link)
  {
-@@ -631,9 +732,15 @@ static int btuart_config(struct pcmcia_d
+@@ -630,9 +731,15 @@ static int btuart_config(struct pcmcia_d
  	goto failed;
  
  found_port:
@@ -188,7 +188,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -667,7 +774,13 @@ MODULE_DEVICE_TABLE(pcmcia, btuart_ids);
+@@ -666,7 +773,13 @@ MODULE_DEVICE_TABLE(pcmcia, btuart_ids);
  
  static struct pcmcia_driver btuart_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
index 4fccab6..9738e2d 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/dtl1_cs.c
 +++ b/drivers/bluetooth/dtl1_cs.c
-@@ -144,7 +144,11 @@ static void dtl1_write_wakeup(dtl1_info_
+@@ -143,7 +143,11 @@ static void dtl1_write_wakeup(dtl1_info_
  	}
  
  	do {
@@ -12,7 +12,7 @@
  		register struct sk_buff *skb;
  		int len;
  
-@@ -209,7 +213,11 @@ static void dtl1_receive(dtl1_info_t *in
+@@ -208,7 +212,11 @@ static void dtl1_receive(dtl1_info_t *in
  		return;
  	}
  
@@ -24,7 +24,7 @@
  
  	do {
  		info->hdev->stat.byte_rx++;
-@@ -295,7 +303,11 @@ static irqreturn_t dtl1_interrupt(int ir
+@@ -294,7 +302,11 @@ static irqreturn_t dtl1_interrupt(int ir
  		/* our irq handler is shared */
  		return IRQ_NONE;
  
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -436,7 +448,11 @@ static int dtl1_hci_send_frame(struct hc
+@@ -435,7 +447,11 @@ static int dtl1_hci_send_frame(struct hc
  static int dtl1_open(dtl1_info_t *info)
  {
  	unsigned long flags;
@@ -48,7 +48,7 @@
  	struct hci_dev *hdev;
  
  	spin_lock_init(&(info->lock));
-@@ -479,8 +495,13 @@ static int dtl1_open(dtl1_info_t *info)
+@@ -478,8 +494,13 @@ static int dtl1_open(dtl1_info_t *info)
  	outb(UART_LCR_WLEN8, iobase + UART_LCR);	/* Reset DLAB */
  	outb((UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2), iobase + UART_MCR);
  
@@ -62,7 +62,7 @@
  
  	/* Turn on interrupts */
  	outb(UART_IER_RLSI | UART_IER_RDI | UART_IER_THRI, iobase + UART_IER);
-@@ -505,7 +526,11 @@ static int dtl1_open(dtl1_info_t *info)
+@@ -504,7 +525,11 @@ static int dtl1_open(dtl1_info_t *info)
  static int dtl1_close(dtl1_info_t *info)
  {
  	unsigned long flags;
@@ -74,7 +74,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -541,7 +566,24 @@ static int dtl1_probe(struct pcmcia_devi
+@@ -540,7 +565,24 @@ static int dtl1_probe(struct pcmcia_devi
  	info->p_dev = link;
  	link->priv = info;
  
@@ -99,7 +99,7 @@
  
  	return dtl1_config(link);
  }
-@@ -555,6 +597,7 @@ static void dtl1_detach(struct pcmcia_de
+@@ -554,6 +596,7 @@ static void dtl1_detach(struct pcmcia_de
  	pcmcia_disable_device(link);
  }
  
@@ -107,7 +107,7 @@
  static int dtl1_confcheck(struct pcmcia_device *p_dev, void *priv_data)
  {
  	if ((p_dev->resource[1]->end) || (p_dev->resource[1]->end < 8))
-@@ -565,6 +608,29 @@ static int dtl1_confcheck(struct pcmcia_
+@@ -564,6 +607,29 @@ static int dtl1_confcheck(struct pcmcia_
  
  	return pcmcia_request_io(p_dev);
  }
@@ -137,7 +137,7 @@
  
  static int dtl1_config(struct pcmcia_device *link)
  {
-@@ -572,14 +638,24 @@ static int dtl1_config(struct pcmcia_dev
+@@ -571,14 +637,24 @@ static int dtl1_config(struct pcmcia_dev
  	int ret;
  
  	/* Look for a generic full-sized window */
@@ -162,7 +162,7 @@
  
  	ret = pcmcia_enable_device(link);
  	if (ret)
-@@ -607,7 +683,13 @@ MODULE_DEVICE_TABLE(pcmcia, dtl1_ids);
+@@ -606,7 +682,13 @@ MODULE_DEVICE_TABLE(pcmcia, dtl1_ids);
  
  static struct pcmcia_driver dtl1_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/regulator/0001-bt8xx-rename-dst-ops.patch b/patches/collateral-evolutions/regulator/0001-bt8xx-rename-dst-ops.patch
index 2e8e1b3..6472dc0 100644
--- a/patches/collateral-evolutions/regulator/0001-bt8xx-rename-dst-ops.patch
+++ b/patches/collateral-evolutions/regulator/0001-bt8xx-rename-dst-ops.patch
@@ -3,7 +3,7 @@ names and another symbol from older kernels.
 
 --- a/drivers/media/pci/bt8xx/dst.c
 +++ b/drivers/media/pci/bt8xx/dst.c
-@@ -1544,7 +1544,7 @@ static int dst_send_burst(struct dvb_fro
+@@ -1543,7 +1543,7 @@ static int dst_send_burst(struct dvb_fro
  }
  
  
@@ -12,7 +12,7 @@ names and another symbol from older kernels.
  {
  	struct dst_state *state = fe->demodulator_priv;
  
-@@ -1707,7 +1707,7 @@ static int dst_get_frontend(struct dvb_f
+@@ -1706,7 +1706,7 @@ static int dst_get_frontend(struct dvb_f
  	return 0;
  }
  
@@ -21,7 +21,7 @@ names and another symbol from older kernels.
  {
  	struct dst_state *state = fe->demodulator_priv;
  	if (state->dst_ca) {
-@@ -1776,8 +1776,8 @@ static struct dvb_frontend_ops dst_dvbt_
+@@ -1775,8 +1775,8 @@ static struct dvb_frontend_ops dst_dvbt_
  			FE_CAN_GUARD_INTERVAL_AUTO
  	},
  
@@ -32,7 +32,7 @@ names and another symbol from older kernels.
  	.tune = dst_tune_frontend,
  	.set_frontend = dst_set_frontend,
  	.get_frontend = dst_get_frontend,
-@@ -1801,8 +1801,8 @@ static struct dvb_frontend_ops dst_dvbs_
+@@ -1800,8 +1800,8 @@ static struct dvb_frontend_ops dst_dvbs_
  		.caps = FE_CAN_FEC_AUTO | FE_CAN_QPSK
  	},
  
@@ -43,7 +43,7 @@ names and another symbol from older kernels.
  	.tune = dst_tune_frontend,
  	.set_frontend = dst_set_frontend,
  	.get_frontend = dst_get_frontend,
-@@ -1834,8 +1834,8 @@ static struct dvb_frontend_ops dst_dvbc_
+@@ -1833,8 +1833,8 @@ static struct dvb_frontend_ops dst_dvbc_
  			FE_CAN_QAM_256
  	},
  
@@ -54,7 +54,7 @@ names and another symbol from older kernels.
  	.tune = dst_tune_frontend,
  	.set_frontend = dst_set_frontend,
  	.get_frontend = dst_get_frontend,
-@@ -1857,8 +1857,8 @@ static struct dvb_frontend_ops dst_atsc_
+@@ -1856,8 +1856,8 @@ static struct dvb_frontend_ops dst_atsc_
  		.caps = FE_CAN_FEC_AUTO | FE_CAN_QAM_AUTO | FE_CAN_QAM_64 | FE_CAN_QAM_256 | FE_CAN_8VSB
  	},
  
-- 
1.7.10.4

