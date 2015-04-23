Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39443 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757359AbbDWLee (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 23 Apr 2015 07:34:34 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 3/4] backports: deal with struct timespec64 changes
Date: Thu, 23 Apr 2015 13:33:44 +0200
Message-Id: <1429788825-18466-4-git-send-email-sassmann@kpanic.de> (sfid-20150423_133435_798363_434AF0F4)
In-Reply-To: <1429788825-18466-1-git-send-email-sassmann@kpanic.de>
References: <1429788825-18466-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

igb now makes use of struct timespec64. Deal with the required
changes via cocci patches where possible. There's one occasion
where coccinelle is not able to deal with defining a struct and
assigning another struct on the same line.
Example:
struct timespec64 now, then = ns_to_timespec64(delta);
Deal with this in a separate patch for now.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0057-timespec64/INFO                   | 11 +++
 .../network/0057-timespec64/igb.patch              | 16 +++++
 .../network/0057-timespec64/timespec64.cocci       | 83 ++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0057-timespec64/INFO
 create mode 100644 patches/collateral-evolutions/network/0057-timespec64/igb.patch
 create mode 100644 patches/collateral-evolutions/network/0057-timespec64/timespec64.cocci

diff --git a/patches/collateral-evolutions/network/0057-timespec64/INFO b/patches/collateral-evolutions/network/0057-timespec64/INFO
new file mode 100644
index 0000000..681c1df
--- /dev/null
+++ b/patches/collateral-evolutions/network/0057-timespec64/INFO
@@ -0,0 +1,11 @@
+In kernel 3.17 struct timespec64 was introduced.
+Address this with cocci patches where possible.
+
+commit 361a3bf00582469877f8d18ff20f1efa6b781274
+Author: John Stultz <john.stultz@linaro.org>
+Date:   Wed Jul 16 21:03:58 2014 +0000
+
+    time64: Add time64.h header and define struct timespec64
+
+git describe --contains 361a3bf00582469877f8d18ff20f1efa6b781274
+v3.17-rc1~109^2~62
diff --git a/patches/collateral-evolutions/network/0057-timespec64/igb.patch b/patches/collateral-evolutions/network/0057-timespec64/igb.patch
new file mode 100644
index 0000000..559199f
--- /dev/null
+++ b/patches/collateral-evolutions/network/0057-timespec64/igb.patch
@@ -0,0 +1,16 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
+index 060aa75..a660d39 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
++++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
+@@ -285,7 +285,11 @@ static int igb_ptp_adjtime_i210(struct ptp_clock_info *ptp, s64 delta)
+ 	struct igb_adapter *igb = container_of(ptp, struct igb_adapter,
+ 					       ptp_caps);
+ 	unsigned long flags;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 	struct timespec64 now, then = ns_to_timespec64(delta);
++#else
++	struct timespec now, then = ns_to_timespec(delta);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0) */
+ 
+ 	spin_lock_irqsave(&igb->tmreg_lock, flags);
+ 
diff --git a/patches/collateral-evolutions/network/0057-timespec64/timespec64.cocci b/patches/collateral-evolutions/network/0057-timespec64/timespec64.cocci
new file mode 100644
index 0000000..4f568cb
--- /dev/null
+++ b/patches/collateral-evolutions/network/0057-timespec64/timespec64.cocci
@@ -0,0 +1,83 @@
+// ----------------------------------------------------------------------------
+// handle struct timespec64 to timespec conversion in prototypes
+@r1@
+identifier func, I1;
+@@
+ func(...
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+      ,struct timespec64 *I1
++#else
++     ,struct timespec *I1
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0) */
+ ) {...}
+
+// ----------------------------------------------------------------------------
+// handle struct timespec64 to timespec conversion in functions
+@r2@
+identifier I1;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ struct timespec64 I1;
++#else
++struct timespec I1;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0) */
+
+// ----------------------------------------------------------------------------
+// handle struct timespec64 to timespec conversion with assignment
+@r3@
+identifier I1;
+expression E1;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ struct timespec64 I1 = E1;
++#else
++struct timespec I1 = E1;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0) */
+
+// ----------------------------------------------------------------------------
+// handle struct timespec64 to timespec casts
+@r4@
+identifier func;
+expression E1, E2;
+@@
+ func(E1
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+      ,(const struct timespec64 *) E2
++#else
++     ,(const struct timespec *) E2
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0) */
+ );
+
+// ----------------------------------------------------------------------------
+// handle timespec64_add to timespec_add function rename
+@r5@
+identifier I1;
+expression E1, E2;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ I1 = timespec64_add(E1, E2);
++#else
++I1 = timespec_add(E1, E2);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0) */
+
+// ----------------------------------------------------------------------------
+// handle ns_to_timespec64 to ns_to_timespec function rename
+@r6@
+expression E1, E2;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ E1 = ns_to_timespec64(E2);
++#else
++E1 = ns_to_timespec(E2);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0) */
+
+// ----------------------------------------------------------------------------
+// handle timespec64_to_ns to timespec_to_ns function rename
+@r7@
+expression E1, E2;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ E1 = timespec64_to_ns(E2);
++#else
++E1 = timespec_to_ns(E2);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0) */
-- 
2.1.0

