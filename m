Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:59181 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbbDAPbr (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 1 Apr 2015 11:31:47 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/5] backports: backport kvfree
Date: Wed,  1 Apr 2015 17:31:39 +0200
Message-Id: <1427902299-24079-5-git-send-email-johannes@sipsolutions.net> (sfid-20150401_173151_181419_A67BABEA)
In-Reply-To: <1427902299-24079-1-git-send-email-johannes@sipsolutions.net>
References: <1427902299-24079-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This has been in the kernel for a long time, but wasn't
used by anyone. Now it's used by rhashtable, so add it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/mm.h |  5 +++++
 backport/compat/backport-3.15.c      | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index efb2ca70aca0..d6cbffebc84d 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -25,6 +25,11 @@
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+#define kvfree LINUX_BACKPORT(kvfree)
+void kvfree(const void *addr);
+#endif /* < 3.15 */
+
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,20,0))
 #define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked)
 static inline long
diff --git a/backport/compat/backport-3.15.c b/backport/compat/backport-3.15.c
index 75216eb990b2..c6f9d43813a5 100644
--- a/backport/compat/backport-3.15.c
+++ b/backport/compat/backport-3.15.c
@@ -13,6 +13,8 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
 #include <net/net_namespace.h>
 
 #if IS_ENABLED(CPTCFG_IEEE802154_6LOWPAN)
@@ -88,3 +90,12 @@ int of_property_count_elems_of_size(const struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(of_property_count_elems_of_size);
 #endif
+
+void kvfree(const void *addr)
+{
+	if (is_vmalloc_addr(addr))
+		vfree(addr);
+	else
+		kfree(addr);
+}
+EXPORT_SYMBOL_GPL(kvfree);
-- 
2.1.4

