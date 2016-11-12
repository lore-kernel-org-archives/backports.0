Return-path: <backports-owner@vger.kernel.org>
Received: from [192.19.211.62] ([192.19.211.62]:48745 "EHLO
        relay.smtp.broadcom.com" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S966752AbcKLUZg (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 12 Nov 2016 15:25:36 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 2/3] backports: add backport for genl_family_attrbuf() function
Date: Sat, 12 Nov 2016 20:18:42 +0000
Message-Id: <1478981923-12298-2-git-send-email-arend.vanspriel@broadcom.com> (sfid-20161112_212538_608871_06644889)
In-Reply-To: <1478981923-12298-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1478981923-12298-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The function genl_family_attrbuf() was added to the kernel. This
backport caries the warning for parallel ops, but it does not
assert the genl_mutex as it does not have access to it.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/net/genetlink.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index cf3e67c..f81b825 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -158,4 +158,24 @@ backport_genlmsg_multicast_allns(struct genl_family *family,
 #define GENL_UNS_ADMIN_PERM	GENL_ADMIN_PERM
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
+/**
+ * genl_family_attrbuf - return family's attrbuf
+ * @family: the family
+ *
+ * Return the family's attrbuf, while validating that it's
+ * actually valid to access it.
+ *
+ * You cannot use this function with a family that has parallel_ops
+ * and you can only use it within (pre/post) doit/dumpit callbacks.
+ */
+#define genl_family_attrbuf LINUX_BACKPORT(genl_family_attrbuf)
+static inline struct nlattr **genl_family_attrbuf(struct genl_family *family)
+{
+	WARN_ON(family->parallel_ops);
+
+	return family->attrbuf;
+}
+#endif
+
 #endif /* __BACKPORT_NET_GENETLINK_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
