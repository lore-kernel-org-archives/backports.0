Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54573 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbaARUAR (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 18 Jan 2014 15:00:17 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] backports: add missing include
Date: Sat, 18 Jan 2014 21:00:00 +0100
Message-Id: <1390075200-6639-1-git-send-email-hauke@hauke-m.de> (sfid-20140118_210033_578664_09556F1C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

A user reported that the linux/mm.h header was missing on his mips
device with kernel 2.6.26.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/compat-3.8.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
index c6824bf..6741989 100644
--- a/backport/compat/compat-3.8.c
+++ b/backport/compat/compat-3.8.c
@@ -18,6 +18,7 @@
 #include <linux/netdevice.h>
 #include <linux/random.h>
 #include <linux/of.h>
+#include <linux/mm.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8))
 void netdev_set_default_ethtool_ops(struct net_device *dev,
-- 
1.7.10.4

