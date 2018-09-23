Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:38430 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbeIWXoA (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 19:44:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/10] backports: Remove NFC support
Date: Sun, 23 Sep 2018 19:45:27 +0200
Message-Id: <20180923174535.16198-3-hauke@hauke-m.de> (sfid-20180923_194548_296787_C5DEE45F)
In-Reply-To: <20180923174535.16198-1-hauke@hauke-m.de>
References: <20180923174535.16198-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I am not aware of any user of the NFC coded in backports, at least I
haven't seen any patches regarding this. Remove this code to reduce the
efforts needed in the backports project.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Kconfig.sources                         |  2 --
 backport/Makefile.kernel                         |  2 --
 backport/defconfigs/nfc                          | 20 ------------
 copy-list                                        | 10 ------
 dependencies                                     | 41 ------------------------
 patches/0013-fix-makefile-includes/mei_phy.patch | 10 ------
 patches/0059-uuid-in-mei/nfc.patch               | 32 ------------------
 patches/0061-termios_rwsem/nfc.patch             | 20 ------------
 patches/0081-proto_ops-accept/nfc.patch          | 16 ---------
 9 files changed, 153 deletions(-)
 delete mode 100644 backport/defconfigs/nfc
 delete mode 100644 patches/0013-fix-makefile-includes/mei_phy.patch
 delete mode 100644 patches/0059-uuid-in-mei/nfc.patch
 delete mode 100644 patches/0061-termios_rwsem/nfc.patch
 delete mode 100644 patches/0081-proto_ops-accept/nfc.patch

diff --git a/backport/Kconfig.sources b/backport/Kconfig.sources
index 3fc674e5..347f1c56 100644
--- a/backport/Kconfig.sources
+++ b/backport/Kconfig.sources
@@ -7,8 +7,6 @@ source "$BACKPORT_DIR/net/mac80211/Kconfig"
 source "$BACKPORT_DIR/drivers/net/wireless/Kconfig"
 source "$BACKPORT_DIR/drivers/net/usb/Kconfig"
 
-source "$BACKPORT_DIR/net/nfc/Kconfig"
-
 source "$BACKPORT_DIR/drivers/usb/class/Kconfig"
 
 source "$BACKPORT_DIR/drivers/staging/Kconfig"
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index e458f6d5..6a9b854a 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -41,8 +41,6 @@ obj-$(CPTCFG_CFG80211) += net/wireless/
 obj-$(CPTCFG_MAC80211) += net/mac80211/
 obj-$(CPTCFG_WLAN) += drivers/net/wireless/
 obj-$(CPTCFG_USB_NET_RNDIS_WLAN) += drivers/net/usb/
-obj-$(CPTCFG_NFC) += net/nfc/
-obj-$(CPTCFG_NFC) += drivers/nfc/
 
 obj-$(CPTCFG_USB_WDM) += drivers/usb/class/
 obj-$(CPTCFG_USB_USBNET) += drivers/net/usb/
diff --git a/backport/defconfigs/nfc b/backport/defconfigs/nfc
deleted file mode 100644
index c00f10fd..00000000
--- a/backport/defconfigs/nfc
+++ /dev/null
@@ -1,20 +0,0 @@
-CPTCFG_NFC=m
-CPTCFG_NFC_DIGITAL=m
-CPTCFG_NFC_HCI=m
-CPTCFG_NFC_MEI_PHY=m
-CPTCFG_NFC_MICROREAD=m
-CPTCFG_NFC_MICROREAD_I2C=m
-CPTCFG_NFC_MICROREAD_MEI=m
-CPTCFG_NFC_MRVL=m
-CPTCFG_NFC_MRVL_USB=m
-CPTCFG_NFC_NCI=m
-CPTCFG_NFC_NCI_SPI=y
-CPTCFG_NFC_PN533=m
-CPTCFG_NFC_PN544=m
-CPTCFG_NFC_PN544_I2C=m
-CPTCFG_NFC_PN544_MEI=m
-CPTCFG_NFC_PORT100=m
-CPTCFG_NFC_SHDLC=y
-CPTCFG_NFC_SIM=m
-CPTCFG_NFC_TRF7970A=m
-CPTCFG_NFC_WILINK=m
diff --git a/copy-list b/copy-list
index 7f552b8d..b2ec0972 100644
--- a/copy-list
+++ b/copy-list
@@ -124,13 +124,3 @@ drivers/net/usb/cdc_mbim.c
 drivers/net/usb/cdc_ncm.c
 drivers/net/usb/sierra_net.c
 drivers/net/usb/qmi_wwan.c
