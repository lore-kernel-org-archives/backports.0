Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44847 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbaFOVWM (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 5F6557E65
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:11 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/19] backports: add prandom_u32_max()
Date: Sun, 15 Jun 2014 23:21:32 +0200
Message-Id: <1402867307-31337-5-git-send-email-hauke@hauke-m.de> (sfid-20140615_232215_637957_B9F6A619)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added in:
commit f337db64af059c9a94278a8b0ab97d87259ff62f
Author: Daniel Borkmann <dborkman@redhat.com>
Date:   Wed Jan 22 02:29:39 2014 +0100

    random32: add prandom_u32_max and convert open coded users

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/random.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
index e915106..dd5f377 100644
--- a/backport/backport-include/linux/random.h
+++ b/backport/backport-include/linux/random.h
@@ -13,4 +13,24 @@
 void prandom_bytes(void *buf, int bytes);
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+/**
+ * prandom_u32_max - returns a pseudo-random number in interval [0, ep_ro)
+ * @ep_ro: right open interval endpoint
+ *
+ * Returns a pseudo-random number that is in interval [0, ep_ro). Note
+ * that the result depends on PRNG being well distributed in [0, ~0U]
+ * u32 space. Here we use maximally equidistributed combined Tausworthe
+ * generator, that is, prandom_u32(). This is useful when requesting a
+ * random index of an array containing ep_ro elements, for example.
+ *
+ * Returns: pseudo-random number in interval [0, ep_ro)
+ */
+#define prandom_u32_max LINUX_BACKPORT(prandom_u32_max)
+static inline u32 prandom_u32_max(u32 ep_ro)
+{
+	return (u32)(((u64) prandom_u32() * ep_ro) >> 32);
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
+
 #endif /* __BACKPORT_RANDOM_H */
-- 
1.9.1

