Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/8] compat-drivers: add CONFIG_MWIFIEX_USB in config.mk
Date: Tue,  6 Nov 2012 00:11:54 +0100
Message-Id: <1352157115-13469-8-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
References: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

The driver at least compiles with all supported kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk                               |    2 ++
 patches/network/06-header-changes.patch |   10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/config.mk b/config.mk
index 985fb6a..dde8554 100644
--- a/config.mk
+++ b/config.mk
@@ -558,6 +558,8 @@ export CONFIG_BT_ATH3K=m
 
 export CONFIG_RTL8192CU=m
 
+export CONFIG_MWIFIEX_USB=m
+
 endif #CONFIG_USB end of USB driver list
 
 ifdef CONFIG_SPI_MASTER
diff --git a/patches/network/06-header-changes.patch b/patches/network/06-header-changes.patch
index d77e5fb..cd587cd 100644
--- a/patches/network/06-header-changes.patch
+++ b/patches/network/06-header-changes.patch
@@ -115,3 +115,13 @@ cases.
  
  #include "core.h"
  #include "cfg80211.h"
+--- a/drivers/net/wireless/mwifiex/usb.c
++++ b/drivers/net/wireless/mwifiex/usb.c
+@@ -19,6 +19,7 @@
+ 
+ #include "main.h"
+ #include "usb.h"
++#include <linux/usb/audio.h>
+ 
+ #define USB_VERSION	"1.0"
+ 
-- 
1.7.10.4
