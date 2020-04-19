Return-Path: <SRS0=xZrn=6D=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EBBC5321D
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D3121473
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgDSRLD (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:11:03 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:13454 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgDSRLC (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 19 Apr 2020 13:11:02 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 494xDh59KYzKmTq;
        Sun, 19 Apr 2020 19:11:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 9im-G0QSj3Dd; Sun, 19 Apr 2020 19:10:57 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] backports: patches: handle txqueue parameter in ndo_tx_timeout
Date:   Sun, 19 Apr 2020 19:10:36 +0200
Message-Id: <20200419171039.17268-6-hauke@hauke-m.de>
In-Reply-To: <20200419171039.17268-1-hauke@hauke-m.de>
References: <20200419171039.17268-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F33C81769
X-Rspamd-Score: -5.67 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

In upstream commit 0290bd291cc0 ("netdev: pass the stuck queue to the
timeout handler") the ndo_tx_timeout callback in the net_device_ops
structure got a new parameter txqueue.

This patch changes the code to also work with the older interface where
no txqueue was provided. The functions are sometimes used by other
modules so add an EXPORT_SYMBOL_GPL to the spatch.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0094-ndo-tx-timeout.cocci         | 28 +++++++++++++++++++++++
 patches/0094-ndo-tx-timeout/orinoco.patch | 10 ++++++++
 patches/0094-ndo-tx-timeout/prism54.patch | 23 +++++++++++++++++++
 patches/0094-ndo-tx-timeout/usbnet.patch  | 10 ++++++++
 4 files changed, 71 insertions(+)
 create mode 100644 patches/0094-ndo-tx-timeout.cocci
 create mode 100644 patches/0094-ndo-tx-timeout/orinoco.patch
 create mode 100644 patches/0094-ndo-tx-timeout/prism54.patch
 create mode 100644 patches/0094-ndo-tx-timeout/usbnet.patch

diff --git a/patches/0094-ndo-tx-timeout.cocci b/patches/0094-ndo-tx-timeout.cocci
new file mode 100644
index 00000000..34904994
--- /dev/null
+++ b/patches/0094-ndo-tx-timeout.cocci
@@ -0,0 +1,28 @@
+@r@
+identifier OPS;
+identifier tx_timeout_fn;
+fresh identifier tx_timeout_fn_wrap = "bp_" ## tx_timeout_fn;
+position p;
+@@
+struct net_device_ops OPS@p = {
++#if LINUX_VERSION_IS_GEQ(5,6,0)
+	.ndo_tx_timeout = tx_timeout_fn,
++#else
++	.ndo_tx_timeout = tx_timeout_fn_wrap,
++#endif
+};
+
+@@
+identifier r.tx_timeout_fn_wrap;
+identifier r.tx_timeout_fn;
+@@
+void tx_timeout_fn(...) {...}
++#if LINUX_VERSION_IS_LESS(5,6,0)
++/* Just declare it here to keep sparse happy */
++void tx_timeout_fn_wrap(struct net_device *dev);
++void tx_timeout_fn_wrap(struct net_device *dev)
++{
++	tx_timeout_fn(dev, 0);
++}
++EXPORT_SYMBOL_GPL(tx_timeout_fn_wrap);
++#endif
diff --git a/patches/0094-ndo-tx-timeout/orinoco.patch b/patches/0094-ndo-tx-timeout/orinoco.patch
new file mode 100644
index 00000000..bda0a6da
--- /dev/null
+++ b/patches/0094-ndo-tx-timeout/orinoco.patch
@@ -0,0 +1,10 @@
+--- a/drivers/net/wireless/intersil/orinoco/orinoco.h
++++ b/drivers/net/wireless/intersil/orinoco/orinoco.h
+@@ -208,6 +208,7 @@ int orinoco_stop(struct net_device *dev)
+ void orinoco_set_multicast_list(struct net_device *dev);
+ int orinoco_change_mtu(struct net_device *dev, int new_mtu);
+ void orinoco_tx_timeout(struct net_device *dev, unsigned int txqueue);
++void bp_orinoco_tx_timeout(struct net_device *dev);
+ 
+ /********************************************************************/
+ /* Locking and synchronization functions                            */
diff --git a/patches/0094-ndo-tx-timeout/prism54.patch b/patches/0094-ndo-tx-timeout/prism54.patch
new file mode 100644
index 00000000..d61d3402
--- /dev/null
+++ b/patches/0094-ndo-tx-timeout/prism54.patch
@@ -0,0 +1,23 @@
+--- a/drivers/net/wireless/intersil/prism54/islpci_eth.h
++++ b/drivers/net/wireless/intersil/prism54/islpci_eth.h
+@@ -54,6 +54,7 @@ void islpci_eth_cleanup_transmit(islpci_
+ netdev_tx_t islpci_eth_transmit(struct sk_buff *, struct net_device *);
+ int islpci_eth_receive(islpci_private *);
+ void islpci_eth_tx_timeout(struct net_device *, unsigned int txqueue);
++void bp_islpci_eth_tx_timeout(struct net_device *);
+ void islpci_do_reset_and_wake(struct work_struct *);
+ 
+ #endif				/* _ISL_GEN_H */
+--- a/drivers/net/wireless/intersil/prism54/islpci_eth.c
++++ b/drivers/net/wireless/intersil/prism54/islpci_eth.c
+@@ -491,3 +491,10 @@ islpci_eth_tx_timeout(struct net_device
+ 			"%s: tx_timeout, waiting for reset", ndev->name);
+ 	}
+ }
++
++#if LINUX_VERSION_IS_LESS(5,6,0)
++void bp_islpci_eth_tx_timeout(struct net_device *dev) {
++	islpci_eth_tx_timeout(dev, 0);
++}
++EXPORT_SYMBOL_GPL(bp_islpci_eth_tx_timeout);
++#endif
diff --git a/patches/0094-ndo-tx-timeout/usbnet.patch b/patches/0094-ndo-tx-timeout/usbnet.patch
new file mode 100644
index 00000000..3bd1facd
--- /dev/null
+++ b/patches/0094-ndo-tx-timeout/usbnet.patch
@@ -0,0 +1,10 @@
+--- a/include/linux/usb/usbnet.h
++++ b/include/linux/usb/usbnet.h
+@@ -254,6 +254,7 @@ extern int usbnet_stop(struct net_device
+ extern netdev_tx_t usbnet_start_xmit(struct sk_buff *skb,
+ 				     struct net_device *net);
+ extern void usbnet_tx_timeout(struct net_device *net, unsigned int txqueue);
++extern void bp_usbnet_tx_timeout(struct net_device *net);
+ extern int usbnet_change_mtu(struct net_device *net, int new_mtu);
+ 
+ extern int usbnet_get_endpoints(struct usbnet *, struct usb_interface *);
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
