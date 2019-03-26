Return-Path: <SRS0=w1W3=R5=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01915C10F05
	for <backports@archiver.kernel.org>; Tue, 26 Mar 2019 15:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABF82070D
	for <backports@archiver.kernel.org>; Tue, 26 Mar 2019 15:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfCZPLz (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:11:55 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:18476 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731475AbfCZPLz (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 26 Mar 2019 11:11:55 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 672F7A1569;
        Tue, 26 Mar 2019 16:11:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id P8azzxYQp1Ty; Tue, 26 Mar 2019 16:11:47 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] backports: Add rhashtable_lookup_get_insert_fast()
Date:   Tue, 26 Mar 2019 16:11:35 +0100
Message-Id: <20190326151138.4141-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

rhashtable_lookup_get_insert_fast() was added in kernel 4.12 in Linux
upstream commit f9fe1c12d12 ("rhashtable: Add
rhashtable_lookup_get_insert_fast") It is now used by mac80211.

For kernel < 4.9 we already backport the complete rhashtable
implementation, so this is only needed for kernels more recent than 4.9.

This is copied from upstreamn Linux kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/rhashtable.h | 31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 backport/backport-include/linux/rhashtable.h

diff --git a/backport/backport-include/linux/rhashtable.h b/backport/backport-include/linux/rhashtable.h
new file mode 100644
index 00000000..8e493bc5
--- /dev/null
+++ b/backport/backport-include/linux/rhashtable.h
@@ -0,0 +1,31 @@
+#ifndef __BACKPORT_RHASHTABLE_H
+#define __BACKPORT_RHASHTABLE_H
+#include_next <linux/rhashtable.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(4,12,0)
+/**
+ * rhashtable_lookup_get_insert_fast - lookup and insert object into hash table
+ * @ht:		hash table
+ * @obj:	pointer to hash head inside object
+ * @params:	hash table parameters
+ *
+ * Just like rhashtable_lookup_insert_fast(), but this function returns the
+ * object if it exists, NULL if it did not and the insertion was successful,
+ * and an ERR_PTR otherwise.
+ */
+#define rhashtable_lookup_get_insert_fast LINUX_BACKPORT(rhashtable_lookup_get_insert_fast)
+static inline void *rhashtable_lookup_get_insert_fast(
+	struct rhashtable *ht, struct rhash_head *obj,
+	const struct rhashtable_params params)
+{
+	const char *key = rht_obj(ht, obj);
+
+	BUG_ON(ht->p.obj_hashfn);
+
+	return __rhashtable_insert_fast(ht, key + ht->p.key_offset, obj, params,
+					false);
+}
+#endif
+
+#endif /* __BACKPORT_RHASHTABLE_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
