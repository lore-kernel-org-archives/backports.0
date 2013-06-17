Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44926 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933035Ab3FQNV2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 17 Jun 2013 09:21:28 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/7] backprots: add rounddown
Date: Mon, 17 Jun 2013 15:21:05 +0200
Message-Id: <1371475267-27179-5-git-send-email-hauke@hauke-m.de> (sfid-20130617_152148_273785_0F93D5E7)
In-Reply-To: <1371475267-27179-1-git-send-email-hauke@hauke-m.de>
References: <1371475267-27179-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

---
 backport/backport-include/linux/kernel.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 79ad889..42aa91d 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -271,6 +271,15 @@ int hex_to_bin(char ch);
 	__val > __max ? __max: __val; })
 #endif
 
+#ifndef rounddown
+#define rounddown(x, y) (				\
+{							\
+	typeof(x) __x = (x);				\
+	__x - (__x % (y));				\
+}							\
+)
+#endif /* rounddown */
+
 #endif /* __BACKPORT_KERNEL_H */
 
 /*
-- 
1.7.10.4

