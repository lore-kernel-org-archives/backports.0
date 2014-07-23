Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55532 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933902AbaGWWLf (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:11:35 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/11] backports: backport __QUEUE_STATE_{DRV,STACK}_XOFF
Date: Thu, 24 Jul 2014 00:11:23 +0200
Message-Id: <1406153488-23896-7-git-send-email-hauke@hauke-m.de> (sfid-20140724_001140_425104_C45B9A01)
In-Reply-To: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
References: <1406153488-23896-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The old __QUEUE_STATE_XOFF was divided into __QUEUE_STATE_DRV_XOFF and
__QUEUE_STATE_STACK_XOFF, in this patch we map both to the old version
on old kernel vesions.

This backports this upstream commit:
commit 7346649826382b769cfadf4a2fe8a84d060c55e9
Author: Tom Herbert <therbert@google.com>
Date:   Mon Nov 28 16:32:44 2011 +0000

    net: Add queue state xoff flag for stack

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 6979758..e2161b7 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -157,4 +157,9 @@ static inline void netdev_reset_queue(struct net_device *dev_queue)
 #define IFF_UNICAST_FLT	0x20000		/* Supports unicast filtering	*/
 #endif
 
+#ifndef QUEUE_STATE_ANY_XOFF
+#define __QUEUE_STATE_DRV_XOFF __QUEUE_STATE_XOFF
+#define __QUEUE_STATE_STACK_XOFF __QUEUE_STATE_XOFF
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
1.9.1

