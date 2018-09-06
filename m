Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:56608 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbeIFQFG (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 6 Sep 2018 12:05:06 -0400
From: Felix Fietkau <nbd@nbd.name>
To: backports@vger.kernel.org
Cc: john@phrozen.org
Subject: [PATCH] backports: backport sg_init_marker()
Date: Thu,  6 Sep 2018 13:30:02 +0200
Message-Id: <20180906113002.59425-1-nbd@nbd.name> (sfid-20180906_133006_643082_03903869)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

It is used by new mt76 changes

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/scatterlist.h | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/backport/backport-include/linux/scatterlist.h b/backport/backport-include/linux/scatterlist.h
index bfc74494..06934b6b 100644
--- a/backport/backport-include/linux/scatterlist.h
+++ b/backport/backport-include/linux/scatterlist.h
@@ -102,4 +102,27 @@ size_t sg_pcopy_from_buffer(struct scatterlist *sgl, unsigned int nents,
 
 #endif /* LINUX_VERSION_IS_LESS(3, 11, 0) */
 
+#if LINUX_VERSION_IS_LESS(4, 17, 0)
+
+#define sg_init_marker LINUX_BACKPORT(sg_init_marker)
+/**
+ * sg_init_marker - Initialize markers in sg table
+ * @sgl:	   The SG table
+ * @nents:	   Number of entries in table
+ *
+ **/
+static inline void sg_init_marker(struct scatterlist *sgl,
+				  unsigned int nents)
+{
+#ifdef CONFIG_DEBUG_SG
+	unsigned int i;
+
+	for (i = 0; i < nents; i++)
+		sgl[i].sg_magic = SG_MAGIC;
+#endif
+	sg_mark_end(&sgl[nents - 1]);
+}
+
+#endif /* LINUX_VERSION_IS_LESS(4, 17, 0) */
+
 #endif /* __BACKPORT_SCATTERLIST_H */
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
