Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41028 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbbFNO3f (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:35 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 01/21] patches: fix spatch for bluetooth
Date: Sun, 14 Jun 2015 16:29:02 +0200
Message-Id: <1434292162-2261-2-git-send-email-hauke@hauke-m.de> (sfid-20150614_162941_482346_A441C6B1)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit 8e879bf1f in backports converted some bluetooth patches into an
spatch. There was a problem in this conversion, the second argument is
not struct socket, but struct sock. This causes some warnings in the
kernel build.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../collateral-evolutions/network/0054-struct-proto_ops-sig.cocci | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig.cocci b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig.cocci
index 0c0845a..64df8ab 100644
--- a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig.cocci
+++ b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig.cocci
@@ -126,10 +126,10 @@ send_func(...)
 }
 
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
-+static int backport_send(struct kiocb *iocb, struct socket *sock,
++static int backport_send(struct kiocb *iocb, struct sock *sk,
 +			  struct msghdr *msg, size_t len)
 +{
-+	return send_func(sock, msg, len);
++	return send_func(sk, msg, len);
 +}
 +#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
 
@@ -144,11 +144,11 @@ recv_func(...)
 }
 
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
-+static int backport_recv(struct kiocb *iocb, struct socket *sock,
++static int backport_recv(struct kiocb *iocb, struct sock *sk,
 +			  struct msghdr *msg, size_t len,
 +			  int noblock, int flags, int *addr_len)
 +{
-+	return recv_func(sock, msg, len, noblock, flags, addr_len);
++	return recv_func(sk, msg, len, noblock, flags, addr_len);
 +}
 +#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
 
-- 
2.1.4

