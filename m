Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39190 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469AbbDCRY1 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 13:24:27 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/11] patches: do not use memcpy_fromiovec() in bluetooth
Date: Fri,  3 Apr 2015 19:15:39 +0200
Message-Id: <1428081342-5933-9-git-send-email-hauke@hauke-m.de> (sfid-20150403_192431_651814_3284D8B9)
In-Reply-To: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
References: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The patch patches/collateral-evolutions/network/0050-iov_iter
/bluetooth.patch added memcpy_fromiovec unconditionally, but
memcpy_fromiovec() is not available in kernel 4.0 any more. This patch
adds the backport code only for older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0050-iov_iter/bluetooth.patch          | 38 +++++++++++++++-------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index aa6d528..8939638 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -1,20 +1,23 @@
 --- a/include/net/bluetooth/l2cap.h
 +++ b/include/net/bluetooth/l2cap.h
-@@ -609,6 +609,10 @@ struct l2cap_ops {
+@@ -609,6 +609,12 @@ struct l2cap_ops {
  	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
  					       unsigned long hdr_len,
  					       unsigned long len, int nb);
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
 +	int			(*memcpy_fromiovec) (struct l2cap_chan *chan,
 +						     unsigned char *kdata,
 +						     struct iovec *iov,
 +						     int len);
++#endif
  };
  
  struct l2cap_conn {
-@@ -902,6 +906,31 @@ static inline long l2cap_chan_no_get_snd
+@@ -902,6 +908,33 @@ static inline long l2cap_chan_no_get_snd
  	return 0;
  }
  
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
 +static inline int l2cap_chan_no_memcpy_fromiovec(struct l2cap_chan *chan,
 +						 unsigned char *kdata,
 +						 struct iovec *iov,
@@ -39,6 +42,7 @@
 +
 +	return 0;
 +}
++#endif
 +
  extern bool disable_ertm;
  
@@ -64,17 +68,19 @@
  
  	err = l2cap_chan_send(chan, &msg, skb->len);
  	if (err > 0) {
-@@ -1048,6 +1055,7 @@ static const struct l2cap_ops bt_6lowpan
+@@ -1048,6 +1055,9 @@ static const struct l2cap_ops bt_6lowpan
  	.suspend		= chan_suspend_cb,
  	.get_sndtimeo		= chan_get_sndtimeo_cb,
  	.alloc_skb		= chan_alloc_skb_cb,
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
 +	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
++#endif
  
  	.teardown		= l2cap_chan_no_teardown,
  	.defer			= l2cap_chan_no_defer,
 --- a/net/bluetooth/a2mp.c
 +++ b/net/bluetooth/a2mp.c
-@@ -60,7 +60,12 @@ void a2mp_send(struct amp_mgr *mgr, u8 c
+@@ -62,7 +62,12 @@ static void a2mp_send(struct amp_mgr *mg
  
  	memset(&msg, 0, sizeof(msg));
  
@@ -87,17 +93,19 @@
  
  	l2cap_chan_send(chan, &msg, total_len);
  
-@@ -719,6 +724,7 @@ static const struct l2cap_ops a2mp_chan_
+@@ -738,6 +743,9 @@ static const struct l2cap_ops a2mp_chan_
  	.resume = l2cap_chan_no_resume,
  	.set_shutdown = l2cap_chan_no_set_shutdown,
  	.get_sndtimeo = l2cap_chan_no_get_sndtimeo,
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
 +	.memcpy_fromiovec = l2cap_chan_no_memcpy_fromiovec,
++#endif
  };
  
  static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
 --- a/net/bluetooth/l2cap_core.c
 +++ b/net/bluetooth/l2cap_core.c
-@@ -2113,7 +2113,12 @@ static inline int l2cap_skbuff_fromiovec
+@@ -2120,7 +2120,12 @@ static inline int l2cap_skbuff_fromiovec
  	struct sk_buff **frag;
  	int sent = 0;
  
@@ -110,7 +118,7 @@
  		return -EFAULT;
  
  	sent += count;
-@@ -2133,8 +2138,13 @@ static inline int l2cap_skbuff_fromiovec
+@@ -2140,8 +2145,13 @@ static inline int l2cap_skbuff_fromiovec
  
  		*frag = tmp;
  
@@ -126,25 +134,29 @@
  		sent += count;
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -1335,6 +1335,13 @@ static struct sk_buff *l2cap_sock_alloc_
+@@ -1335,6 +1335,15 @@ static struct sk_buff *l2cap_sock_alloc_
  	return skb;
  }
  
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
 +static int l2cap_sock_memcpy_fromiovec_cb(struct l2cap_chan *chan,
 +					  unsigned char *kdata,
 +					  struct iovec *iov, int len)
 +{
 +	return memcpy_fromiovec(kdata, iov, len);
 +}
++#endif
 +
  static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
  {
  	struct sock *sk = chan->data;
-@@ -1419,6 +1426,7 @@ static const struct l2cap_ops l2cap_chan
+@@ -1419,6 +1428,9 @@ static const struct l2cap_ops l2cap_chan
  	.set_shutdown		= l2cap_sock_set_shutdown_cb,
  	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
  	.alloc_skb		= l2cap_sock_alloc_skb_cb,
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
 +	.memcpy_fromiovec	= l2cap_sock_memcpy_fromiovec_cb,
++#endif
  };
  
  static void l2cap_sock_destruct(struct sock *sk)
@@ -163,19 +175,23 @@
  
  	l2cap_chan_send(chan, &msg, 1 + len);
  
-@@ -2871,6 +2876,7 @@ static const struct l2cap_ops smp_chan_o
+@@ -2871,6 +2876,9 @@ static const struct l2cap_ops smp_chan_o
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
 +	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
++#endif
  };
  
  static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -2919,6 +2925,7 @@ static const struct l2cap_ops smp_root_c
+@@ -2919,6 +2927,9 @@ static const struct l2cap_ops smp_root_c
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
 +	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
++#endif
  };
  
  static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
-- 
1.9.1

