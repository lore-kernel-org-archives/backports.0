Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48707 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbbF1V7c (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/14] patches: use old locking for struct tty_struct
Date: Sun, 28 Jun 2015 23:59:14 +0200
Message-Id: <1435528760-19913-9-git-send-email-hauke@hauke-m.de> (sfid-20150628_235940_402030_DAE32FAE)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

With kernel 3.12 a new locking was added to struct tty_struct. This
patch makes the code use the old locking.

The new locking was added in this commit:
commit 6a1c0680cf3ba94356ecd58833e1540c93472a57
Author: Peter Hurley <peter@hurleysoftware.com>
Date:   Sat Jun 15 09:14:23 2013 -0400

    tty: Convert termios_mutex to termios_rwsem

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0061-termios_rwsem/INFO                  | 11 +++++++++++
 .../network/0061-termios_rwsem/nfc.patch             | 20 ++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0061-termios_rwsem/INFO
 create mode 100644 patches/collateral-evolutions/network/0061-termios_rwsem/nfc.patch

diff --git a/patches/collateral-evolutions/network/0061-termios_rwsem/INFO b/patches/collateral-evolutions/network/0061-termios_rwsem/INFO
new file mode 100644
index 0000000..296b219
--- /dev/null
+++ b/patches/collateral-evolutions/network/0061-termios_rwsem/INFO
@@ -0,0 +1,11 @@
+use old locking for struct tty_struct
+
+With kernel 3.12 a new locking was added to struct tty_struct. This
+patch makes the code use the old locking.
+
+The new locking was added in this commit:
+commit 6a1c0680cf3ba94356ecd58833e1540c93472a57
+Author: Peter Hurley <peter@hurleysoftware.com>
+Date:   Sat Jun 15 09:14:23 2013 -0400
+
+    tty: Convert termios_mutex to termios_rwsem
diff --git a/patches/collateral-evolutions/network/0061-termios_rwsem/nfc.patch b/patches/collateral-evolutions/network/0061-termios_rwsem/nfc.patch
new file mode 100644
index 0000000..4829bee
--- /dev/null
+++ b/patches/collateral-evolutions/network/0061-termios_rwsem/nfc.patch
@@ -0,0 +1,20 @@
+--- a/net/nfc/nci/uart.c
++++ b/net/nfc/nci/uart.c
+@@ -446,9 +446,17 @@ void nci_uart_set_config(struct nci_uart
+ 	if (!nu->tty)
+ 		return;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
+ 	down_read(&nu->tty->termios_rwsem);
++#else
++	mutex_lock(&nu->tty->termios_mutex);
++#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0) */
+ 	new_termios = nu->tty->termios;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
+ 	up_read(&nu->tty->termios_rwsem);
++#else
++	mutex_unlock(&nu->tty->termios_mutex);
++#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0) */
+ 	tty_termios_encode_baud_rate(&new_termios, baudrate, baudrate);
+ 
+ 	if (flow_ctrl)
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
