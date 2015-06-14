Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41027 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbbFNO3f (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:35 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/21] patches: deactivate tracing for ath6kl, cfg80211 and wil6210 only on kernel < 3.4
Date: Sun, 14 Jun 2015 16:29:03 +0200
Message-Id: <1434292162-2261-3-git-send-email-hauke@hauke-m.de> (sfid-20150614_162942_666968_4E02D0D5)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On kernel version >= 3.4 we can normally include tracing, only on such
old kernel we have to deactivate the tracing code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0022-define-tracing/ath6kl.patch                      | 4 +++-
 .../network/0022-define-tracing/cfg80211.patch                    | 8 ++++++--
 .../network/0022-define-tracing/wil6210.patch                     | 4 +++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/patches/collateral-evolutions/network/0022-define-tracing/ath6kl.patch b/patches/collateral-evolutions/network/0022-define-tracing/ath6kl.patch
index 5910f54..b6e8c35 100644
--- a/patches/collateral-evolutions/network/0022-define-tracing/ath6kl.patch
+++ b/patches/collateral-evolutions/network/0022-define-tracing/ath6kl.patch
@@ -1,10 +1,12 @@
 --- a/drivers/net/wireless/ath/ath6kl/trace.c
 +++ b/drivers/net/wireless/ath/ath6kl/trace.c
-@@ -16,6 +16,7 @@
+@@ -16,6 +16,9 @@
  
  #include <linux/module.h>
  
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
 +#include "trace.h"
++#endif
  #define CREATE_TRACE_POINTS
  #include "trace.h"
  
diff --git a/patches/collateral-evolutions/network/0022-define-tracing/cfg80211.patch b/patches/collateral-evolutions/network/0022-define-tracing/cfg80211.patch
index eeab23d..8b59837 100644
--- a/patches/collateral-evolutions/network/0022-define-tracing/cfg80211.patch
+++ b/patches/collateral-evolutions/network/0022-define-tracing/cfg80211.patch
@@ -1,8 +1,12 @@
 --- a/net/wireless/trace.c
 +++ b/net/wireless/trace.c
-@@ -1,4 +1,5 @@
+@@ -1,6 +1,9 @@
  #include <linux/module.h>
-+#include "trace.h"
  
  #ifndef __CHECKER__
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
++#include "trace.h"
++#endif
  #define CREATE_TRACE_POINTS
+ #include "trace.h"
+ 
diff --git a/patches/collateral-evolutions/network/0022-define-tracing/wil6210.patch b/patches/collateral-evolutions/network/0022-define-tracing/wil6210.patch
index 1888cd7..ec9df86 100644
--- a/patches/collateral-evolutions/network/0022-define-tracing/wil6210.patch
+++ b/patches/collateral-evolutions/network/0022-define-tracing/wil6210.patch
@@ -1,9 +1,11 @@
 --- a/drivers/net/wireless/ath/wil6210/trace.c
 +++ b/drivers/net/wireless/ath/wil6210/trace.c
-@@ -16,5 +16,6 @@
+@@ -16,5 +16,8 @@
  
  #include <linux/module.h>
  
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
 +#include "trace.h"
++#endif
  #define CREATE_TRACE_POINTS
  #include "trace.h"
-- 
2.1.4

