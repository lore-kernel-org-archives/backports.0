Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39189 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448AbbDCRY0 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 13:24:26 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/11] patches: add missing include in ath10k
Date: Fri,  3 Apr 2015 19:15:38 +0200
Message-Id: <1428081342-5933-8-git-send-email-hauke@hauke-m.de> (sfid-20150403_192430_516212_5F53609D)
In-Reply-To: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
References: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

drivers/net/wireless/ath/ath10k/htt.h uses "struct idr" since commit
89d6d83. This stricture does not get included on kernel 3.0. This adds
the missing include.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0013-fix-makefile-includes/ath10k.patch            | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/ath10k.patch

diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/ath10k.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/ath10k.patch
new file mode 100644
index 0000000..5bae024
--- /dev/null
+++ b/patches/collateral-evolutions/network/0013-fix-makefile-includes/ath10k.patch
@@ -0,0 +1,10 @@
+--- a/drivers/net/wireless/ath/ath10k/htt.h
++++ b/drivers/net/wireless/ath/ath10k/htt.h
+@@ -19,6 +19,7 @@
+ #define _HTT_H_
+ 
+ #include <linux/bug.h>
++#include <linux/idr.h>
+ #include <linux/interrupt.h>
+ #include <linux/dmapool.h>
+ #include <linux/hashtable.h>
-- 
1.9.1

