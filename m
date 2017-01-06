Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:58768 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936774AbdAFKQ3 (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 6 Jan 2017 05:16:29 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: replace netlink_seq with spatch
Date: Fri,  6 Jan 2017 11:15:58 +0100
Message-Id: <20170106101558.372-1-johannes@sipsolutions.net> (sfid-20170106_111653_908970_8B0F9EA8)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Even if right now there's only a single instance of this, we can
make backports more robust by using an spatch for it instead of
a plain patch.

Change-Id: Ib709c254bfb02724e578f4a55e3b2391f61227f2
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/collateral-evolutions/network/0014-netlink_seq.cocci |  7 +++++++
 .../network/0014-netlink_seq/net_wireless_nl80211.patch      | 12 ------------
 2 files changed, 7 insertions(+), 12 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0014-netlink_seq.cocci
 delete mode 100644 patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch

diff --git a/patches/collateral-evolutions/network/0014-netlink_seq.cocci b/patches/collateral-evolutions/network/0014-netlink_seq.cocci
new file mode 100644
index 000000000000..4aa1f280d35c
--- /dev/null
+++ b/patches/collateral-evolutions/network/0014-netlink_seq.cocci
@@ -0,0 +1,7 @@
+@@
+struct netlink_callback *cb;
+expression E;
+@@
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
+	cb->seq = E;
++#endif
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
deleted file mode 100644
index 362c26c3c6db..000000000000
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/net/wireless/nl80211.c
-+++ b/net/wireless/nl80211.c
-@@ -6853,7 +6853,9 @@ static int nl80211_dump_scan(struct sk_b
- 	spin_lock_bh(&rdev->bss_lock);
- 	cfg80211_bss_expire(rdev);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
- 	cb->seq = rdev->bss_generation;
-+#endif
- 
- 	list_for_each_entry(scan, &rdev->bss_list, list) {
- 		if (++idx <= start)
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
