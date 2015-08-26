Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:43497 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756038AbbHZHHO (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 26 Aug 2015 03:07:14 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: emmanuel.grumbach@intel.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add spatch to handle IFF_NO_QUEUE
Date: Wed, 26 Aug 2015 09:07:11 +0200
Message-Id: <1440572831-6075-1-git-send-email-johannes@sipsolutions.net> (sfid-20150826_090716_826305_AB1821E1)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This flag doesn't exist on newer kernels, but replaced the tx_queue_len
assignment, so can't just be backported to have no effect. Instead, add
a semantic patch that puts back the tx_queue_len=0 assignment on older
kernel versions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/collateral-evolutions/network/0062-iff-no-queue.cocci | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0062-iff-no-queue.cocci

diff --git a/patches/collateral-evolutions/network/0062-iff-no-queue.cocci b/patches/collateral-evolutions/network/0062-iff-no-queue.cocci
new file mode 100644
index 000000000000..984dcbe64bad
--- /dev/null
+++ b/patches/collateral-evolutions/network/0062-iff-no-queue.cocci
@@ -0,0 +1,9 @@
+@@
+expression E;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0)
+ E->priv_flags |= IFF_NO_QUEUE;
++#else
++E->tx_queue_len = 0;
++#endif
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
