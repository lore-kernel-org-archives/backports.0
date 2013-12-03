Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:43457 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab3LCOFV (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 3 Dec 2013 09:05:21 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: add support for prandom_bytes
Date: Tue,  3 Dec 2013 15:05:15 +0100
Message-Id: <1386079515-7792-1-git-send-email-johannes@sipsolutions.net> (sfid-20131203_150543_652413_A53547AD)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This was added in 3.8 and not used until now.
Since it it being used by the wireless stack, backport it.

Change-Id: I061a55e0af96464dfda53a0ad60a00e2c42d07f2
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/random.h |  3 +++
 backport/compat/compat-3.8.c             | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
index 812ce7f..e915106 100644
--- a/backport/backport-include/linux/random.h
+++ b/backport/backport-include/linux/random.h
@@ -8,6 +8,9 @@
 #define prandom_seed(_seed)		srandom32(_seed)
 #define prandom_u32()			random32()
 #define prandom_u32_state(_state)	prandom32(_state)
+/* backport 6582c665d6b882dad8329e05749fbcf119f1ab88 */
+#define prandom_bytes LINUX_BACKPORT(prandom_bytes)
+void prandom_bytes(void *buf, int bytes);
 #endif
 
 #endif /* __BACKPORT_RANDOM_H */
diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
index d43d386..538f51d 100644
--- a/backport/compat/compat-3.8.c
+++ b/backport/compat/compat-3.8.c
@@ -419,6 +419,37 @@ int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long
 }
 EXPORT_SYMBOL_GPL(vm_iomap_memory);
 
+/**
+ *	prandom_bytes - get the requested number of pseudo-random bytes
+ *	@buf: where to copy the pseudo-random bytes to
+ *	@bytes: the requested number of bytes
+ */
+void prandom_bytes(void *buf, int bytes)
+{
+	unsigned char *p = buf;
+	int i;
+
+	for (i = 0; i < round_down(bytes, sizeof(u32)); i += sizeof(u32)) {
+		u32 random = random32();
+		int j;
+
+		for (j = 0; j < sizeof(u32); j++) {
+			p[i + j] = random;
+			random >>= BITS_PER_BYTE;
+		}
+	}
+
+	if (i < bytes) {
+		u32 random = random32();
+
+		for (; i < bytes; i++) {
+			p[i] = random;
+			random >>= BITS_PER_BYTE;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(prandom_bytes_state);
+
 #ifdef CONFIG_OF
 /**
  * of_find_property_value_of_size
-- 
1.8.4.rc3

