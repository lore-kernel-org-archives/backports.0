Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56020 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541Ab3DOUrs (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Apr 2013 16:47:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] backports: protect eth_hw_addr_random with LINUX_BACKPORT
Date: Mon, 15 Apr 2013 22:47:38 +0200
Message-Id: <1366058858-7535-1-git-send-email-hauke@hauke-m.de> (sfid-20130415_224751_726352_28E066BC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

debian kernel 3.2 backports eth_hw_addr_random and this collides with
our backport without this patch.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/etherdevice.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 03208b6..fc6803f 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -4,11 +4,13 @@
 #include <linux/version.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,12)
+#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
 static inline void eth_hw_addr_random(struct net_device *dev)
 {
 #error eth_hw_addr_random() needs to be implemented for < 2.6.12
 }
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
+#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
 static inline void eth_hw_addr_random(struct net_device *dev)
 {
 	get_random_bytes(dev->dev_addr, ETH_ALEN);
@@ -23,12 +25,14 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 #define NET_ADDR_RANDOM		1	/* address is generated randomly */
 #define NET_ADDR_STOLEN		2	/* address is stolen from other device */
 
+#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
 static inline void eth_hw_addr_random(struct net_device *dev)
 {
 	random_ether_addr(dev->dev_addr);
 }
 
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
 static inline void eth_hw_addr_random(struct net_device *dev)
 {
 	dev_hw_addr_random(dev, dev->dev_addr);
-- 
1.7.10.4

