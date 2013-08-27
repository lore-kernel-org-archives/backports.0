Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:56336 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab3H0TBG (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 15:01:06 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backport: simplify #ifdefs in pci-aspm.h
Date: Tue, 27 Aug 2013 21:01:00 +0200
Message-Id: <1377630060-14855-1-git-send-email-johannes@sipsolutions.net> (sfid-20130827_210108_769799_018EF62B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Just use #else instead of two conditionals.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/pci-aspm.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/backport/backport-include/linux/pci-aspm.h b/backport/backport-include/linux/pci-aspm.h
index 367112e..d072677 100644
--- a/backport/backport-include/linux/pci-aspm.h
+++ b/backport/backport-include/linux/pci-aspm.h
@@ -1,10 +1,8 @@
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26))
 #include_next <linux/pci-aspm.h>
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
+#else
 #define PCIE_LINK_STATE_L0S	1
 #define PCIE_LINK_STATE_L1	2
 #define PCIE_LINK_STATE_CLKPM	4
-- 
1.8.4.rc3

