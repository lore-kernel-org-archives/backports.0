Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44885 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbaFOVW2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 69B8A7E5D
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:27 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/19] backports: do not access user_ns on struct net
Date: Sun, 15 Jun 2014 23:21:41 +0200
Message-Id: <1402867307-31337-14-git-send-email-hauke@hauke-m.de> (sfid-20140615_232229_819041_2E113776)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The ieee802154 subsystem wants to access user_ns on struct net, but
this member was added in kernel 3.8, check the general capabilities
instead.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0044-no_user_ns_in_net/ieee802154.patch        | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch

diff --git a/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch b/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch
new file mode 100644
index 0000000..d5f951b
--- /dev/null
+++ b/patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch
@@ -0,0 +1,30 @@
+--- a/net/ieee802154/dgram.c
++++ b/net/ieee802154/dgram.c
+@@ -483,8 +483,13 @@ static int dgram_setsockopt(struct sock
+ 		ro->want_ack = !!val;
+ 		break;
+ 	case WPAN_SECURITY:
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
+ 		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
++#else
++		if (!capable(CAP_NET_ADMIN) &&
++		    !capable(CAP_NET_RAW)) {
++#endif
+ 			err = -EPERM;
+ 			break;
+ 		}
+@@ -507,8 +512,13 @@ static int dgram_setsockopt(struct sock
+ 		}
+ 		break;
+ 	case WPAN_SECURITY_LEVEL:
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
+ 		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
++#else
++		if (!capable(CAP_NET_ADMIN) &&
++		    !capable(CAP_NET_RAW)) {
++#endif
+ 			err = -EPERM;
+ 			break;
+ 		}
-- 
1.9.1

