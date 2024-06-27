Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734401A2FB5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532142; cv=none; b=hjoM6c3tNnUjXFvOvxGee2s1A36m+LyTXj4mfsKtak8qOAuKLhtbMt+UVySGdRhpb5Pwx7BwtPAUMU6fWaH1CrJ3Imd4Qb6kBXUPUQb5OnzWpLQGIe0wqyFAX4iGimeRKNm/ClFOBG8/YGhLyPLg+dAsN4LcM8/MpxV0BbbVXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532142; c=relaxed/simple;
	bh=9KyjsLmpu7b9aGO2J4i2oTqbbbJQbrUh4FQ8uXXWfjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neu+1W1akSErd3f/o/EKqask//KVolvUq8+CuxZSKT4fsipFvu/Y9DBjVqPIaeLPeQgfcDlgbDXztGaz0JHNFfEEGFbHzBV/FU/cTq0vOYXcDhdCS7jvL9Dr6Wlz8o/9MGiMlUErTOHT3sULASRYp7r+rCy8Th27ZmmoDLzg6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=nP9E8R2w; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="nP9E8R2w"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdj146lz9spY;
	Fri, 28 Jun 2024 01:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6HSV0VgUeWhm7cRPSG5xxYP1qhmlg1KlU1QxLL7iZo=;
	b=nP9E8R2w8T1JxFGvBcHg6n4Pl1fhBAuILBL09DSOMRxnxFkNnR9vjf9FONBtNKqA0qAhND
	s6BLuqHSU+im0B9Xvy2mAUUFobbL1PlIRB/EgJ/RPCuin+cZgT6Nty6Rb5jqu4lWH9c6S8
	EfvLq2cqvgmT0IxwCRMcc3N5/JTY6kqWEJJl2TxEdLq0lY1PWSvqfDaHpyJNQfgVlp/cDz
	OUN7GF2i7Q/HQwOd6HSF9k0XhdjpoTaSwemAJlA/OMEkD870lwzAzwi+gOyBVIGoxIMzKY
	/ppJeh158AtLQlhEpz6HsMZUcGgx8oHPQAr/EQN/WvDs7XACVDJWd38HgoKcYw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 66/75] backports Add bitmap_alloc and bitmap_alloc
Date: Fri, 28 Jun 2024 01:47:52 +0200
Message-ID: <20240627234808.1253337-67-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions were added in kernel 4.19 and are used by mac80211 and
some drivers now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/bitmap.h | 11 +++++++++++
 backport/compat/Makefile                 |  1 +
 backport/compat/backport-4.19.c          | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 backport/compat/backport-4.19.c

diff --git a/backport/backport-include/linux/bitmap.h b/backport/backport-include/linux/bitmap.h
index a09c5a68..f352b57a 100644
--- a/backport/backport-include/linux/bitmap.h
+++ b/backport/backport-include/linux/bitmap.h
@@ -2,6 +2,17 @@
 #define __BP_LINUX_BITMAP_H
 #include_next <linux/bitmap.h>
 
+#if LINUX_VERSION_IS_LESS(4,19,0)
+#define bitmap_alloc LINUX_BACKPORT(bitmap_alloc)
+unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags);
+
+#define bitmap_zalloc LINUX_BACKPORT(bitmap_zalloc)
+unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags);
+
+#define bitmap_free LINUX_BACKPORT(bitmap_free)
+void bitmap_free(const unsigned long *bitmap);
+#endif
+
 #if LINUX_VERSION_IS_LESS(5,13,0)
 /* Managed variants of the above. */
 #define devm_bitmap_alloc LINUX_BACKPORT(devm_bitmap_alloc)
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 698f14f5..0e48ca01 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -8,6 +8,7 @@ compat-y += main.o
 
 # Kernel backport compatibility code
 compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
+compat-$(CPTCFG_KERNEL_4_19) += backport-4.19.o
 compat-$(CPTCFG_KERNEL_5_2) += backport-5.2.o backport-genetlink.o
 compat-$(CPTCFG_KERNEL_5_3) += backport-5.3.o
 compat-$(CPTCFG_KERNEL_5_5) += backport-5.5.o
diff --git a/backport/compat/backport-4.19.c b/backport/compat/backport-4.19.c
new file mode 100644
index 00000000..4dd00101
--- /dev/null
+++ b/backport/compat/backport-4.19.c
@@ -0,0 +1,21 @@
+#include <linux/bitmap.h>
+#include <linux/slab.h>
+
+unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
+{
+	return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long),
+			     flags);
+}
+EXPORT_SYMBOL_GPL(bitmap_alloc);
+
+unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags)
+{
+	return bitmap_alloc(nbits, flags | __GFP_ZERO);
+}
+EXPORT_SYMBOL_GPL(bitmap_zalloc);
+
+void bitmap_free(const unsigned long *bitmap)
+{
+	kfree(bitmap);
+}
+EXPORT_SYMBOL_GPL(bitmap_free);
-- 
2.45.2

