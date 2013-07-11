Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44246 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756949Ab3GKWM4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:56 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 17/19] backports: add SPEED_UNKNOWN and DUPLEX_UNKNOWN
Date: Fri, 12 Jul 2013 00:11:40 +0200
Message-Id: <1373580702-24752-19-git-send-email-hauke@hauke-m.de> (sfid-20130712_001259_131602_739F6241)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Upstream commit 8742a33b63428b13d21be4b79220813d2180752a

This was added via uapi/linux/ethtool.h but using
that file causes some odd issues I simply cannot
resolve right now. I stuff these definitions into
the regular include/linux/ethtool.h for now.

This backports commit 589665f5 added via v3.2.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains \
	589665f5a6008dbce1d0af2cb93e94a80bf78151
v3.2-rc1~4^2~10

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/ethtool.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
index 9ed268b..732a0db 100644
--- a/backport/backport-include/linux/ethtool.h
+++ b/backport/backport-include/linux/ethtool.h
@@ -3,6 +3,14 @@
 #include_next <linux/ethtool.h>
 #include <linux/version.h>
 
+#ifndef SPEED_UNKNOWN
+#define SPEED_UNKNOWN  -1
+#endif /* SPEED_UNKNOWN */
+
+#ifndef DUPLEX_UNKNOWN
+#define DUPLEX_UNKNOWN 0xff
+#endif /* DUPLEX_UNKNOWN */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
 static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
 {
-- 
1.7.10.4

