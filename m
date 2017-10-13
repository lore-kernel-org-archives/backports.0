Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49164 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757630AbdJMJmc (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:42:32 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 05/11] backports: add bin2hex()
Date: Fri, 13 Oct 2017 11:42:20 +0200
Message-Id: <20171013094226.10021-5-johannes@sipsolutions.net> (sfid-20171013_114235_050911_2AEE96FF)
In-Reply-To: <20171013094226.10021-1-johannes@sipsolutions.net>
References: <20171013094226.10021-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This is needed in the key backports in the next patch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/kernel.h |  5 +++++
 backport/compat/backport-3.18.c          | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 0e9a69f9bcd2..3ddeb13c29a2 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -213,6 +213,11 @@ static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
 }
 #endif /* LINUX_VERSION_IS_LESS(3,14,0) */
 
+#if LINUX_VERSION_IS_LESS(3,18,0)
+#define bin2hex LINUX_BACKPORT(bin2hex)
+extern char *bin2hex(char *dst, const void *src, size_t count);
+#endif
+
 #endif /* __BACKPORT_KERNEL_H */
 
 /*
diff --git a/backport/compat/backport-3.18.c b/backport/compat/backport-3.18.c
index 73db233cb22b..d2eceef7dc77 100644
--- a/backport/compat/backport-3.18.c
+++ b/backport/compat/backport-3.18.c
@@ -320,3 +320,13 @@ void memzero_explicit(void *s, size_t count)
 }
 EXPORT_SYMBOL_GPL(memzero_explicit);
 #endif
+
+char *bin2hex(char *dst, const void *src, size_t count)
+{
+	const unsigned char *_src = src;
+
+	while (count--)
+		dst = hex_byte_pack(dst, *_src++);
+	return dst;
+}
+EXPORT_SYMBOL(bin2hex);
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
