Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35564 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbbKOP5N (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:13 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/15] header: add inet_frags_uninit_net()
Date: Sun, 15 Nov 2015 16:56:52 +0100
Message-Id: <1447603019-11862-9-git-send-email-hauke@hauke-m.de> (sfid-20151115_165716_666110_204803C4)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

inet_frags_uninit_net() was added in commit 1d6119baf06 "net: fix
percpu memory leaks" and is used by the 6lowpan part of ieee802154 in
backports.

percpu_counter_destroy() was added in kernel 3.9, so do not add this
function on older kernel versions. This is currently only used by the
6lowpan part of ieee802154 which is only activated for kernel >= 3.18.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/inet_frag.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/net/inet_frag.h b/backport/backport-include/net/inet_frag.h
index e36224e..f6bc6f1 100644
--- a/backport/backport-include/net/inet_frag.h
+++ b/backport/backport-include/net/inet_frag.h
@@ -55,4 +55,13 @@ static inline void add_frag_mem_limit(struct netns_frags *nf, int i)
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0)
+#define inet_frags_uninit_net LINUX_BACKPORT(inet_frags_uninit_net)
+static inline void inet_frags_uninit_net(struct netns_frags *nf)
+{
+	percpu_counter_destroy(&nf->mem);
+}
+#endif /* < 4.4 && >= 3.9 */
+
 #endif /* __BACKPORT__NET_FRAG_H__ */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
