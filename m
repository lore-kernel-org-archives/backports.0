Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38656 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbaAXUjG (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 24 Jan 2014 15:39:06 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] backports: add __sockaddr_check_size()
Date: Fri, 24 Jan 2014 21:38:49 +0100
Message-Id: <1390595932-21877-3-git-send-email-hauke@hauke-m.de> (sfid-20140124_213907_620942_6D42EDBF)
In-Reply-To: <1390595932-21877-1-git-send-email-hauke@hauke-m.de>
References: <1390595932-21877-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by net/bluetooth/l2cap_sock.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/socket.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/socket.h b/backport/backport-include/linux/socket.h
index 4187af2..8b6453e 100644
--- a/backport/backport-include/linux/socket.h
+++ b/backport/backport-include/linux/socket.h
@@ -10,4 +10,9 @@
 #define SOL_NFC		280
 #endif
 
+#ifndef __sockaddr_check_size
+#define __sockaddr_check_size(size)	\
+	BUILD_BUG_ON(((size) > sizeof(struct __kernel_sockaddr_storage)))
+#endif
+
 #endif /* __BACKPORT_SOCKET_H */
-- 
1.7.10.4

