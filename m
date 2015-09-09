Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:50243 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbbIIJ2B (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 9 Sep 2015 05:28:01 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] backports: add spatch to handle IFF_NO_QUEUE
Date: Wed,  9 Sep 2015 11:27:55 +0200
Message-Id: <1441790875-8496-1-git-send-email-johannes@sipsolutions.net> (sfid-20150909_112804_444554_0C9FFB75)
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
index 000000000000..9c95b853df18
--- /dev/null
+++ b/patches/collateral-evolutions/network/0062-iff-no-queue.cocci
@@ -0,0 +1,9 @@
+@@
+expression E;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
+ E->priv_flags |= IFF_NO_QUEUE;
++#else
++E->tx_queue_len = 0;
++#endif
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
