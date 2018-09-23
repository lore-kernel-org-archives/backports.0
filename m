Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:38508 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbeIWXoE (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 19:44:04 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/10] backports: Make netdev destructor spatch apply correctly again
Date: Sun, 23 Sep 2018 19:45:34 +0200
Message-Id: <20180923174535.16198-10-hauke@hauke-m.de> (sfid-20180923_194552_237545_E7708305)
In-Reply-To: <20180923174535.16198-1-hauke@hauke-m.de>
References: <20180923174535.16198-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The netdev destructor spatch did not apply to the wil6210 driver any
more, because there the calls were done in a different order compared to
the spatch. Add an additional rule which applies when the order is
changed.

Fixes: 30a378636e47 ("backports: speed up netdev destructor spatch by two orders of magnitude")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0079-netdev-destructor.cocci | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/patches/0079-netdev-destructor.cocci b/patches/0079-netdev-destructor.cocci
index f2bea35b..8d7228ec 100644
--- a/patches/0079-netdev-destructor.cocci
+++ b/patches/0079-netdev-destructor.cocci
@@ -67,6 +67,38 @@ if (<+... RET ...+>) {
 	...>
 }
 
+@r11@
+struct net_device *NDEV;
+identifier D, C;
+identifier TRUE =~ "true";
+@@
+C(...)
+{
+	<+...
+-	NDEV->priv_destructor = D;
+-	NDEV->needs_free_netdev = TRUE;
++	netdev_set_priv_destructor(NDEV, D);
+	...+>
+}
+
+@r12 depends on r11@
+identifier r11.D, r11.C;
+fresh identifier E = "__" ## D;
+@@
+
++#if LINUX_VERSION_IS_LESS(4,12,0)
++static void E(struct net_device *ndev)
++{
++	D(ndev);
++	free_netdev(ndev);
++}
++#endif
++
+C(...)
+{
+	...
+}
+
 @r5@
 struct net_device *NDEV;
 identifier TRUE =~ "true";
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
