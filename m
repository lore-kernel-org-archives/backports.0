Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:38113 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196AbbDGK7E (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Apr 2015 06:59:04 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: use spatch for __genl_const change
Date: Tue,  7 Apr 2015 12:58:54 +0200
Message-Id: <1428404334-32289-1-git-send-email-johannes@sipsolutions.net> (sfid-20150407_125906_831027_ECEDEA8B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

As newer versions of spatch are now capable of declaring an
attribute, use that feature to create an spatch for the change
that changes const to __genl_const.

This bumps the required version of coccinelle to 1.0.0-rc23
(which was released over three months ago.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py                                         |  2 +-
 .../network/0027-genl-const/genl-const.cocci       | 10 +++++
 .../network/0027-genl-const/hwsim.patch            | 20 ---------
 .../network/0027-genl-const/ieee802154.patch       | 20 ---------
 .../network/0027-genl-const/nfc.patch              | 20 ---------
 .../network/0027-genl-const/nl80211.patch          | 50 ----------------------
 6 files changed, 11 insertions(+), 111 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
 delete mode 100644 patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
 delete mode 100644 patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
 delete mode 100644 patches/collateral-evolutions/network/0027-genl-const/nfc.patch
 delete mode 100644 patches/collateral-evolutions/network/0027-genl-const/nl80211.patch

diff --git a/gentree.py b/gentree.py
index 8df390636e34..3ab2b0a4733e 100755
--- a/gentree.py
+++ b/gentree.py
@@ -625,7 +625,7 @@ def _main():
     # Our binary requirements go here
     req = reqs.Req()
     req.require('git')
-    req.coccinelle('1.0.0-rc21')
+    req.coccinelle('1.0.0-rc23')
     if not req.reqs_match():
         sys.exit(1)
 
diff --git a/patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci b/patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
new file mode 100644
index 000000000000..36c71d62c650
--- /dev/null
+++ b/patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
@@ -0,0 +1,10 @@
+@@
+attribute __genl_const;
+@@
+(
+-const struct genl_multicast_group
++__genl_const struct genl_multicast_group
+|
+-const struct genl_ops
++__genl_const struct genl_ops
+)
diff --git a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
deleted file mode 100644
index 0383c30eeaf6..000000000000
--- a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
+++ /dev/null
@@ -1,20 +0,0 @@
---- a/drivers/net/wireless/mac80211_hwsim.c
-+++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -493,7 +493,7 @@ enum hwsim_multicast_groups {
- 	HWSIM_MCGRP_CONFIG,
- };
- 
--static const struct genl_multicast_group hwsim_mcgrps[] = {
-+static __genl_const struct genl_multicast_group hwsim_mcgrps[] = {
- 	[HWSIM_MCGRP_CONFIG] = { .name = "config", },
- };
- 
-@@ -2945,7 +2945,7 @@ done:
- }
- 
- /* Generic Netlink operations array */
--static const struct genl_ops hwsim_ops[] = {
-+static __genl_const struct genl_ops hwsim_ops[] = {
- 	{
- 		.cmd = HWSIM_CMD_REGISTER,
- 		.policy = hwsim_genl_policy,
diff --git a/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch b/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
deleted file mode 100644
index b543c06ab2d7..000000000000
--- a/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
+++ /dev/null
@@ -1,20 +0,0 @@
---- a/net/ieee802154/netlink.c
-+++ b/net/ieee802154/netlink.c
-@@ -97,7 +97,7 @@ int ieee802154_nl_reply(struct sk_buff *
- 	return genlmsg_reply(msg, info);
- }
- 
--static const struct genl_ops ieee8021154_ops[] = {
-+static __genl_const struct genl_ops ieee8021154_ops[] = {
- 	/* see nl-phy.c */
- 	IEEE802154_DUMP(IEEE802154_LIST_PHY, ieee802154_list_phy,
- 			ieee802154_dump_phy),
-@@ -134,7 +134,7 @@ static const struct genl_ops ieee8021154
- 		      ieee802154_llsec_del_seclevel),
- };
- 
--static const struct genl_multicast_group ieee802154_mcgrps[] = {
-+static __genl_const struct genl_multicast_group ieee802154_mcgrps[] = {
- 	[IEEE802154_COORD_MCGRP] = { .name = IEEE802154_MCAST_COORD_NAME, },
- 	[IEEE802154_BEACON_MCGRP] = { .name = IEEE802154_MCAST_BEACON_NAME, },
- };
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nfc.patch b/patches/collateral-evolutions/network/0027-genl-const/nfc.patch
deleted file mode 100644
index 22a98ab1feea..000000000000
--- a/patches/collateral-evolutions/network/0027-genl-const/nfc.patch
+++ /dev/null
@@ -1,20 +0,0 @@
---- a/net/nfc/netlink.c
-+++ b/net/nfc/netlink.c
-@@ -28,7 +28,7 @@
- #include "nfc.h"
- #include "llcp.h"
- 
--static const struct genl_multicast_group nfc_genl_mcgrps[] = {
-+static __genl_const struct genl_multicast_group nfc_genl_mcgrps[] = {
- 	{ .name = NFC_GENL_MCAST_EVENT_NAME, },
- };
- 
-@@ -1489,7 +1489,7 @@ static int nfc_genl_se_io(struct sk_buff
- 	return nfc_se_io(dev, se_idx, apdu, apdu_len, se_io_cb, ctx);
- }
- 
--static const struct genl_ops nfc_genl_ops[] = {
-+static __genl_const struct genl_ops nfc_genl_ops[] = {
- 	{
- 		.cmd = NFC_CMD_GET_DEVICE,
- 		.doit = nfc_genl_get_device,
diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
deleted file mode 100644
index eb822b70edf3..000000000000
--- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
+++ /dev/null
@@ -1,50 +0,0 @@
---- a/net/wireless/nl80211.c
-+++ b/net/wireless/nl80211.c
-@@ -31,9 +31,9 @@ static int nl80211_crypto_settings(struc
- 				   struct cfg80211_crypto_settings *settings,
- 				   int cipher_limit);
- 
--static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
-+static int nl80211_pre_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
- 			    struct genl_info *info);
--static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
-+static void nl80211_post_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
- 			      struct genl_info *info);
- 
- /* the netlink family */
-@@ -58,7 +58,7 @@ enum nl80211_multicast_groups {
- 	NL80211_MCGRP_TESTMODE /* keep last - ifdef! */
- };
- 
--static const struct genl_multicast_group nl80211_mcgrps[] = {
-+static __genl_const struct genl_multicast_group nl80211_mcgrps[] = {
- 	[NL80211_MCGRP_CONFIG] = { .name = NL80211_MULTICAST_GROUP_CONFIG },
- 	[NL80211_MCGRP_SCAN] = { .name = NL80211_MULTICAST_GROUP_SCAN },
- 	[NL80211_MCGRP_REGULATORY] = { .name = NL80211_MULTICAST_GROUP_REG },
-@@ -10168,7 +10168,7 @@ static int nl80211_tdls_cancel_channel_s
- 					 NL80211_FLAG_CHECK_NETDEV_UP)
- #define NL80211_FLAG_CLEAR_SKB		0x20
- 
--static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
-+static int nl80211_pre_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
- 			    struct genl_info *info)
- {
- 	struct cfg80211_registered_device *rdev;
-@@ -10237,7 +10237,7 @@ static int nl80211_pre_doit(const struct
- 	return 0;
- }
- 
--static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
-+static void nl80211_post_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
- 			      struct genl_info *info)
- {
- 	if (info->user_ptr[1]) {
-@@ -10266,7 +10266,7 @@ static void nl80211_post_doit(const stru
- 	}
- }
- 
--static const struct genl_ops nl80211_ops[] = {
-+static __genl_const struct genl_ops nl80211_ops[] = {
- 	{
- 		.cmd = NL80211_CMD_GET_WIPHY,
- 		.doit = nl80211_get_wiphy,
-- 
2.1.4

