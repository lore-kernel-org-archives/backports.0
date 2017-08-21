Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:42931 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754260AbdHUW2p (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:45 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/21] header: rename wait_queue_entry_t to wait_queue_t
Date: Tue, 22 Aug 2017 00:28:06 +0200
Message-Id: <20170821222817.17376-11-hauke@hauke-m.de> (sfid-20170822_002846_834093_B2F134B7)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 4.13 wait_queue_t was renamed to wait_queue_entry_t, reverse
this for older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/wait.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
index 3059ff1d..c4b1114e 100644
--- a/backport/backport-include/linux/wait.h
+++ b/backport/backport-include/linux/wait.h
@@ -76,4 +76,8 @@ wait_on_bit_timeout(void *word, int bit, unsigned mode, unsigned long timeout)
 #endif
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,13,0)
+#define wait_queue_entry_t wait_queue_t
+#endif
+
 #endif /* __BACKPORT_LINUX_WAIT_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
