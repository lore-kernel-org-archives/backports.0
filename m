Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:57957 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbbEYVoO (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 25 May 2015 17:44:14 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] header: remove last parameter from sk_alloc()
Date: Mon, 25 May 2015 23:44:02 +0200
Message-Id: <1432590244-4101-2-git-send-email-hauke@hauke-m.de> (sfid-20150525_234417_744115_FE0F7735)
In-Reply-To: <1432590244-4101-1-git-send-email-hauke@hauke-m.de>
References: <1432590244-4101-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Linux commit 11aa9c28 added a new parameter to sk_alloc() which is not
available on older kernel versions. Just ignore it on these older
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/sock.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index 1a0a415..caca6d1 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -43,4 +43,8 @@
 	BUILD_BUG_ON((size) > FIELD_SIZEOF(struct sk_buff, cb))
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#define sk_alloc(net, family, priority, prot, kern) sk_alloc(net, family, priority, prot)
+#endif
+
 #endif /* __BACKPORT_NET_SOCK_H */
-- 
2.1.4