-
-# NFC core
-net/nfc/
-include/net/nfc/
-include/uapi/linux/nfc.h
-
-# NFC drivers
-drivers/nfc/
-include/linux/platform_data/nfcmrvl.h
-include/linux/platform_data/nxp-nci.h
diff --git a/dependencies b/dependencies
index a87802ad..74f8a80f 100644
--- a/dependencies
+++ b/dependencies
@@ -20,17 +20,6 @@ HOSTAP 3.10
 AIRO 3.9
 AIRO_CS 3.9
 
-# missing linux/property.h
-NFC_ST95HF 3.18
-
-# missing devm_gpiod_get_optional()
-# this needs devm_gpiod_get_optional() with 3 arguments.
-NFC_PN544_I2C 3.17
-NFC_TRF7970A 3.17
-
-# this needs devm_gpiod_get_index() with 4 arguments.
-NFC_NXP_NCI_I2C 3.17
-
 # pci_error_handlers->reset_notify is missing
 MWIFIEX_PCIE 3.16
 
@@ -41,33 +30,6 @@ QTNFMAC_PEARL_PCIE 3.13
 # backported properly
 MWIFIEX 3.18
 
-# this needs device_property..() functions and struct acpi_gpio_mapping
-NFC_FDP_I2C 3.19
-NFC_ST21NFCA_I2C 3.19
-NFC_ST_NCI_I2C 3.19
-NFC_ST_NCI_SPI 3.19
-NFC_PN544_I2C 3.19
-
-# NFC core needs PF_NFC defined in socket.h which was
-# only introduced in kernel 3.1
-NFC 3.1
-
-# This needs of_find_property() and devm_gpio_free()
-NFC_MRVL 3.3
-NFC_MRVL_USB 3.3
-NFC_MRVL_UART 3.3
-
-NFC_TRF7970A 3.4
-
-INTEL_IPS 3.2
-
-# needs mei_cldev_register_rx_cb
-NFC_MEI_PHY 4.10
-
-# missing linux/gpio/consumer.h
-NFC_PN544_I2C 3.13
-NFC_FDP 3.13
-
 # tracing results in compile errors
 ATH10K_TRACING 3.4
 ATH_TRACEPOINTS 3.1
@@ -84,9 +46,6 @@ IPW2200 4.3
 HOSTAP 4.3
 LIBERTAS 4.3
 
-# some prototypes changed - might be fixable but I'm lazy
-NFC_WILINK 4.8
-
 # struct ethtool_link_ksettings is missing, I'm lazy
 USB_USBNET 4.6
 USB_NET_RNDIS_WLAN 4.6
