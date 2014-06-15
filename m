Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44869 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216AbaFOVWU (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id AC1787E59
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:19 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/19] backports: add split_page()
Date: Sun, 15 Jun 2014 23:21:37 +0200
Message-Id: <1402867307-31337-10-git-send-email-hauke@hauke-m.de> (sfid-20140615_232222_198839_1BB76126)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/backport-3.10.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
index 9bcb805..e75e52e 100644
--- a/backport/compat/backport-3.10.c
+++ b/backport/compat/backport-3.10.c
@@ -17,6 +17,7 @@
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/of.h>
+#include <linux/mm.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
 #include <linux/init.h>
@@ -232,3 +233,48 @@ int of_property_read_u32_index(const struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(of_property_read_u32_index);
 #endif /* CONFIG_OF */
+
+static inline void set_page_count(struct page *page, int v)
+{
+	atomic_set(&page->_count, v);
+}
+
+/*
+ * Turn a non-refcounted page (->_count == 0) into refcounted with
+ * a count of one.
+ */
+static inline void set_page_refcounted(struct page *page)
+{
+	VM_BUG_ON(PageTail(page));
+	VM_BUG_ON(atomic_read(&page->_count));
+	set_page_count(page, 1);
+}
+
+/*
+ * split_page takes a non-compound higher-order page, and splits it into
+ * n (1<<order) sub-pages: page[0..n]
+ * Each sub-page must be freed individually.
+ *
+ * Note: this is probably too low level an operation for use in drivers.
+ * Please consult with lkml before using this in your driver.
+ */
+void split_page(struct page *page, unsigned int order)
+{
+	int i;
+
+	VM_BUG_ON(PageCompound(page));
+	VM_BUG_ON(!page_count(page));
+
+#ifdef CONFIG_KMEMCHECK
+	/*
+	 * Split shadow pages too, because free(page[0]) would
+	 * otherwise free the whole shadow.
+	 */
+	if (kmemcheck_page_is_tracked(page))
+		split_page(virt_to_page(page[0].shadow), order);
+#endif
+
+	for (i = 1; i < (1 << order); i++)
+		set_page_refcounted(page + i);
+}
+EXPORT_SYMBOL_GPL(split_page);
-- 
1.9.1

