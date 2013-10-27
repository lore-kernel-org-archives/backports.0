Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50167 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535Ab3J0TJ7 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Oct 2013 15:09:59 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] backports: add strtobool()
Date: Sun, 27 Oct 2013 20:09:38 +0100
Message-Id: <1382900980-26610-3-git-send-email-hauke@hauke-m.de> (sfid-20131027_201005_117922_ABD65EBE)
In-Reply-To: <1382900980-26610-1-git-send-email-hauke@hauke-m.de>
References: <1382900980-26610-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added in the following upstream commit:
commit d0f1fed29e6e73d9d17f4c91a5896a4ce3938d45
Author: Jonathan Cameron <jic23@cam.ac.uk>
Date:   Tue Apr 19 12:43:45 2011 +0100

    Add a strtobool function matching semantics of existing in kernel equivalents

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/string.h |    5 +++++
 backport/compat/compat-3.0.c             |   29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
index 819d141..f9f1750 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -8,4 +8,9 @@
 extern size_t memweight(const void *ptr, size_t bytes);
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
+#define strtobool LINUX_BACKPORT(strtobool)
+extern int strtobool(const char *s, bool *res);
+#endif
+
 #endif /* __BACKPORT_LINUX_STRING_H */
diff --git a/backport/compat/compat-3.0.c b/backport/compat/compat-3.0.c
index 9841019..1bed6a6 100644
--- a/backport/compat/compat-3.0.c
+++ b/backport/compat/compat-3.0.c
@@ -60,3 +60,32 @@ kstrto_from_user(kstrtou16_from_user,	kstrtou16,	u16);
 kstrto_from_user(kstrtos16_from_user,	kstrtos16,	s16);
 kstrto_from_user(kstrtou8_from_user,	kstrtou8,	u8);
 kstrto_from_user(kstrtos8_from_user,	kstrtos8,	s8);
+
+/**
+ * strtobool - convert common user inputs into boolean values
+ * @s: input string
+ * @res: result
+ *
+ * This routine returns 0 iff the first character is one of 'Yy1Nn0'.
+ * Otherwise it will return -EINVAL.  Value pointed to by res is
+ * updated upon finding a match.
+ */
+int strtobool(const char *s, bool *res)
+{
+	switch (s[0]) {
+	case 'y':
+	case 'Y':
+	case '1':
+		*res = true;
+		break;
+	case 'n':
+	case 'N':
+	case '0':
+		*res = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(strtobool);
-- 
1.7.10.4

