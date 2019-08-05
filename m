Return-Path: <SRS0=hnMY=WB=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19710C0650F
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D302086D
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfHEMIG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:08:06 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:18502 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEMIG (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Aug 2019 08:08:06 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 58551A018D;
        Mon,  5 Aug 2019 14:08:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id zqkdr_-kpU67; Mon,  5 Aug 2019 14:07:57 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/12] backport: Add genl_callback_extack() function
Date:   Mon,  5 Aug 2019 14:06:59 +0200
Message-Id: <20190805120704.13128-8-hauke@hauke-m.de>
In-Reply-To: <20190805120704.13128-1-hauke@hauke-m.de>
References: <20190805120704.13128-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The struct netlink_callback got a new extack attribute in commit
4a19edb60d02 ("netlink: Pass extack to dump handlers") in kernel 4.20.
Use a function instead of directly accessing it to return NULL on older
kernel versions, the code should handle NULL.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/genetlink.h | 10 ++++++++++
 patches/0078-genl-extack.cocci            |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 772f10f0..747b6dac 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -34,6 +34,16 @@ static inline struct netlink_ext_ack *genl_info_extack(struct genl_info *info)
 #endif
 }
 
+/* this is for patches we apply */
+static inline struct netlink_ext_ack *genl_callback_extack(struct netlink_callback *cb)
+{
+#if LINUX_VERSION_IS_GEQ(4,20,0)
+	return cb->extack;
+#else
+	return NULL;
+#endif
+}
+
 /* this gets put in place of info->userhdr, since we use that above */
 static inline void *genl_info_userhdr(struct genl_info *info)
 {
diff --git a/patches/0078-genl-extack.cocci b/patches/0078-genl-extack.cocci
index 5560e09d..860d68b4 100644
--- a/patches/0078-genl-extack.cocci
+++ b/patches/0078-genl-extack.cocci
@@ -9,3 +9,9 @@ struct genl_info *info;
 @@
 -info->userhdr
 +genl_info_userhdr(info)
+
+@@
+struct netlink_callback *cb;
+@@
+-cb->extack
++genl_callback_extack(cb)
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
