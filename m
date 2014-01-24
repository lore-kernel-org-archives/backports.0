Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38651 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbaAXUjD (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 24 Jan 2014 15:39:03 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] backports: add DECLARE_SOCKADDR
Date: Fri, 24 Jan 2014 21:38:48 +0100
Message-Id: <1390595932-21877-2-git-send-email-hauke@hauke-m.de> (sfid-20140124_213904_844504_21EA9F00)
In-Reply-To: <1390595932-21877-1-git-send-email-hauke@hauke-m.de>
References: <1390595932-21877-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by net/bluetooth/l2cap_sock.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/net.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/net.h b/backport/backport-include/linux/net.h
index 9d7cbf5..07981da 100644
--- a/backport/backport-include/linux/net.h
+++ b/backport/backport-include/linux/net.h
@@ -41,4 +41,9 @@ do {								\
 	net_ratelimited_function(pr_debug, fmt, ##__VA_ARGS__)
 #endif
 
+#ifndef DECLARE_SOCKADDR
+#define DECLARE_SOCKADDR(type, dst, src)	\
+	type dst = ({ __sockaddr_check_size(sizeof(*dst)); (type) src; })
+#endif
+
 #endif /* __BACKPORT_LINUX_NET_H */
-- 
1.7.10.4

