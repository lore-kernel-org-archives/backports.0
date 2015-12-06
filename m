Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37451 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbbLFNSh (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 6 Dec 2015 08:18:37 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/12] header: add sk_set_bit() and sk_clear_bit()
Date: Sun,  6 Dec 2015 14:18:25 +0100
Message-Id: <1449407908-15547-10-git-send-email-hauke@hauke-m.de> (sfid-20151206_141843_039754_52A77DFD)
In-Reply-To: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
References: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds the sk_set_bit() and sk_clear_bit() functions in addition to
the renaming of SOCK_ASYNC_NOSPACE and SOCK_ASYNC_WAITDATA. This is
needed since upstream commit 9cd3e072b0be "net: rename
SOCK_ASYNC_NOSPACE and SOCK_ASYNC_WAITDATA"

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/net.h |  7 +++++++
 backport/backport-include/net/sock.h  | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/backport/backport-include/linux/net.h b/backport/backport-include/linux/net.h
index 4d9250b..6d2af69 100644
--- a/backport/backport-include/linux/net.h
+++ b/backport/backport-include/linux/net.h
@@ -102,4 +102,11 @@ bool __net_get_random_once(void *buf, int nbytes, bool *done,
 	__sock_create(net, family, type, proto, res, 1)
 #endif
 
+#ifndef SOCKWQ_ASYNC_NOSPACE
+#define SOCKWQ_ASYNC_NOSPACE   SOCK_ASYNC_NOSPACE
+#endif
+#ifndef SOCKWQ_ASYNC_WAITDATA
+#define SOCKWQ_ASYNC_WAITDATA   SOCK_ASYNC_WAITDATA
+#endif
+
 #endif /* __BACKPORT_LINUX_NET_H */
diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index caca6d1..490b68c 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -47,4 +47,20 @@
 #define sk_alloc(net, family, priority, prot, kern) sk_alloc(net, family, priority, prot)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
+#define sk_set_bit LINUX_BACKPORT(sk_set_bit)
+static inline void sk_set_bit(int nr, struct sock *sk)
+{
+	set_bit(nr, &sk->sk_socket->flags);
+}
+#endif /* < 4.5 */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
+#define sk_clear_bit LINUX_BACKPORT(sk_clear_bit)
+static inline void sk_clear_bit(int nr, struct sock *sk)
+{
+	clear_bit(nr, &sk->sk_socket->flags);
+}
+#endif /* < 4.5 */
+
 #endif /* __BACKPORT_NET_SOCK_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
