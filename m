Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/24] compat-drivers: add include for net/if_inet6.h to net/mac80211.h
Date: Tue, 26 Feb 2013 21:38:03 +0100
Message-Id: <1361911096-29117-12-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Some older kernels are missing the declaration of struct inet6_dev in
this file.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../collateral-evolutions/network/06-header-changes.patch    |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/patches/collateral-evolutions/network/06-header-changes.patch b/patches/collateral-evolutions/network/06-header-changes.patch
index 5da05c0..a619fa7 100644
--- a/patches/collateral-evolutions/network/06-header-changes.patch
+++ b/patches/collateral-evolutions/network/06-header-changes.patch
@@ -135,3 +135,13 @@ cases.
  #include "core.h"
  #include "rdev-ops.h"
  
+--- a/include/net/mac80211.h
++++ b/include/net/mac80211.h
+@@ -20,6 +20,7 @@
+ #include <linux/ieee80211.h>
+ #include <net/cfg80211.h>
+ #include <asm/unaligned.h>
++#include <net/if_inet6.h>
+ 
+ /**
+  * DOC: Introduction
-- 
1.7.10.4
