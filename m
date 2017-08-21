Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48937 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754422AbdHUW2s (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 18/21] patches: adapt signature of proto_ops->accept
Date: Tue, 22 Aug 2017 00:28:14 +0200
Message-Id: <20170821222817.17376-19-hauke@hauke-m.de> (sfid-20170822_002851_655504_1F943928)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In commit cdfbabfb2f0ce ("net: Work around lockdep limitation in sockets
that use sockets") a extra parameter was added to proto_ops->accept(),
do not assume it on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0081-proto_ops-accept/nfc.patch | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 patches/0081-proto_ops-accept/nfc.patch

diff --git a/patches/0081-proto_ops-accept/nfc.patch b/patches/0081-proto_ops-accept/nfc.patch
new file mode 100644
index 00000000..decd13a8
--- /dev/null
+++ b/patches/0081-proto_ops-accept/nfc.patch
@@ -0,0 +1,16 @@
+diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
+index 043c6d3..5b4e44c 100644
+--- a/net/nfc/llcp_sock.c
++++ b/net/nfc/llcp_sock.c
+@@ -443,7 +443,11 @@ struct sock *nfc_llcp_accept_dequeue(struct sock *parent,
+ }
+ 
+ static int llcp_sock_accept(struct socket *sock, struct socket *newsock,
++#if LINUX_VERSION_IS_GEQ(4,11,0)
+ 			    int flags, bool kern)
++#else
++			    int flags)
++#endif
+ {
+ 	DECLARE_WAITQUEUE(wait, current);
+ 	struct sock *sk = sock->sk, *new_sk;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
