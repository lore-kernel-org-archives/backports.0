Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41046 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbbFNO3j (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:39 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 20/21] patches: deactivate tracing on mt7601u for kernel < 3.4
Date: Sun, 14 Jun 2015 16:29:21 +0200
Message-Id: <1434292162-2261-21-git-send-email-hauke@hauke-m.de> (sfid-20150614_163351_231934_F312D662)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Kernel version < 3.4 has problems with tracing, deactivate it in the
mt7601u driver for these kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0022-define-tracing/mt7601u.patch                | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0022-define-tracing/mt7601u.patch

diff --git a/patches/collateral-evolutions/network/0022-define-tracing/mt7601u.patch b/patches/collateral-evolutions/network/0022-define-tracing/mt7601u.patch
new file mode 100644
index 0000000..688f4c8
--- /dev/null
+++ b/patches/collateral-evolutions/network/0022-define-tracing/mt7601u.patch
@@ -0,0 +1,12 @@
+--- a/drivers/net/wireless/mediatek/mt7601u/trace.c
++++ b/drivers/net/wireless/mediatek/mt7601u/trace.c
+@@ -15,6 +15,9 @@
+ #include <linux/module.h>
+ 
+ #ifndef __CHECKER__
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
++#include "trace.h"
++#endif
+ #define CREATE_TRACE_POINTS
+ #include "trace.h"
+ 
-- 
2.1.4

