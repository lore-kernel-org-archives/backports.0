Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36632 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753059AbaLURwC (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:52:02 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] patches: revert iov_iter for bluetooth
Date: Sun, 21 Dec 2014 18:51:51 +0100
Message-Id: <1419184314-1938-6-git-send-email-hauke@hauke-m.de> (sfid-20141221_185206_625797_72B416A4)
In-Reply-To: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
References: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

usage of the new iov_iter api was added in the following patches:
commit 17836394e578b8d6475ecdb309ad1356bbcf37a2
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Nov 24 17:07:38 2014 -0500
    first fruits - kill l2cap ->memcpy_fromiovec()

commit c0371da6047abd261bc483c744dbc7d81a116172
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Nov 24 10:42:55 2014 -0500
    put iov_iter into msghdr

commit 56c39fb67cdb665ae67fba4975f5e20e6614cda6
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Nov 24 16:44:09 2014 -0500
    switch l2cap ->memcpy_fromiovec() to msghdr

I haven't found a way to backport this, so this is mostly a revert of
these upstream commits to make bluetooth use the old APIs on older
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0050-iov_iter/bluetooth.patch          | 181 +++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch

diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
new file mode 100644
index 0000000..a2989a4
--- /dev/null
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -0,0 +1,181 @@
+--- a/include/net/bluetooth/l2cap.h
++++ b/include/net/bluetooth/l2cap.h
+@@ -609,6 +609,10 @@ struct l2cap_ops {
+ 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
+ 					       unsigned long hdr_len,
+ 					       unsigned long len, int nb);
++	int			(*memcpy_fromiovec) (struct l2cap_chan *chan,
++						     unsigned char *kdata,
++						     struct iovec *iov,
++						     int len);
+ };
+ 
+ struct l2cap_conn {
+@@ -902,6 +906,31 @@ static inline long l2cap_chan_no_get_snd
+ 	return 0;
+ }
+ 
++static inline int l2cap_chan_no_memcpy_fromiovec(struct l2cap_chan *chan,
++						 unsigned char *kdata,
++						 struct iovec *iov,
++						 int len)
++{
++	/* Following is safe since for compiler definitions of kvec and
++	 * iovec are identical, yielding the same in-core layout and alignment
++	 */
++	struct kvec *vec = (struct kvec *)iov;
++
++	while (len > 0) {
++		if (vec->iov_len) {
++			int copy = min_t(unsigned int, len, vec->iov_len);
++			memcpy(kdata, vec->iov_base, copy);
++			len -= copy;
++			kdata += copy;
++			vec->iov_base += copy;
++			vec->iov_len -= copy;
++		}
++		vec++;
++	}
++
++	return 0;
++}
++
+ extern bool disable_ertm;
+ 
+ int l2cap_init_sockets(void);
+--- a/net/bluetooth/6lowpan.c
++++ b/net/bluetooth/6lowpan.c
+@@ -537,11 +537,18 @@ static int send_pkt(struct l2cap_chan *c
+ 	 */
+ 	chan->data = skb;
+ 
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
++	memset(&msg, 0, sizeof(msg));
++	msg.msg_iov = (struct iovec *) &iv;
++	msg.msg_iovlen = 1;
++#endif
+ 	iv.iov_base = skb->data;
+ 	iv.iov_len = skb->len;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+ 	memset(&msg, 0, sizeof(msg));
+ 	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, &iv, 1, skb->len);
++#endif
+ 
+ 	err = l2cap_chan_send(chan, &msg, skb->len);
+ 	if (err > 0) {
+@@ -1052,6 +1059,7 @@ static const struct l2cap_ops bt_6lowpan
+ 	.suspend		= chan_suspend_cb,
+ 	.get_sndtimeo		= chan_get_sndtimeo_cb,
+ 	.alloc_skb		= chan_alloc_skb_cb,
++	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
+ 
+ 	.teardown		= l2cap_chan_no_teardown,
+ 	.defer			= l2cap_chan_no_defer,
+--- a/net/bluetooth/a2mp.c
++++ b/net/bluetooth/a2mp.c
+@@ -60,7 +60,12 @@ void a2mp_send(struct amp_mgr *mgr, u8 c
+ 
+ 	memset(&msg, 0, sizeof(msg));
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+ 	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, &iv, 1, total_len);
++#else
++	msg.msg_iov = (struct iovec *) &iv;
++	msg.msg_iovlen = 1;
++#endif
+ 
+ 	l2cap_chan_send(chan, &msg, total_len);
+ 
+@@ -719,6 +724,7 @@ static const struct l2cap_ops a2mp_chan_
+ 	.resume = l2cap_chan_no_resume,
+ 	.set_shutdown = l2cap_chan_no_set_shutdown,
+ 	.get_sndtimeo = l2cap_chan_no_get_sndtimeo,
++	.memcpy_fromiovec = l2cap_chan_no_memcpy_fromiovec,
+ };
+ 
+ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
+--- a/net/bluetooth/l2cap_core.c
++++ b/net/bluetooth/l2cap_core.c
+@@ -2103,7 +2103,12 @@ static inline int l2cap_skbuff_fromiovec
+ 	struct sk_buff **frag;
+ 	int sent = 0;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+ 	if (copy_from_iter(skb_put(skb, count), count, &msg->msg_iter) != count)
++#else
++	if (chan->ops->memcpy_fromiovec(chan, skb_put(skb, count),
++					msg->msg_iov, count))
++#endif
+ 		return -EFAULT;
+ 
+ 	sent += count;
+@@ -2123,8 +2128,13 @@ static inline int l2cap_skbuff_fromiovec
+ 
+ 		*frag = tmp;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+ 		if (copy_from_iter(skb_put(*frag, count), count,
+ 				   &msg->msg_iter) != count)
++#else
++		if (chan->ops->memcpy_fromiovec(chan, skb_put(*frag, count),
++						msg->msg_iov, count))
++#endif
+ 			return -EFAULT;
+ 
+ 		sent += count;
+--- a/net/bluetooth/l2cap_sock.c
++++ b/net/bluetooth/l2cap_sock.c
+@@ -1336,6 +1336,13 @@ static struct sk_buff *l2cap_sock_alloc_
+ 	return skb;
+ }
+ 
++static int l2cap_sock_memcpy_fromiovec_cb(struct l2cap_chan *chan,
++					  unsigned char *kdata,
++					  struct iovec *iov, int len)
++{
++	return memcpy_fromiovec(kdata, iov, len);
++}
++
+ static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
+ {
+ 	struct sock *sk = chan->data;
+@@ -1420,6 +1427,7 @@ static const struct l2cap_ops l2cap_chan
+ 	.set_shutdown		= l2cap_sock_set_shutdown_cb,
+ 	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
+ 	.alloc_skb		= l2cap_sock_alloc_skb_cb,
++	.memcpy_fromiovec	= l2cap_sock_memcpy_fromiovec_cb,
+ };
+ 
+ static void l2cap_sock_destruct(struct sock *sk)
+--- a/net/bluetooth/smp.c
++++ b/net/bluetooth/smp.c
+@@ -539,7 +539,12 @@ static void smp_send_cmd(struct l2cap_co
+ 
+ 	memset(&msg, 0, sizeof(msg));
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+ 	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, iv, 2, 1 + len);
++#else
++	msg.msg_iov = (struct iovec *) &iv;
++	msg.msg_iovlen = 2;
++#endif
+ 
+ 	l2cap_chan_send(chan, &msg, 1 + len);
+ 
+@@ -2865,6 +2870,7 @@ static const struct l2cap_ops smp_chan_o
+ 	.suspend		= l2cap_chan_no_suspend,
+ 	.set_shutdown		= l2cap_chan_no_set_shutdown,
+ 	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
++	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
+ };
+ 
+ static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
+@@ -2913,6 +2919,7 @@ static const struct l2cap_ops smp_root_c
+ 	.resume			= l2cap_chan_no_resume,
+ 	.set_shutdown		= l2cap_chan_no_set_shutdown,
+ 	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
++	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
+ };
+ 
+ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
-- 
1.9.1

