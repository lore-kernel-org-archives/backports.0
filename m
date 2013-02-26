Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/24] compat-drivers: add missing include linux/export.h
Date: Tue, 26 Feb 2013 21:38:08 +0100
Message-Id: <1361911096-29117-17-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/collateral-evolutions/network/06-header-changes.patch |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/patches/collateral-evolutions/network/06-header-changes.patch b/patches/collateral-evolutions/network/06-header-changes.patch
index ca62bd3..647ce84 100644
--- a/patches/collateral-evolutions/network/06-header-changes.patch
+++ b/patches/collateral-evolutions/network/06-header-changes.patch
@@ -75,6 +75,15 @@ cases.
  
  /**
   * DOC: Key handling basics
+--- a/net/mac80211/pm.c
++++ b/net/mac80211/pm.c
+@@ -1,5 +1,6 @@
+ #include <net/mac80211.h>
+ #include <net/rtnetlink.h>
++#include <linux/export.h>
+ 
+ #include "ieee80211_i.h"
+ #include "mesh.h"
 --- a/net/bluetooth/bnep/sock.c
 +++ b/net/bluetooth/bnep/sock.c
 @@ -26,6 +26,7 @@
-- 
1.7.10.4
