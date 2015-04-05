Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40005 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568AbbDEWNa (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 5 Apr 2015 18:13:30 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/7] patches: adapt function signature of recvmsg sendmsg
Date: Mon,  6 Apr 2015 00:13:15 +0200
Message-Id: <1428272000-19929-3-git-send-email-hauke@hauke-m.de> (sfid-20150406_001337_538769_93EF8D72)
In-Reply-To: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
References: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The function signature of the members recvmsg sendmsg of the structure
proto_ops changed. The first parameter was removed for kernel 4.1 in
commit 1b7841404. This patch adds back the old signature of older
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0054-struct-proto_ops-sig/bluetooth.patch      | 212 +++++++++++++++++++++
 .../0054-struct-proto_ops-sig/ieee802154.patch     |  79 ++++++++
 .../network/0054-struct-proto_ops-sig/nfc.patch    |  59 ++++++
 3 files changed, 350 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
 create mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
 create mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch

diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
new file mode 100644
index 0000000..d752dba
--- /dev/null
+++ b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
@@ -0,0 +1,212 @@
+--- a/include/net/bluetooth/bluetooth.h
++++ b/include/net/bluetooth/bluetooth.h
+@@ -245,10 +245,17 @@ int  bt_sock_register(int proto, const s
+ void bt_sock_unregister(int proto);
+ void bt_sock_link(struct bt_sock_list *l, struct sock *s);
+ void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+ 		     int flags);
+ int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
+ 			    size_t len, int flags);
++#else
++int  bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
++				struct msghdr *msg, size_t len, int flags);
++int  bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
++			struct msghdr *msg, size_t len, int flags);
++#endif
+ uint bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
+ int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
+ int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
+--- a/net/bluetooth/af_bluetooth.c
++++ b/net/bluetooth/af_bluetooth.c
+@@ -210,8 +210,13 @@ struct sock *bt_accept_dequeue(struct so
+ }
+ EXPORT_SYMBOL(bt_accept_dequeue);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+ 		    int flags)
++#else
++int bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
++				struct msghdr *msg, size_t len, int flags)
++#endif
+ {
+ 	int noblock = flags & MSG_DONTWAIT;
+ 	struct sock *sk = sock->sk;
+@@ -283,8 +288,13 @@ static long bt_sock_data_wait(struct soc
+ 	return timeo;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ int bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
+ 			   size_t size, int flags)
++#else
++int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
++			       struct msghdr *msg, size_t size, int flags)
++#endif
+ {
+ 	struct sock *sk = sock->sk;
+ 	int err = 0;
+--- a/net/bluetooth/hci_sock.c
++++ b/net/bluetooth/hci_sock.c
+@@ -853,8 +853,13 @@ static void hci_sock_cmsg(struct sock *s
+ 	}
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+ 			    int flags)
++#else
++static int hci_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
++			    struct msghdr *msg, size_t len, int flags)
++#endif
+ {
+ 	int noblock = flags & MSG_DONTWAIT;
+ 	struct sock *sk = sock->sk;
+@@ -901,8 +906,13 @@ static int hci_sock_recvmsg(struct socke
+ 	return err ? : copied;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
+ 			    size_t len)
++#else
++static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
++			    struct msghdr *msg, size_t len)
++#endif
+ {
+ 	struct sock *sk = sock->sk;
+ 	struct hci_mgmt_chan *chan;
+--- a/net/bluetooth/l2cap_sock.c
++++ b/net/bluetooth/l2cap_sock.c
+@@ -944,8 +944,13 @@ static int l2cap_sock_setsockopt(struct
+ 	return err;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
+ 			      size_t len)
++#else
++static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
++			      struct msghdr *msg, size_t len)
++#endif
+ {
+ 	struct sock *sk = sock->sk;
+ 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+@@ -976,8 +981,13 @@ static int l2cap_sock_sendmsg(struct soc
+ 	return err;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
+ 			      size_t len, int flags)
++#else
++static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
++			      struct msghdr *msg, size_t len, int flags)
++#endif
+ {
+ 	struct sock *sk = sock->sk;
+ 	struct l2cap_pinfo *pi = l2cap_pi(sk);
+@@ -1004,9 +1014,17 @@ static int l2cap_sock_recvmsg(struct soc
+ 	release_sock(sk);
+ 
+ 	if (sock->type == SOCK_STREAM)
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 		err = bt_sock_stream_recvmsg(sock, msg, len, flags);
++#else
++		err = bt_sock_stream_recvmsg(iocb, sock, msg, len, flags);
++#endif
+ 	else
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 		err = bt_sock_recvmsg(sock, msg, len, flags);
++#else
++		err = bt_sock_recvmsg(iocb, sock, msg, len, flags);
++#endif
+ 
+ 	if (pi->chan->mode != L2CAP_MODE_ERTM)
+ 		return err;
+--- a/net/bluetooth/rfcomm/sock.c
++++ b/net/bluetooth/rfcomm/sock.c
+@@ -549,8 +549,13 @@ static int rfcomm_sock_getname(struct so
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int rfcomm_sock_sendmsg(struct socket *sock, struct msghdr *msg,
+ 			       size_t len)
++#else
++static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
++			       struct msghdr *msg, size_t len)
++#endif
+ {
+ 	struct sock *sk = sock->sk;
+ 	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
+@@ -615,8 +620,13 @@ done:
+ 	return sent;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int rfcomm_sock_recvmsg(struct socket *sock, struct msghdr *msg,
+ 			       size_t size, int flags)
++#else
++static int rfcomm_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
++			       struct msghdr *msg, size_t size, int flags)
++#endif
+ {
+ 	struct sock *sk = sock->sk;
+ 	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
+@@ -627,7 +637,11 @@ static int rfcomm_sock_recvmsg(struct so
+ 		return 0;
+ 	}
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	len = bt_sock_stream_recvmsg(sock, msg, size, flags);
++#else
++	len = bt_sock_stream_recvmsg(iocb, sock, msg, size, flags);
++#endif
+ 
+ 	lock_sock(sk);
+ 	if (!(flags & MSG_PEEK) && len > 0)
+--- a/net/bluetooth/sco.c
++++ b/net/bluetooth/sco.c
+@@ -688,8 +688,13 @@ static int sco_sock_getname(struct socke
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
+ 			    size_t len)
++#else
++static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
++			    struct msghdr *msg, size_t len)
++#endif
+ {
+ 	struct sock *sk = sock->sk;
+ 	int err;
+@@ -758,8 +763,13 @@ static void sco_conn_defer_accept(struct
+ 	}
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
+ 			    size_t len, int flags)
++#else
++static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
++			    struct msghdr *msg, size_t len, int flags)
++#endif
+ {
+ 	struct sock *sk = sock->sk;
+ 	struct sco_pinfo *pi = sco_pi(sk);
+@@ -777,7 +787,11 @@ static int sco_sock_recvmsg(struct socke
+ 
+ 	release_sock(sk);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	return bt_sock_recvmsg(sock, msg, len, flags);
++#else
++	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
++#endif
+ }
+ 
+ static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
new file mode 100644
index 0000000..b737f44
--- /dev/null
+++ b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
@@ -0,0 +1,79 @@
+--- a/net/ieee802154/socket.c
++++ b/net/ieee802154/socket.c
+@@ -98,12 +98,21 @@ static int ieee802154_sock_release(struc
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int ieee802154_sock_sendmsg(struct socket *sock, struct msghdr *msg,
+ 				   size_t len)
++#else
++static int ieee802154_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
++				   struct msghdr *msg, size_t len)
++#endif
+ {
+ 	struct sock *sk = sock->sk;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ 	return sk->sk_prot->sendmsg(sk, msg, len);
++#else
++	return sk->sk_prot->sendmsg(iocb, sk, msg, len);
++#endif
+ }
+ 
+ static int ieee802154_sock_bind(struct socket *sock, struct sockaddr *uaddr,
+@@ -255,7 +264,12 @@ static int raw_disconnect(struct sock *s
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
++#else
++static int raw_sendmsg(struct kiocb *iocb, struct sock *sk,
++		       struct msghdr *msg, size_t size)
++#endif
+ {
+ 	struct net_device *dev;
+ 	unsigned int mtu;
+@@ -326,8 +340,13 @@ out:
+ 	return err;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int raw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+ 		       int noblock, int flags, int *addr_len)
++#else
++static int raw_recvmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
++		       size_t len, int noblock, int flags, int *addr_len)
++#endif
+ {
+ 	size_t copied = 0;
+ 	int err = -EOPNOTSUPP;
+@@ -614,7 +633,12 @@ static int dgram_disconnect(struct sock
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
++#else
++static int dgram_sendmsg(struct kiocb *iocb, struct sock *sk,
++			 struct msghdr *msg, size_t size)
++#endif
+ {
+ 	struct net_device *dev;
+ 	unsigned int mtu;
+@@ -713,8 +737,14 @@ out:
+ 	return err;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+ 			 int noblock, int flags, int *addr_len)
++#else
++static int dgram_recvmsg(struct kiocb *iocb, struct sock *sk,
++			 struct msghdr *msg, size_t len, int noblock,
++			 int flags, int *addr_len)
++#endif
+ {
+ 	size_t copied = 0;
+ 	int err = -EOPNOTSUPP;
diff --git a/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch
new file mode 100644
index 0000000..3bc5fc0
--- /dev/null
+++ b/patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch
@@ -0,0 +1,59 @@
+--- a/net/nfc/llcp_sock.c
++++ b/net/nfc/llcp_sock.c
+@@ -750,8 +750,13 @@ error:
+ 	return ret;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
+ 			     size_t len)
++#else
++static int llcp_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
++			     struct msghdr *msg, size_t len)
++#endif
+ {
+ 	struct sock *sk = sock->sk;
+ 	struct nfc_llcp_sock *llcp_sock = nfc_llcp_sock(sk);
+@@ -793,8 +798,13 @@ static int llcp_sock_sendmsg(struct sock
+ 	return nfc_llcp_send_i_frame(llcp_sock, msg, len);
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int llcp_sock_recvmsg(struct socket *sock, struct msghdr *msg,
+ 			     size_t len, int flags)
++#else
++static int llcp_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
++			     struct msghdr *msg, size_t len, int flags)
++#endif
+ {
+ 	int noblock = flags & MSG_DONTWAIT;
+ 	struct sock *sk = sock->sk;
+--- a/net/nfc/rawsock.c
++++ b/net/nfc/rawsock.c
+@@ -211,7 +211,12 @@ static void rawsock_tx_work(struct work_
+ 	}
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int rawsock_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
++#else
++static int rawsock_sendmsg(struct kiocb *iocb, struct socket *sock,
++			   struct msghdr *msg, size_t len)
++#endif
+ {
+ 	struct sock *sk = sock->sk;
+ 	struct nfc_dev *dev = nfc_rawsock(sk)->dev;
+@@ -247,8 +252,13 @@ static int rawsock_sendmsg(struct socket
+ 	return len;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ static int rawsock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+ 			   int flags)
++#else
++static int rawsock_recvmsg(struct kiocb *iocb, struct socket *sock,
++			   struct msghdr *msg, size_t len, int flags)
++#endif
+ {
+ 	int noblock = flags & MSG_DONTWAIT;
+ 	struct sock *sk = sock->sk;
-- 
1.9.1

