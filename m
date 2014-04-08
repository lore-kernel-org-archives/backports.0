Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:47207 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbaDHDc5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 23:32:57 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so385129pdi.19
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 20:32:56 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ben Hutchings <bhutchings@solarflare.com>
Subject: [PATCH 06/12] backports: add GRO_* enums, and its new gro_result_t typedef
Date: Mon,  7 Apr 2014 20:32:17 -0700
Message-Id: <1396927943-25589-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20140408_053258_631540_229C7CA4)
In-Reply-To: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backports commit d1c76af9e added by Herbert which added the first
enums and then commit 5b252f0c2 added by Ben which gave the enums a
label and then pegged a typedef onto these. This backports these commits
in a forward compatible way upkeeping the introduction and then the
typedef. In order to make this work we use make backported code use
enums with the BACKPORT_prefix but upkeep the same values, this lets
us declare the typedef and peg it to a similar set.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ben Hutchings <bhutchings@solarflare.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/netdevice.h | 40 +++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index f99ea02..f77e3eb 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -20,6 +20,46 @@ struct inet6_dev;
  */
 #include <linux/hardirq.h>
 
+/* d1c76af9e */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
+enum { /* backport: provide the enum name already */
+	GRO_MERGED,
+	GRO_MERGED_FREE,
+	GRO_HELD,
+	GRO_NORMAL,
+	GRO_DROP,
+};
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
+
+/*
+ * We can count on the enum definitions being present so
+ * but since we cannot dedeclare the enum but we have to
+ * peg the typedef to a similar enum we can just use the
+ * same values and then use the #defines below to modify
+ * code for older kernels to use the new enum we define
+ * here. This works even for switch statements and gcc -Wall.
+ * This backports 5b252f0c2
+ */
+enum gro_result {
+	BACKPORT_GRO_MERGED 		= GRO_MERGED,
+	BACKPORT_GRO_MERGED_FREE 	= GRO_MERGED_FREE,
+	BACKPORT_GRO_HELD 		= GRO_HELD,
+	BACKPORT_GRO_NORMAL		= GRO_NORMAL,
+	BACKPORT_GRO_DROP		= GRO_DROP,
+};
+
+#define GRO_MERGED	BACKPORT_GRO_MERGED
+#define GRO_MERGED_FREE	BACKPORT_GRO_MERGED_FREE
+#define GRO_HELD	BACKPORT_GRO_HELD
+#define GRO_NORMAL	BACKPORT_GRO_NORMAL
+#define GRO_DROP	BACKPORT_GRO_DROP
+
+typedef enum gro_result gro_result_t;
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
 #define dev_change_net_namespace(a, b, c) (-EOPNOTSUPP)
 
-- 
1.8.5.3

