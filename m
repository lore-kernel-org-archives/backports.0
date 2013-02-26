Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/24] compat-drivers: add missing include for export
Date: Tue, 26 Feb 2013 21:38:04 +0100
Message-Id: <1361911096-29117-13-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

drivers/net/wireless/ti/wlcore/scan.c and drivers/net/wireless/ti/wlcore
/event.c need an #include <linux/export.h> to add EXPORT_SYMBOL_GPL on
kernel 3.2 and 3.3.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/06-header-changes.patch                |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/patches/collateral-evolutions/network/06-header-changes.patch b/patches/collateral-evolutions/network/06-header-changes.patch
index a619fa7..ca62bd3 100644
--- a/patches/collateral-evolutions/network/06-header-changes.patch
+++ b/patches/collateral-evolutions/network/06-header-changes.patch
@@ -145,3 +145,23 @@ cases.
  
  /**
   * DOC: Introduction
+--- a/drivers/net/wireless/ti/wlcore/event.c
++++ b/drivers/net/wireless/ti/wlcore/event.c
+@@ -21,6 +21,7 @@
+  *
+  */
+ 
++#include <linux/export.h>
+ #include "wlcore.h"
+ #include "debug.h"
+ #include "io.h"
+--- a/drivers/net/wireless/ti/wlcore/scan.c
++++ b/drivers/net/wireless/ti/wlcore/scan.c
+@@ -22,6 +22,7 @@
+  */
+ 
+ #include <linux/ieee80211.h>
++#include <linux/export.h>
+ 
+ #include "wlcore.h"
+ #include "debug.h"
-- 
1.7.10.4
