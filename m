Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:51297 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753946Ab3FINYW (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 9 Jun 2013 09:24:22 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] backports: fix tracing on wil6210
Date: Sun,  9 Jun 2013 15:23:53 +0200
Message-Id: <1370784233-18228-5-git-send-email-hauke@hauke-m.de> (sfid-20130609_152423_464845_7899B69E)
In-Reply-To: <1370784233-18228-1-git-send-email-hauke@hauke-m.de>
References: <1370784233-18228-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This includes the trace.h file like it is done for the other drivers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/74-define-tracing/wil6210.patch                   |    9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/74-define-tracing/wil6210.patch

diff --git a/patches/collateral-evolutions/network/74-define-tracing/wil6210.patch b/patches/collateral-evolutions/network/74-define-tracing/wil6210.patch
new file mode 100644
index 0000000..1888cd7
--- /dev/null
+++ b/patches/collateral-evolutions/network/74-define-tracing/wil6210.patch
@@ -0,0 +1,9 @@
+--- a/drivers/net/wireless/ath/wil6210/trace.c
++++ b/drivers/net/wireless/ath/wil6210/trace.c
+@@ -16,5 +16,6 @@
+ 
+ #include <linux/module.h>
+ 
++#include "trace.h"
+ #define CREATE_TRACE_POINTS
+ #include "trace.h"
-- 
1.7.10.4

