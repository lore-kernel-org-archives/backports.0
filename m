Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/24] compat-drivers: deactivate mac80211_hwsim for kernel < 2.6.31
Date: Tue, 26 Feb 2013 21:37:58 +0100
Message-Id: <1361911096-29117-7-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

kernel version < 2.6.31 does not support tasklet_hrtimer, so deactivate
the driver there.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk                                                       |    4 +++-
 .../network/08-rename-config-options.patch                      |    7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/config.mk b/config.mk
index 6af57a4..d0f2e0b 100644
--- a/config.mk
+++ b/config.mk
@@ -256,8 +256,10 @@ ifdef CONFIG_STAGING
 export CONFIG_COMPAT_STAGING=m
 endif #CONFIG_STAGING
 
+ifndef CONFIG_COMPAT_KERNEL_2_6_31
 # mac80211 test driver
-export CONFIG_MAC80211_HWSIM=m
+export CONFIG_COMPAT_MAC80211_HWSIM=m
+endif #CONFIG_COMPAT_KERNEL_2_6_31
 
 export CONFIG_ATH5K=m
 # export CONFIG_ATH5K_DEBUG=y
diff --git a/patches/collateral-evolutions/network/08-rename-config-options.patch b/patches/collateral-evolutions/network/08-rename-config-options.patch
index 49a2fd4..72e9b58 100644
--- a/patches/collateral-evolutions/network/08-rename-config-options.patch
+++ b/patches/collateral-evolutions/network/08-rename-config-options.patch
@@ -30,7 +30,12 @@ CONFIG_BT_HIDP does not build with older kernel versions.
  obj-$(CONFIG_RTL8180)		+= rtl818x/
  obj-$(CONFIG_RTL8187)		+= rtl818x/
  obj-$(CONFIG_RTLWIFI)		+= rtlwifi/
-@@ -53,7 +53,7 @@ obj-$(CONFIG_MAC80211_HWSIM)	+= mac80211
+@@ -49,11 +49,11 @@ obj-$(CONFIG_P54_COMMON)	+= p54/
+ 
+ obj-$(CONFIG_ATH_CARDS)		+= ath/
+ 
+-obj-$(CONFIG_MAC80211_HWSIM)	+= mac80211_hwsim.o
++obj-$(CONFIG_COMPAT_MAC80211_HWSIM)	+= mac80211_hwsim.o
  
  obj-$(CONFIG_WL_TI)	+= ti/
  
-- 
1.7.10.4
