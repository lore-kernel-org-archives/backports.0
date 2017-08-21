Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:42934 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754294AbdHUW2p (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:45 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/21] header: add get_random_u32()
Date: Tue, 22 Aug 2017 00:28:05 +0200
Message-Id: <20170821222817.17376-10-hauke@hauke-m.de> (sfid-20170822_002848_506623_E02510F3)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was renamed in upstream kernel and changed from unsigned int to u32.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/random.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
index a9dda73b..7d817d8b 100644
--- a/backport/backport-include/linux/random.h
+++ b/backport/backport-include/linux/random.h
@@ -42,4 +42,11 @@ static inline u32 prandom_u32_max(u32 ep_ro)
 }
 #endif /* LINUX_VERSION_IS_LESS(3,14,0) */
 
+#if LINUX_VERSION_IS_LESS(4,11,0)
+static inline u32 get_random_u32(void)
+{
+	return get_random_int();
+}
+#endif
+
 #endif /* __BACKPORT_RANDOM_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
