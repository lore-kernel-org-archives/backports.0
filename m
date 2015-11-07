Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52904 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711AbbKGQzU (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 11:55:20 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/10] patches: argument removed from struct ipv6_stub->ndisc_send_na()
Date: Sat,  7 Nov 2015 17:55:01 +0100
Message-Id: <1446915310-8278-2-git-send-email-hauke@hauke-m.de> (sfid-20151107_175523_358245_E43A4C6F)
In-Reply-To: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
References: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit 38cf595b1 "ipv6: remove unused neigh parameter from ndisc
functions" removed one parameter from the callback function
ndisc_send_na(). This semantic patch makes the code add NULL for that
parameter on older kernel versions. Null was passed in most of the
callers before.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0065-ndisc_send_na-argument.cocci                    | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0065-ndisc_send_na-argument.cocci

diff --git a/patches/collateral-evolutions/network/0065-ndisc_send_na-argument.cocci b/patches/collateral-evolutions/network/0065-ndisc_send_na-argument.cocci
new file mode 100644
index 0000000..84c4209
--- /dev/null
+++ b/patches/collateral-evolutions/network/0065-ndisc_send_na-argument.cocci
@@ -0,0 +1,9 @@
+@@
+identifier ndisc_send_na;
+expression netdev, saddr, target, router, solicited, override, inc_opt;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
+ ipv6_stub->ndisc_send_na(netdev, saddr, target, router, solicited, override, inc_opt);
++#else
++ipv6_stub->ndisc_send_na(netdev, NULL, saddr, target, router, solicited, override, inc_opt);
++#endif
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
