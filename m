Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6093B1A3
	for <backports@vger.kernel.org>; Fri, 24 May 2024 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716574281; cv=none; b=Gzu46joaKk382VHEa/kNum1hE+zSJ0ai6s+TWPPefnFy2bkZdFfw5wHGYHqOuj1EGCcb1NyoE6r6QIv6wiN8J4QYyjN44CGG7zlLAbUTeva2o0+vela2qouSn0anjoVEMmvN+ENZQ1m2TNu8aF42J8tP87NHkNKIeOZ5Mf1kFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716574281; c=relaxed/simple;
	bh=MIONFP6O2taSumAJaKHaHABGLgzaxU18okg+/PVvrME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIJ/enEUwfHq4dfNuIfZxrdOZQxOmaywYgOVnaz7fWUz7H9I+5yJy/PS8KUCGGFLSIgFe9CM8KC9n81SLLXzPDvogbl60X3qY1wZaTamMS1IomsRYuHUtKZg9Eeq+cCw4CiwUTcJBTmJGEGp43nPWbNlOlZUo6k9WbsStnt+WCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vB3mY0WV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vB3mY0WV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BqrDtpCa8BPaTZZvTUQyq9U5YeS3AFa5nyltjtSX9ZI=;
	t=1716574280; x=1717783880; b=vB3mY0WVNE7IggrvnygdnTqDjEobGV7cvjoBdd7BhMwqYg9
	GmSDmx8f3YEVJJzkI6ccCO920cmqIu8XIYfDeBazI6mb9h3GcGbj6Xos8rqKZBQWtCF9DmNeaoaqD
	SUHYNMN5dOvqIvbjscmfPOy+guo0SsNPnymfBmQDEClVCyxXiVL1WDcn80oWp9Iq7ZQG1E1CtEaUj
	fxVUqp0V3rRx180ZQvH4UMoKBFDm98G146cSQ5lNcl0TKACMfiH3u1zw2kLH+1pbFH54WE1CSY4A3
	dpTXUtazvKJKfUW8X8Uj9ZHy42fkW+1uiZspw8CiqrwP6eMp68QlFuRrkQJ2kcCQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAZNs-00000008bYt-3Vu7;
	Fri, 24 May 2024 20:11:17 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] backports: add bitmap_zalloc/_free
Date: Fri, 24 May 2024 20:11:12 +0200
Message-ID: <20240524201112.a746aafc99cc.I931412aa547e6b26a87de1b90f60fe6403073ef6@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524201112.bfc1a1eeddfa.I6ae09dfd2061693745358ecdac5f703f96b07e00@changeid>
References: <20240524201112.bfc1a1eeddfa.I6ae09dfd2061693745358ecdac5f703f96b07e00@changeid>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/bitmap.h | 10 ++++++++++
 backport/compat/Makefile                 |  1 +
 backport/compat/backport-4.19.c          | 15 +++++++++++++++
 3 files changed, 26 insertions(+)
 create mode 100644 backport/backport-include/linux/bitmap.h
 create mode 100644 backport/compat/backport-4.19.c

diff --git a/backport/backport-include/linux/bitmap.h b/backport/backport-include/linux/bitmap.h
new file mode 100644
index 000000000000..d7a0260b6001
--- /dev/null
+++ b/backport/backport-include/linux/bitmap.h
@@ -0,0 +1,10 @@
+#ifndef __BP_LINUX_BITMAP_H
+#define __BP_LINUX_BITMAP_H
+#include_next <linux/bitmap.h>
+
+#if LINUX_VERSION_IS_LESS(4,19,0)
+unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags);
+void bitmap_free(const unsigned long *bitmap);
+#endif /* < 4.19 */
+
+#endif /* __BP_LINUX_BITMAP_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index bb6fb57edc7e..29a9b3d8faa3 100644
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
index 000000000000..2ea396757ed8
--- /dev/null
+++ b/backport/compat/backport-4.19.c
@@ -0,0 +1,15 @@
+#include <linux/bitmap.h>
+#include <linux/slab.h>
+
+unsigned long *
+bitmap_zalloc(unsigned int nbits, gfp_t flags)
+{
+	return kzalloc(BITS_TO_LONGS(nbits) * sizeof(unsigned long), flags);
+}
+EXPORT_SYMBOL(bitmap_zalloc);
+
+void bitmap_free(const unsigned long *bitmap)
+{
+	kfree(bitmap);
+}
+EXPORT_SYMBOL(bitmap_free);
-- 
2.45.1

