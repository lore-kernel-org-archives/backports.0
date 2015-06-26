Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:36024 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbbFZWUi (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 26 Jun 2015 18:20:38 -0400
Received: by lacny3 with SMTP id ny3so71099160lac.3
        for <backports@vger.kernel.org>; Fri, 26 Jun 2015 15:20:36 -0700 (PDT)
From: Florian Grandel <fgrandel@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Subject: [PATCH] patches: backport termios usage in hci_ldisc
Date: Sat, 27 Jun 2015 00:20:30 +0200
Message-Id: <1435357230-9712-1-git-send-email-fgrandel@gmail.com> (sfid-20150627_002040_549084_DCF9BEB4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The file net/bluetooth/hci_ldisc.c contains references to tty->termios.
These changed from pointer to instance in 3.7.0. This patch backports
all references by introducing kernel version defines.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 .../0020-tty-termios/net_bluetooth_hci_ldisc.patch | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_hci_ldisc.patch

diff --git a/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_hci_ldisc.patch b/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_hci_ldisc.patch
new file mode 100644
index 0000000..a658f26
--- /dev/null
+++ b/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_hci_ldisc.patch
@@ -0,0 +1,67 @@
+--- a/drivers/bluetooth/hci_ldisc.c
++++ b/drivers/bluetooth/hci_ldisc.c
+@@ -24,6 +24,7 @@
+  */
+ 
+ #include <linux/module.h>
++#include <linux/version.h>
+ 
+ #include <linux/kernel.h>
+ #include <linux/init.h>
+@@ -277,7 +278,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
+ 
+ 	if (enable) {
+ 		/* Disable hardware flow control */
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
+ 		ktermios = tty->termios;
++#else
++		ktermios = *tty->termios;
++#endif
+ 		ktermios.c_cflag &= ~CRTSCTS;
+ 		status = tty_set_termios(tty, &ktermios);
+ 		BT_DBG("Disabling hardware flow control: %s",
+@@ -311,7 +316,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
+ 		BT_DBG("Setting RTS: %s", status ? "failed" : "success");
+ 
+ 		/* Re-enable hardware flow control */
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
+ 		ktermios = tty->termios;
++#else
++		ktermios = *tty->termios;
++#endif
+ 		ktermios.c_cflag |= CRTSCTS;
+ 		status = tty_set_termios(tty, &ktermios);
+ 		BT_DBG("Enabling hardware flow control: %s",
+@@ -332,7 +341,11 @@ void hci_uart_init_tty(struct hci_uart *hu)
+ 	struct ktermios ktermios;
+ 
+ 	/* Bring the UART into a known 8 bits no parity hw fc state */
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
+ 	ktermios = tty->termios;
++#else
++	ktermios = *tty->termios;
++#endif
+ 	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP |
+ 			      INLCR | IGNCR | ICRNL | IXON);
+ 	ktermios.c_oflag &= ~OPOST;
+@@ -350,7 +363,11 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
+ 	struct tty_struct *tty = hu->tty;
+ 	struct ktermios ktermios;
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
+ 	ktermios = tty->termios;
++#else
++	ktermios = *tty->termios;
++#endif
+ 	ktermios.c_cflag &= ~CBAUD;
+ 	tty_termios_encode_baud_rate(&ktermios, speed, speed);
+ 
+@@ -358,7 +375,7 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
+ 	tty_set_termios(tty, &ktermios);
+ 
+ 	BT_DBG("%s: New tty speeds: %d/%d", hu->hdev->name,
+-	       tty->termios.c_ispeed, tty->termios.c_ospeed);
++	       ktermios.c_ispeed, ktermios.c_ospeed);
+ }
+ 
+ static int hci_uart_setup(struct hci_dev *hdev)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
