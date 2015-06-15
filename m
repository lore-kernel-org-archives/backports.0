Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41849 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbbFOVNI (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Jun 2015 17:13:08 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 02/22] patches: fix tracing on older kernels for cfg80211, ath6kl and wil6210
Date: Mon, 15 Jun 2015 23:13:00 +0200
Message-Id: <1434402780-22515-1-git-send-email-hauke@hauke-m.de> (sfid-20150615_231311_034776_18DDE715)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On kernel 3.0 we have to include linux/interrupt.h, because it
otherwise results in a long compile errors about missing HI_SOFTIRQ for
example. It looks like it was not possible to activate tracing without
this patch on these drivers at all.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0022-define-tracing/ath6kl.patch                      | 8 +++++---
 .../network/0022-define-tracing/cfg80211.patch                    | 6 ++++--
 .../network/0022-define-tracing/wil6210.patch                     | 7 +++++--
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/patches/collateral-evolutions/network/0022-define-tracing/ath6kl.patch b/patches/collateral-evolutions/network/0022-define-tracing/ath6kl.patch
index 5910f54..bdf455a 100644
--- a/patches/collateral-evolutions/network/0022-define-tracing/ath6kl.patch
+++ b/patches/collateral-evolutions/network/0022-define-tracing/ath6kl.patch
@@ -1,10 +1,12 @@
 --- a/drivers/net/wireless/ath/ath6kl/trace.c
 +++ b/drivers/net/wireless/ath/ath6kl/trace.c
-@@ -16,6 +16,7 @@
+@@ -15,6 +15,9 @@
+  */
  
  #include <linux/module.h>
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
++#include <linux/interrupt.h>
++#endif
  
-+#include "trace.h"
  #define CREATE_TRACE_POINTS
  #include "trace.h"
- 
diff --git a/patches/collateral-evolutions/network/0022-define-tracing/cfg80211.patch b/patches/collateral-evolutions/network/0022-define-tracing/cfg80211.patch
index eeab23d..95a0d6a 100644
--- a/patches/collateral-evolutions/network/0022-define-tracing/cfg80211.patch
+++ b/patches/collateral-evolutions/network/0022-define-tracing/cfg80211.patch
@@ -1,8 +1,10 @@
 --- a/net/wireless/trace.c
 +++ b/net/wireless/trace.c
-@@ -1,4 +1,5 @@
+@@ -1,4 +1,7 @@
  #include <linux/module.h>
-+#include "trace.h"
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
++#include <linux/interrupt.h>
++#endif
  
  #ifndef __CHECKER__
  #define CREATE_TRACE_POINTS
diff --git a/patches/collateral-evolutions/network/0022-define-tracing/wil6210.patch b/patches/collateral-evolutions/network/0022-define-tracing/wil6210.patch
index 1888cd7..5f4b43b 100644
--- a/patches/collateral-evolutions/network/0022-define-tracing/wil6210.patch
+++ b/patches/collateral-evolutions/network/0022-define-tracing/wil6210.patch
@@ -1,9 +1,12 @@
 --- a/drivers/net/wireless/ath/wil6210/trace.c
 +++ b/drivers/net/wireless/ath/wil6210/trace.c
-@@ -16,5 +16,6 @@
+@@ -15,6 +15,9 @@
+  */
  
  #include <linux/module.h>
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
++#include <linux/interrupt.h>
++#endif
  
-+#include "trace.h"
  #define CREATE_TRACE_POINTS
  #include "trace.h"
-- 
2.1.4

