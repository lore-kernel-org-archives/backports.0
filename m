Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48455 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933900AbbDWLe1 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 23 Apr 2015 07:34:27 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 1/4] backports: handle ndo_gso_check() to ndo_features_check() changes
Date: Thu, 23 Apr 2015 13:33:42 +0200
Message-Id: <1429788825-18466-2-git-send-email-sassmann@kpanic.de> (sfid-20150423_133429_138894_3B1C14E6)
In-Reply-To: <1429788825-18466-1-git-send-email-sassmann@kpanic.de>
References: <1429788825-18466-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 3.19 function pointer ndo_gso_check is changed into
ndo_features_check in struct net_device_ops.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0056-ndo_features_check/INFO              | 12 ++++++++++++
 .../0056-ndo_features_check/features_check.cocci      | 19 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0056-ndo_features_check/INFO
 create mode 100644 patches/collateral-evolutions/network/0056-ndo_features_check/features_check.cocci

diff --git a/patches/collateral-evolutions/network/0056-ndo_features_check/INFO b/patches/collateral-evolutions/network/0056-ndo_features_check/INFO
new file mode 100644
index 0000000..c3f7a92
--- /dev/null
+++ b/patches/collateral-evolutions/network/0056-ndo_features_check/INFO
@@ -0,0 +1,12 @@
+In kernel 3.19 function pointer ndo_gso_check is changed into
+ndo_features_check in struct net_device_ops.
+Address this by putting ifdef around the code.
+
+commit 5f35227ea34bb616c436d9da47fc325866c428f3
+Author: Jesse Gross <jesse@nicira.com>
+Date:   Tue Dec 23 22:37:26 2014 -0800
+
+    net: Generalize ndo_gso_check to ndo_features_check
+
+git describe --contains 5f35227ea34bb616c436d9da47fc325866c428f3
+v3.19-rc3~16^2~7
diff --git a/patches/collateral-evolutions/network/0056-ndo_features_check/features_check.cocci b/patches/collateral-evolutions/network/0056-ndo_features_check/features_check.cocci
new file mode 100644
index 0000000..7956e5c
--- /dev/null
+++ b/patches/collateral-evolutions/network/0056-ndo_features_check/features_check.cocci
@@ -0,0 +1,19 @@
+@r1@
+identifier s, func;
+@@
+
+struct net_device_ops s = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+.ndo_features_check = func,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0) */
+};
+
+// ----------------------------------------------------------------------
+
+@r2@
+identifier r1.func;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+func(...) { ... }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0) */
-- 
2.1.0

