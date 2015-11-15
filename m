Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35567 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbbKOP5N (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:13 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/15] header: make inet_frags_init_net() return something
Date: Sun, 15 Nov 2015 16:56:53 +0100
Message-Id: <1447603019-11862-10-git-send-email-hauke@hauke-m.de> (sfid-20151115_171409_243367_5DCA4EA3)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The return type changed from void to int to return some error code.
Some code is now checking the return value which fails on older kernel
versions when the function returns void.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/inet_frag.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/net/inet_frag.h b/backport/backport-include/net/inet_frag.h
index f6bc6f1..055dae1 100644
--- a/backport/backport-include/net/inet_frag.h
+++ b/backport/backport-include/net/inet_frag.h
@@ -64,4 +64,13 @@ static inline void inet_frags_uninit_net(struct netns_frags *nf)
 }
 #endif /* < 4.4 && >= 3.9 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
+static inline int backport_inet_frags_init_net(struct netns_frags *nf)
+{
+	inet_frags_init_net(nf);
+	return 0;
+}
+#define inet_frags_init_net LINUX_BACKPORT(inet_frags_init_net)
+#endif /* < 4.4 */
+
 #endif /* __BACKPORT__NET_FRAG_H__ */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