diff --git a/patches/0013-fix-makefile-includes/mei_phy.patch b/patches/0013-fix-makefile-includes/mei_phy.patch
deleted file mode 100644
index c05f6eac..00000000
--- a/patches/0013-fix-makefile-includes/mei_phy.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/drivers/nfc/mei_phy.c
-+++ b/drivers/nfc/mei_phy.c
-@@ -19,6 +19,7 @@
- #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
- 
- #include <linux/module.h>
-+#include <linux/sched.h>
- #include <linux/slab.h>
- #include <linux/nfc.h>
- 
diff --git a/patches/0059-uuid-in-mei/nfc.patch b/patches/0059-uuid-in-mei/nfc.patch
deleted file mode 100644
index 9953c819..00000000
--- a/patches/0059-uuid-in-mei/nfc.patch
+++ /dev/null
@@ -1,32 +0,0 @@
---- a/drivers/nfc/microread/mei.c
-+++ b/drivers/nfc/microread/mei.c
-@@ -67,7 +67,13 @@ static int microread_mei_remove(struct m
- }
- 
- static struct mei_cl_device_id microread_mei_tbl[] = {
-+#if LINUX_VERSION_IS_GEQ(4,4,0)
- 	{ MICROREAD_DRIVER_NAME, MEI_NFC_UUID, MEI_CL_VERSION_ANY},
-+#elif LINUX_VERSION_IS_GEQ(4,2,0)
-+	{ MICROREAD_DRIVER_NAME, MEI_NFC_UUID},
-+#else
-+	{ MICROREAD_DRIVER_NAME},
-+#endif
- 
- 	/* required last entry */
- 	{ }
---- a/drivers/nfc/pn544/mei.c
-+++ b/drivers/nfc/pn544/mei.c
-@@ -67,7 +67,13 @@ static int pn544_mei_remove(struct mei_c
- }
- 
- static struct mei_cl_device_id pn544_mei_tbl[] = {
-+#if LINUX_VERSION_IS_GEQ(4,4,0)
- 	{ PN544_DRIVER_NAME, MEI_NFC_UUID, MEI_CL_VERSION_ANY},
-+#elif LINUX_VERSION_IS_GEQ(4,2,0)
-+	{ PN544_DRIVER_NAME, MEI_NFC_UUID},
-+#else
-+	{ PN544_DRIVER_NAME},
-+#endif
- 
- 	/* required last entry */
- 	{ }
diff --git a/patches/0061-termios_rwsem/nfc.patch b/patches/0061-termios_rwsem/nfc.patch
deleted file mode 100644
index c8ad8b46..00000000
--- a/patches/0061-termios_rwsem/nfc.patch
+++ /dev/null
@@ -1,20 +0,0 @@
---- a/net/nfc/nci/uart.c
-+++ b/net/nfc/nci/uart.c
-@@ -439,9 +439,17 @@ void nci_uart_set_config(struct nci_uart
- 	if (!nu->tty)
- 		return;
- 
-+#if LINUX_VERSION_IS_GEQ(3,12,0)
- 	down_read(&nu->tty->termios_rwsem);
-+#else
-+	mutex_lock(&nu->tty->termios_mutex);
-+#endif /* if LINUX_VERSION_IS_GEQ(3,12,0) */
- 	new_termios = nu->tty->termios;
-+#if LINUX_VERSION_IS_GEQ(3,12,0)
- 	up_read(&nu->tty->termios_rwsem);
-+#else
-+	mutex_unlock(&nu->tty->termios_mutex);
-+#endif /* if LINUX_VERSION_IS_GEQ(3,12,0) */
- 	tty_termios_encode_baud_rate(&new_termios, baudrate, baudrate);
- 
- 	if (flow_ctrl)
diff --git a/patches/0081-proto_ops-accept/nfc.patch b/patches/0081-proto_ops-accept/nfc.patch
deleted file mode 100644
index 05b55805..00000000
--- a/patches/0081-proto_ops-accept/nfc.patch
+++ /dev/null
@@ -1,16 +0,0 @@
-diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
-index 043c6d3..5b4e44c 100644
---- a/net/nfc/llcp_sock.c
-+++ b/net/nfc/llcp_sock.c
-@@ -443,7 +443,11 @@ struct sock *nfc_llcp_accept_dequeue(str
- }
- 
- static int llcp_sock_accept(struct socket *sock, struct socket *newsock,
-+#if LINUX_VERSION_IS_GEQ(4,11,0)
- 			    int flags, bool kern)
-+#else
-+			    int flags)
-+#endif
- {
- 	DECLARE_WAITQUEUE(wait, current);
- 	struct sock *sk = sock->sk, *new_sk;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
