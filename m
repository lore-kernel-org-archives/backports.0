Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:57962 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbbEYVoP (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 25 May 2015 17:44:15 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] header: handler new parameter net in sock_create_kern()
Date: Mon, 25 May 2015 23:44:03 +0200
Message-Id: <1432590244-4101-3-git-send-email-hauke@hauke-m.de> (sfid-20150525_234418_923911_8652B8B5)
In-Reply-To: <1432590244-4101-1-git-send-email-hauke@hauke-m.de>
References: <1432590244-4101-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Linux commit eeb1bd5c4 added a new parameter to sock_create_kern(). In
the original function it was replaced with &init_net every time, now it
is taken from the parameter.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/net.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/net.h b/backport/backport-include/linux/net.h
index 0e436d4..4d9250b 100644
--- a/backport/backport-include/linux/net.h
+++ b/backport/backport-include/linux/net.h
@@ -97,4 +97,9 @@ bool __net_get_random_once(void *buf, int nbytes, bool *done,
 
 #endif /* __BACKPORT_NET_GET_RANDOM_ONCE */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#define sock_create_kern(net, family, type, proto, res) \
+	__sock_create(net, family, type, proto, res, 1)
+#endif
+
 #endif /* __BACKPORT_LINUX_NET_H */
-- 
2.1.4

