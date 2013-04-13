Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44213 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809Ab3DMXyK (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:54:10 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 03/42] backports: patch tracing for older kernels
Date: Sun, 14 Apr 2013 01:53:23 +0200
Message-Id: <1365897243-31214-4-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015413_927914_BB511F7C)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

For some reason the tracing on older kernels requires
the tracing to be declared before it's defined; it's
broken when the trace header is only included to create
the tracepoints.

Since new kernels don't, add patches for the two places
that rely on the new behaviour.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../network/74-define-tracing/ath6kl.patch                     | 10 ++++++++++
 .../network/74-define-tracing/cfg80211.patch                   |  8 ++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/74-define-tracing/ath6kl.patch
 create mode 100644 patches/collateral-evolutions/network/74-define-tracing/cfg80211.patch

diff --git a/patches/collateral-evolutions/network/74-define-tracing/ath6kl.patch b/patches/collateral-evolutions/network/74-define-tracing/ath6kl.patch
new file mode 100644
index 0000000..5910f54
--- /dev/null
+++ b/patches/collateral-evolutions/network/74-define-tracing/ath6kl.patch
@@ -0,0 +1,10 @@
+--- a/drivers/net/wireless/ath/ath6kl/trace.c
++++ b/drivers/net/wireless/ath/ath6kl/trace.c
+@@ -16,6 +16,7 @@
+ 
+ #include <linux/module.h>
+ 
++#include "trace.h"
+ #define CREATE_TRACE_POINTS
+ #include "trace.h"
+ 
diff --git a/patches/collateral-evolutions/network/74-define-tracing/cfg80211.patch b/patches/collateral-evolutions/network/74-define-tracing/cfg80211.patch
new file mode 100644
index 0000000..eeab23d
--- /dev/null
+++ b/patches/collateral-evolutions/network/74-define-tracing/cfg80211.patch
@@ -0,0 +1,8 @@
+--- a/net/wireless/trace.c
++++ b/net/wireless/trace.c
+@@ -1,4 +1,5 @@
+ #include <linux/module.h>
++#include "trace.h"
+ 
+ #ifndef __CHECKER__
+ #define CREATE_TRACE_POINTS
-- 
1.8.0

