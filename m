Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7F8C5B578
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB8521479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfGAVuH (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:07 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:40582 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbfGAVuH (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:07 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 6E78C501D8;
        Mon,  1 Jul 2019 23:50:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 7IHqwhcqcspm; Mon,  1 Jul 2019 23:50:00 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 17/18] header: fix of_get_mac_address()
Date:   Mon,  1 Jul 2019 23:49:13 +0200
Message-Id: <20190701214914.8066-19-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The behavior of of_get_mac_address() changed in kernel 5.2, it now
returns an error code and not NULL in case of an error.

This was changed in upstream kernel commit d01f449c008a
("of_net: add NVMEM support to of_get_mac_address")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of_net.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/backport/backport-include/linux/of_net.h b/backport/backport-include/linux/of_net.h
index 7f4b688f..18becf5c 100644
--- a/backport/backport-include/linux/of_net.h
+++ b/backport/backport-include/linux/of_net.h
@@ -12,4 +12,20 @@ static inline const void *of_get_mac_address(struct device_node *np)
 #endif
 #endif
 
+/* The behavior of of_get_mac_address() changed in kernel 5.2, it now
+ * returns an error code and not NULL in case of an error.
+ */
+#if LINUX_VERSION_IS_LESS(5,2,0)
+static inline const void *backport_of_get_mac_address(struct device_node *np)
+{
+	const void *mac = of_get_mac_address(np);
+
+	if (!mac)
+		return ERR_PTR(-ENODEV);
+
+	return mac;
+}
+#define of_get_mac_address LINUX_BACKPORT(of_get_mac_address)
+#endif /* < 5.2 */
+
 #endif /* _BP_OF_NET_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
