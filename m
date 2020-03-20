Return-Path: <SRS0=vds9=5F=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84872C43333
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510F420714
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgCTXkO (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:40:14 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:45568 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgCTXkN (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 20 Mar 2020 19:40:13 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 48kgHc4RhKzKmNY;
        Sat, 21 Mar 2020 00:40:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id H9vkHJPTzdq8; Sat, 21 Mar 2020 00:40:10 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/8] backports: stddef.h: Add sizeof_field()
Date:   Sat, 21 Mar 2020 00:39:45 +0100
Message-Id: <20200320233950.32257-4-hauke@hauke-m.de>
In-Reply-To: <20200320233950.32257-1-hauke@hauke-m.de>
References: <20200320233950.32257-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This backports sizeof_field() from upstream Linux commit 4229a470175b
("stddef.h: Introduce sizeof_field()"). This is now used by multiple
drivers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/stddef.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/stddef.h b/backport/backport-include/linux/stddef.h
index 2c836b00..a6cdc67d 100644
--- a/backport/backport-include/linux/stddef.h
+++ b/backport/backport-include/linux/stddef.h
@@ -2,6 +2,16 @@
 #define __BACKPORT_LINUX_STDDEF_H
 #include_next <linux/stddef.h>
 
+#ifndef sizeof_field
+/**
+ * sizeof_field(TYPE, MEMBER)
+ *
+ * @TYPE: The structure containing the field of interest
+ * @MEMBER: The field to return the size of
+ */
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#endif
+
 #ifndef offsetofend
 /**
  * offsetofend(TYPE, MEMBER)
@@ -10,7 +20,7 @@
  * @MEMBER: The member within the structure to get the end offset of
  */
 #define offsetofend(TYPE, MEMBER) \
-	(offsetof(TYPE, MEMBER)	+ sizeof(((TYPE *)0)->MEMBER))
+	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
 #endif
 
 #endif /* __BACKPORT_LINUX_STDDEF_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
