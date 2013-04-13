Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44283 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab3DMX4A (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:56:00 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 39/42] backports: avoid vfree() const warning
Date: Sun, 14 Apr 2013 01:53:59 +0200
Message-Id: <1365897243-31214-40-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015643_522074_2698F035)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

On newer kernels const pointers can be passed to vfree()
and vunmap(), doing so on old kernels causes warnings
that we can suppress with a cast.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/vmalloc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/vmalloc.h b/backport/backport-include/linux/vmalloc.h
index c47536f..9e8ff3b 100644
--- a/backport/backport-include/linux/vmalloc.h
+++ b/backport/backport-include/linux/vmalloc.h
@@ -3,6 +3,12 @@
 #include_next <linux/vmalloc.h>
 #include <linux/version.h>
 
+/* avoid warnings due to b3bdda02aa547a0753b4fdbc105e86ef9046b30b */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
+#define vfree(ptr) vfree((void *)(ptr))
+#define vunmap(ptr) vunmap((void *)(ptr))
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
 #define vzalloc LINUX_BACKPORT(vzalloc)
 extern void *vzalloc(unsigned long size);
-- 
1.8.0

