Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:36520 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933023AbbBIQVU (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 9 Feb 2015 11:21:20 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: script __genl_const change
Date: Mon,  9 Feb 2015 17:21:14 +0100
Message-Id: <1423498874-15610-1-git-send-email-johannes@sipsolutions.net> (sfid-20150209_172122_352631_042324BA)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Unfortunately, only very very new versions of spatch are capable
of declaring as an attribute __genl_const which is a define.

However, all the users of this actually follow a really simple
pattern "const struct genl_", so a simple sed line is actually
sufficient for this change.

Introduce the ability for running scripts in the backport and
use it to make this change in a more robust way that doesn't
break whenever changes are made in the code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py                                         | 33 ++++++++++++++
 .../network/0027-genl-const/genl-const.script      |  3 ++
 .../network/0027-genl-const/hwsim.patch            | 20 ---------
 .../network/0027-genl-const/ieee802154.patch       | 20 ---------
 .../network/0027-genl-const/nfc.patch              | 20 ---------
 .../network/0027-genl-const/nl80211.patch          | 50 ----------------------
 6 files changed, 36 insertions(+), 110 deletions(-)
 create mode 100755 patches/collateral-evolutions/network/0027-genl-const/genl-const.script
 delete mode 100644 patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
 delete mode 100644 patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
 delete mode 100644 patches/collateral-evolutions/network/0027-genl-const/nfc.patch
 delete mode 100644 patches/collateral-evolutions/network/0027-genl-const/nl80211.patch

diff --git a/gentree.py b/gentree.py
index 8df390636e34..92e727fc06a8 100755
--- a/gentree.py
+++ b/gentree.py
@@ -489,6 +489,7 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
     test_cocci_found = False
     patches = []
     sempatches = []
+    scripts = []
     for root, dirs, files in os.walk(os.path.join(source_dir, patch_src)):
         for f in files:
             if not test_cocci and f.endswith('.patch'):
@@ -503,6 +504,8 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
                     elif args.profile_cocci:
                         logwrite("Profiling Coccinelle SmPL patch: %s" % test_cocci)
                 sempatches.append(os.path.join(root, f))
+            if not test_cocci and f.endswith('.script'):
+                scripts.append(os.path.join(root, f))
     patches.sort()
     prefix_len = len(os.path.join(source_dir, patch_src)) + 1
     for pfile in patches:
@@ -621,6 +624,36 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
         logwrite('Done!')
         sys.exit(0)
 
+    for s in scripts:
+        print_name = s[prefix_len:]
+        if args.verbose:
+            logwrite("Applying script %s" % print_name)
+
+        process = subprocess.Popen([s], stdout=subprocess.PIPE,
+                                   stderr=subprocess.STDOUT, stdin=subprocess.PIPE,
+                                   close_fds=True, universal_newlines=True,
+                                   cwd=target_dir)
+        output = process.communicate(input=open(pfile, 'r').read())[0]
+        output = output.split('\n')
+        if output[-1] == '':
+            output = output[:-1]
+        if args.verbose:
+            for line in output:
+                logwrite('> %s' % line)
+        if process.returncode != 0:
+            if not args.verbose:
+                logwrite("Failed to run script %s" % print_name)
+                for line in output:
+                    logwrite('> %s' % line)
+            raise Exception('script failed')
+
+        # remove orig/rej files that patch sometimes creates
+        for root, dirs, files in os.walk(target_dir):
+            for f in files:
+                if f[-5:] == '.orig' or f[-4:] == '.rej':
+                    os.unlink(os.path.join(root, f))
+        git_debug_snapshot(args, "apply script %s" % (print_name, ))
+
 def _main():
     # Our binary requirements go here
     req = reqs.Req()
diff --git a/patches/collateral-evolutions/network/0027-genl-const/genl-const.script b/patches/collateral-evolutions/network/0027-genl-const/genl-const.script
new file mode 100755
index 000000000000..a7fb320424ae
--- /dev/null
+++ b/patches/collateral-evolutions/network/0027-genl-const/genl-const.script
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+find . -name '*.c' -o -name '*.h' | xargs -n1 sed -i 's/const struct genl_/__genl_const struct genl_/'
diff --git a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
deleted file mode 100644
index 9904c60afc2a..000000000000
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
-@@ -2941,7 +2941,7 @@ done:
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
index d69a140ec66f..000000000000
--- a/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
+++ /dev/null
@@ -1,20 +0,0 @@
---- a/net/ieee802154/netlink.c
-+++ b/net/ieee802154/netlink.c
-@@ -105,7 +105,7 @@ out:
- 	return -ENOBUFS;
- }
- 
--static const struct genl_ops ieee8021154_ops[] = {
-+static __genl_const struct genl_ops ieee8021154_ops[] = {
- 	/* see nl-phy.c */
- 	IEEE802154_DUMP(IEEE802154_LIST_PHY, ieee802154_list_phy,
- 			ieee802154_dump_phy),
-@@ -142,7 +142,7 @@ static const struct genl_ops ieee8021154
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
index 3735cb109b20..000000000000
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
-@@ -1440,7 +1440,7 @@ static int nfc_genl_se_io(struct sk_buff
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
index 21c2a86eda58..000000000000
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
-@@ -9938,7 +9938,7 @@ static int nl80211_tdls_cancel_channel_s
- 					 NL80211_FLAG_CHECK_NETDEV_UP)
- #define NL80211_FLAG_CLEAR_SKB		0x20
- 
--static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
-+static int nl80211_pre_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
- 			    struct genl_info *info)
- {
- 	struct cfg80211_registered_device *rdev;
-@@ -10007,7 +10007,7 @@ static int nl80211_pre_doit(const struct
- 	return 0;
- }
- 
--static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
-+static void nl80211_post_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
- 			      struct genl_info *info)
- {
- 	if (info->user_ptr[1]) {
-@@ -10036,7 +10036,7 @@ static void nl80211_post_doit(const stru
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

