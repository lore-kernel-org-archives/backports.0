Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46838 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373Ab3KXN2Q (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 08:28:16 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] backports: refresh on next-20131122
Date: Sun, 24 Nov 2013 14:27:46 +0100
Message-Id: <1385299666-18712-3-git-send-email-hauke@hauke-m.de> (sfid-20131124_142817_764648_78EE0130)
In-Reply-To: <1385299666-18712-1-git-send-email-hauke@hauke-m.de>
References: <1385299666-18712-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

== ckmake-report.log ==

1   2.6.24              [  FAIL  ]
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
17  3.0.101             [  OK  ]
18  3.1.10              [  OK  ]
19  3.10.20             [  OK  ]
20  3.11.9              [  OK  ]
21  3.12.1              [  OK  ]
22  3.13-rc1            [  OK  ]
23  3.2.52              [  OK  ]
24  3.3.8               [  OK  ]
25  3.4.70              [  OK  ]
26  3.5.7               [  OK  ]
27  3.6.11              [  OK  ]
28  3.7.10              [  OK  ]
29  3.8.13              [  OK  ]
30  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/16-bluetooth/net_bluetooth_af_bluetooth.patch          |    2 +-
 .../network/16-bluetooth/net_bluetooth_hci_sock.patch              |    4 ++--
 .../network/16-bluetooth/net_bluetooth_rfcomm_sock.patch           |    2 +-
 .../network/16-bluetooth/net_bluetooth_sco.patch                   |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch
index 708ce3b..bd2d054 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch
@@ -25,7 +25,7 @@
  		if (!err)
  			bt_sock_reclassify_lock(sock->sk, proto);
  		module_put(bt_proto[proto]->owner);
-@@ -464,7 +472,11 @@ int bt_sock_ioctl(struct socket *sock, u
+@@ -459,7 +467,11 @@ int bt_sock_ioctl(struct socket *sock, u
  		if (sk->sk_state == BT_LISTEN)
  			return -EINVAL;
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
index af53d75..8208629 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hci_sock.c
 +++ b/net/bluetooth/hci_sock.c
-@@ -998,8 +998,13 @@ drop:
+@@ -996,8 +996,13 @@ drop:
  	goto done;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct hci_ufilter uf = { .opcode = 0 };
  	struct sock *sk = sock->sk;
-@@ -1173,8 +1178,12 @@ static struct proto hci_sk_proto = {
+@@ -1171,8 +1176,12 @@ static struct proto hci_sk_proto = {
  	.obj_size	= sizeof(struct hci_pinfo)
  };
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
index 231ce59..88c8f31 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
@@ -14,7 +14,7 @@
  {
  	struct sock *sk;
  
-@@ -668,7 +673,11 @@ static int rfcomm_sock_setsockopt_old(st
+@@ -667,7 +672,11 @@ static int rfcomm_sock_setsockopt_old(st
  	return err;
  }
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
index 4dc6998..57d4b61 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
@@ -13,7 +13,7 @@
  {
  	struct sock *sk;
  
-@@ -722,7 +726,11 @@ static int sco_sock_recvmsg(struct kiocb
+@@ -721,7 +725,11 @@ static int sco_sock_recvmsg(struct kiocb
  	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
  }
  
-- 
1.7.10.4

