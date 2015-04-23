Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59016 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757453AbbDWLez (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 23 Apr 2015 07:34:55 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 4/4] backports: deal with struct struct ptp_clock_info get/settime64 changes
Date: Thu, 23 Apr 2015 13:33:45 +0200
Message-Id: <1429788825-18466-5-git-send-email-sassmann@kpanic.de> (sfid-20150423_133456_470749_DFD5FB4C)
In-Reply-To: <1429788825-18466-1-git-send-email-sassmann@kpanic.de>
References: <1429788825-18466-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 4.1 struct ptp_clock_info changes function pointers gettime,
settime to gettime64, settime64.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0058-ptp_getsettime64/INFO             | 11 ++++++++
 .../0058-ptp_getsettime64/ptp_getsettime64.cocci   | 33 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0058-ptp_getsettime64/INFO
 create mode 100644 patches/collateral-evolutions/network/0058-ptp_getsettime64/ptp_getsettime64.cocci

diff --git a/patches/collateral-evolutions/network/0058-ptp_getsettime64/INFO b/patches/collateral-evolutions/network/0058-ptp_getsettime64/INFO
new file mode 100644
index 0000000..9679d31
--- /dev/null
+++ b/patches/collateral-evolutions/network/0058-ptp_getsettime64/INFO
@@ -0,0 +1,11 @@
+In kernel 4.1 struct ptp_clock_info changes function pointers gettime,
+settime to gettime64, settime64.
+
+commit 92f1719407b90475b3be0b7b9c983dec2ff8351e
+Author: Richard Cochran <richardcochran@gmail.com>
+Date:   Sun Mar 29 23:11:51 2015 +0200
+
+    ptp: introduce get/set time methods with explicit 64 bit seconds.
+
+git describe --contains 92f1719407b90475b3be0b7b9c983dec2ff8351e
+next-20150401~92^2~18^2~22
diff --git a/patches/collateral-evolutions/network/0058-ptp_getsettime64/ptp_getsettime64.cocci b/patches/collateral-evolutions/network/0058-ptp_getsettime64/ptp_getsettime64.cocci
new file mode 100644
index 0000000..3f85c2a
--- /dev/null
+++ b/patches/collateral-evolutions/network/0058-ptp_getsettime64/ptp_getsettime64.cocci
@@ -0,0 +1,33 @@
+// ----------------------------------------------------------------------------
+// handle gettime64 to gettime function assignments
+@r1@
+expression E1, E2;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ E1.gettime64 = E2;
++#else
++E1.gettime = E2;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+
+// ----------------------------------------------------------------------------
+// handle calls to gettime64 as calls to gettime
+@r2@
+expression E1, E2, E3;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ E1.gettime64(E2, E3);
++#else
++E1.gettime(E2, E3);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+
+// ----------------------------------------------------------------------------
+// handle settime64 to settime function assignments
+@r3@
+expression E1, E2;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+ E1.settime64 = E2;
++#else
++E1.settime = E2;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+
-- 
2.1.0

