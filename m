Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35559 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbbKOP5O (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:14 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/15] patches: remove wpan_dev_hard_header() on kernel < 3.18
Date: Sun, 15 Nov 2015 16:56:56 +0100
Message-Id: <1447603019-11862-13-git-send-email-hauke@hauke-m.de> (sfid-20151115_171409_988438_DB6BA4C3)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

wpan_dev_hard_header() accesses ieee802154_ptr which is not available
on older kernel versions, remove this function on such kernel versions.
We do not compile cfg802154 on such kernel versions any way, but the
6lowpan stack uses this header file and we need 6lowpan for bluetooth.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0066-remove-netdev_ieee802154_ptr/cfg802154.patch  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0066-remove-netdev_ieee802154_ptr/cfg802154.patch

diff --git a/patches/collateral-evolutions/network/0066-remove-netdev_ieee802154_ptr/cfg802154.patch b/patches/collateral-evolutions/network/0066-remove-netdev_ieee802154_ptr/cfg802154.patch
new file mode 100644
index 0000000..25bf812
--- /dev/null
+++ b/patches/collateral-evolutions/network/0066-remove-netdev_ieee802154_ptr/cfg802154.patch
@@ -0,0 +1,18 @@
+--- a/include/net/cfg802154.h
++++ b/include/net/cfg802154.h
+@@ -359,6 +359,7 @@ struct wpan_dev {
+ 
+ #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+ static inline int
+ wpan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
+ 		     const struct ieee802154_addr *daddr,
+@@ -369,6 +370,7 @@ wpan_dev_hard_header(struct sk_buff *skb
+ 
+ 	return wpan_dev->header_ops->create(skb, dev, daddr, saddr, len);
+ }
++#endif /* >= 3.19 */
+ 
+ struct wpan_phy *
+ wpan_phy_new(const struct cfg802154_ops *ops, size_t priv_size);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
