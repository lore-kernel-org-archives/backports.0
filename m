Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40004 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561AbbDEWNa (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 5 Apr 2015 18:13:30 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/7] headers: add sock_skb_cb_check_size()
Date: Mon,  6 Apr 2015 00:13:14 +0200
Message-Id: <1428272000-19929-2-git-send-email-hauke@hauke-m.de> (sfid-20150406_001335_043181_317FF2D9)
In-Reply-To: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
References: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The bluetooth code needs this function. It was introduced in upstream
commit b4772ef87.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/sock.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index ec67b9e..1a0a415 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -38,4 +38,9 @@
 #define SOCK_SELECT_ERR_QUEUE (SOCK_QUEUE_SHRUNK + 14)
 #endif
 
+#ifndef sock_skb_cb_check_size
+#define sock_skb_cb_check_size(size) \
+	BUILD_BUG_ON((size) > FIELD_SIZEOF(struct sk_buff, cb))
+#endif
+
 #endif /* __BACKPORT_NET_SOCK_H */
-- 
1.9.1

