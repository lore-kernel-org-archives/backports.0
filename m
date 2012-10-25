Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50844 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab2JYWRV (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 25 Oct 2012 18:17:21 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] compat-drivers: deactivate cfg80211 tracing for kernels <= 2.6.32
Date: Fri, 26 Oct 2012 00:17:10 +0200
Message-Id: <1351203430-6865-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1351203430-6865-1-git-send-email-hauke@hauke-m.de>
References: <1351203430-6865-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk                                          |    4 ++++
 .../network/44-deactivate-mac80211-tracing.patch   |   14 +++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/config.mk b/config.mk
index 4a390fd..f743e05 100644
--- a/config.mk
+++ b/config.mk
@@ -187,6 +187,10 @@ export CONFIG_CFG80211_DEFAULT_PS=y
 # export CONFIG_CFG80211_INTERNAL_REGDB=y
 # See below for wext stuff
 
+ifndef CONFIG_COMPAT_KERNEL_2_6_33
+export CONFIG_COMPAT_CFG80211_DRIVER_API_TRACER=y
+endif #CONFIG_COMPAT_KERNEL_2_6_33
+
 export CONFIG_LIB80211=m
 export CONFIG_LIB80211_CRYPT_WEP=m
 export CONFIG_LIB80211_CRYPT_CCMP=m
diff --git a/patches/network/44-deactivate-mac80211-tracing.patch b/patches/network/44-deactivate-mac80211-tracing.patch
index 8ca585a..9c9858d 100644
--- a/patches/network/44-deactivate-mac80211-tracing.patch
+++ b/patches/network/44-deactivate-mac80211-tracing.patch
@@ -2,7 +2,7 @@ Do not activate the mac80211 tracing for kernels <= 2.6.32
 
 --- a/net/mac80211/Makefile
 +++ b/net/mac80211/Makefile
-@@ -24,7 +24,9 @@ mac80211-y := \
+@@ -25,7 +25,9 @@ mac80211-y := \
  	wme.o \
  	event.o \
  	chan.o \
@@ -13,3 +13,15 @@ Do not activate the mac80211 tracing for kernels <= 2.6.32
  
  mac80211-$(CONFIG_MAC80211_LEDS) += led.o
  mac80211-$(CONFIG_MAC80211_DEBUGFS) += \
+--- a/net/wireless/Makefile
++++ b/net/wireless/Makefile
+@@ -10,7 +10,8 @@ obj-$(CONFIG_WEXT_SPY) += wext-spy.o
+ obj-$(CONFIG_WEXT_PRIV) += wext-priv.o
+ 
+ cfg80211-y += core.o sysfs.o radiotap.o util.o reg.o scan.o nl80211.o
+-cfg80211-y += mlme.o ibss.o sme.o chan.o ethtool.o mesh.o ap.o trace.o
++cfg80211-y += mlme.o ibss.o sme.o chan.o ethtool.o mesh.o ap.o
++cfg80211-$(CONFIG_COMPAT_CFG80211_DRIVER_API_TRACER) += trace.o
+ cfg80211-$(CONFIG_CFG80211_DEBUGFS) += debugfs.o
+ cfg80211-$(CONFIG_CFG80211_WEXT) += wext-compat.o wext-sme.o
+ cfg80211-$(CONFIG_CFG80211_INTERNAL_REGDB) += regdb.o
-- 
1.7.9.5

