Return-path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	johannes@sipsolutions.net,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] compat-drivers: make patches apply again
Date: Wed, 17 Oct 2012 17:00:24 +0200
Message-Id: <1350486024-4477-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/network/16-bluetooth.patch |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/patches/network/16-bluetooth.patch b/patches/network/16-bluetooth.patch
index 6beba28..57df268 100644
--- a/patches/network/16-bluetooth.patch
+++ b/patches/network/16-bluetooth.patch
@@ -534,22 +534,21 @@ here still, but for now we keep this here.
  
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -565,7 +565,14 @@ static int l2cap_sock_setsockopt_old(str
+@@ -573,8 +573,13 @@ static int l2cap_sock_setsockopt_old(str
  	return err;
  }
  
-+
 +#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31))
- static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
+ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
+ 				 char __user *optval, unsigned int optlen)
 +#else
-+static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int optlen)
++static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
++				 char __user *optval, int optlen)
 +#endif
-+
-+
  {
  	struct sock *sk = sock->sk;
  	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-@@ -1196,8 +1203,12 @@ static struct sock *l2cap_sock_alloc(str
+@@ -1220,8 +1225,12 @@ static struct sock *l2cap_sock_alloc(str
  	return sk;
  }
  
@@ -562,8 +561,8 @@ here still, but for now we keep this here.
  {
  	struct sock *sk;
  
-@@ -1209,7 +1220,11 @@ static int l2cap_sock_create(struct net
- 			sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
+@@ -1233,7 +1242,11 @@ static int l2cap_sock_create(struct net
+ 	    sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
  		return -ESOCKTNOSUPPORT;
  
 +#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,32))
-- 
1.7.9.5
