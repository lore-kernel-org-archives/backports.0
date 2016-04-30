Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49611 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbcD3VBI (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:08 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/16] patches: use old signature for struct proto hash function
Date: Sat, 30 Apr 2016 23:00:44 +0200
Message-Id: <1462050048-8953-13-git-send-email-hauke@hauke-m.de> (sfid-20160430_230721_922330_C63B4B3D)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

commit 086c653f5862591a9cfe2386f5650d03adacc33a
Author: Craig Gallek <kraig@google.com>
Date:   Wed Feb 10 11:50:35 2016 -0500

    sock: struct proto hash function may error

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0068-proto-hash/ieee802154.patch       | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0068-proto-hash/ieee802154.patch

diff --git a/patches/collateral-evolutions/network/0068-proto-hash/ieee802154.patch b/patches/collateral-evolutions/network/0068-proto-hash/ieee802154.patch
new file mode 100644
index 0000000..e60ba56
--- /dev/null
+++ b/patches/collateral-evolutions/network/0068-proto-hash/ieee802154.patch
@@ -0,0 +1,62 @@
+diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
+index e0bd013..9e78921 100644
+--- a/net/ieee802154/socket.c
++++ b/net/ieee802154/socket.c
+@@ -182,14 +182,20 @@ static int ieee802154_sock_ioctl(struct
+ static HLIST_HEAD(raw_head);
+ static DEFINE_RWLOCK(raw_lock);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
+ static int raw_hash(struct sock *sk)
++#else
++static void raw_hash(struct sock *sk)
++#endif
+ {
+ 	write_lock_bh(&raw_lock);
+ 	sk_add_node(sk, &raw_head);
+ 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+ 	write_unlock_bh(&raw_lock);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
+ 	return 0;
++#endif
+ }
+ 
+ static void raw_unhash(struct sock *sk)
+@@ -464,14 +470,20 @@ static inline struct dgram_sock *dgram_s
+ 	return container_of(sk, struct dgram_sock, sk);
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
+ static int dgram_hash(struct sock *sk)
++#else
++static void dgram_hash(struct sock *sk)
++#endif
+ {
+ 	write_lock_bh(&dgram_lock);
+ 	sk_add_node(sk, &dgram_head);
+ 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+ 	write_unlock_bh(&dgram_lock);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
+ 	return 0;
++#endif
+ }
+ 
+ static void dgram_unhash(struct sock *sk)
+@@ -1031,11 +1043,15 @@ static int ieee802154_create(struct net
+ 	sock_set_flag(sk, SOCK_ZAPPED);
+ 
+ 	if (sk->sk_prot->hash) {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
+ 		rc = sk->sk_prot->hash(sk);
+ 		if (rc) {
+ 			sk_common_release(sk);
+ 			goto out;
+ 		}
++#else
++		sk->sk_prot->hash(sk);
++#endif
+ 	}
+ 
+ 	if (sk->sk_prot->init) {
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
