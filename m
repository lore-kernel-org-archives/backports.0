Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:52108 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932493AbeCDW5s (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:48 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/14] header: types.h: add __poll_t
Date: Sun,  4 Mar 2018 23:57:08 +0100
Message-Id: <20180304225717.20890-6-hauke@hauke-m.de> (sfid-20180304_235757_553640_D25C6B26)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

__poll_t was added for kernel 4.15 in commit 8ced390c2b ("define
__poll_t, annotate constants"), add it here for older kernel versions.
Multiple drivers are using this type.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/types.h b/backport/backport-include/linux/types.h
index 160570b4..0671e140 100644
--- a/backport/backport-include/linux/types.h
+++ b/backport/backport-include/linux/types.h
@@ -7,4 +7,8 @@
 typedef __s64 time64_t;
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,16,0)
+typedef unsigned __poll_t;
+#endif
+
 #endif /* __BACKPORT_TYPES */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
