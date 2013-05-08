Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:56187 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab3EHAlg (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 20:41:36 -0400
Received: by mail-pd0-f180.google.com with SMTP id t10so809473pdi.25
        for <backports@vger.kernel.org>; Tue, 07 May 2013 17:41:36 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] backports: refresh patches for next-20130408
Date: Tue,  7 May 2013 17:41:31 -0700
Message-Id: <1367973691-26961-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130508_024139_570411_28AAEB0D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

== ckmake-report.log ==

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.76              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.44              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.43              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.11              [  OK  ]
26  3.9.0               [  OK  ]

real    30m33.717s
user    809m9.794s
sys     125m18.510s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../network/16-bluetooth/net_bluetooth_hidp_core.patch       |   10 +++++-----
 .../network/16-bluetooth/net_bluetooth_l2cap_sock.patch      |    6 +++---
 .../network/16-bluetooth/net_bluetooth_rfcomm_sock.patch     |    2 +-
 .../network/16-bluetooth/net_bluetooth_sco.patch             |    2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
index f546267..60a97e6 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
@@ -129,7 +129,7 @@
  
  int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock)
  {
-@@ -979,6 +1063,39 @@ int hidp_add_connection(struct hidp_conn
+@@ -981,6 +1065,39 @@ int hidp_add_connection(struct hidp_conn
  
  	BT_DBG("rd_data %p rd_size %d", req->rd_data, req->rd_size);
  
@@ -169,7 +169,7 @@
  	down_write(&hidp_session_sem);
  
  	s = __hidp_get_session(&bt_sk(ctrl_sock->sk)->dst);
-@@ -1026,6 +1143,7 @@ int hidp_add_connection(struct hidp_conn
+@@ -1028,6 +1145,7 @@ int hidp_add_connection(struct hidp_conn
  
  	__hidp_link_session(session);
  
@@ -177,7 +177,7 @@
  	if (req->rd_size > 0) {
  		err = hidp_setup_hid(session, req);
  		if (err && err != -ENODEV)
-@@ -1037,6 +1155,16 @@ int hidp_add_connection(struct hidp_conn
+@@ -1039,6 +1157,16 @@ int hidp_add_connection(struct hidp_conn
  		if (err < 0)
  			goto purge;
  	}
@@ -194,7 +194,7 @@
  
  	hidp_set_timer(session);
  
-@@ -1095,6 +1223,7 @@ unlink:
+@@ -1097,6 +1225,7 @@ unlink:
  		session->input = NULL;
  	}
  
@@ -202,7 +202,7 @@
  	if (session->hid) {
  		hid_destroy_device(session->hid);
  		session->hid = NULL;
-@@ -1108,10 +1237,15 @@ purge:
+@@ -1110,10 +1239,15 @@ purge:
  
  	skb_queue_purge(&session->ctrl_transmit);
  	skb_queue_purge(&session->intr_transmit);
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
index 6a155d5..16bcee3 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -573,8 +573,13 @@ static int l2cap_sock_setsockopt_old(str
+@@ -579,8 +579,13 @@ static int l2cap_sock_setsockopt_old(str
  	return err;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct sock *sk = sock->sk;
  	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-@@ -1225,8 +1230,12 @@ static struct sock *l2cap_sock_alloc(str
+@@ -1231,8 +1236,12 @@ static struct sock *l2cap_sock_alloc(str
  	return sk;
  }
  
@@ -27,7 +27,7 @@
  {
  	struct sock *sk;
  
-@@ -1238,7 +1247,11 @@ static int l2cap_sock_create(struct net
+@@ -1244,7 +1253,11 @@ static int l2cap_sock_create(struct net
  	    sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
  		return -ESOCKTNOSUPPORT;
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
index fbeb107..8fe9af5 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
@@ -14,7 +14,7 @@
  {
  	struct sock *sk;
  
-@@ -660,7 +665,11 @@ static int rfcomm_sock_setsockopt_old(st
+@@ -661,7 +666,11 @@ static int rfcomm_sock_setsockopt_old(st
  	return err;
  }
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
index 6b6d9a5..b165915 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
@@ -13,7 +13,7 @@
  {
  	struct sock *sk;
  
-@@ -675,7 +679,11 @@ static int sco_sock_recvmsg(struct kiocb
+@@ -676,7 +680,11 @@ static int sco_sock_recvmsg(struct kiocb
  	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
  }
  
-- 
1.7.10.4

