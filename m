Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 1/8] compat: remove trailing erroneous semicolon from compat-3.8.c
Date: Tue, 26 Feb 2013 22:05:38 +0100
Message-Id: <1361912745-29665-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
References: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Upstream commit 5461c0248925836d7d10393ed0296aa82cb46e32

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-3.8.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/compat-3.8.c b/compat/compat-3.8.c
index 62dafaf..02353a2 100644
--- a/compat/compat-3.8.c
+++ b/compat/compat-3.8.c
@@ -19,7 +19,7 @@ void netdev_set_default_ethtool_ops(struct net_device *dev,
 	if (!dev->ethtool_ops)
 		dev->ethtool_ops = ops;
 }
-#else /* kernel is between 3.7.0 and 3.7.4 */;
+#else /* kernel is between 3.7.0 and 3.7.4 */
 void netdev_set_default_ethtool_ops(struct net_device *dev,
 				    const struct ethtool_ops *ops)
 {
-- 
1.7.10.4
