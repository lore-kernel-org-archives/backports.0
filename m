Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F3EC06511
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAE421479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGAVuC (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:02 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:40550 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbfGAVuC (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:02 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 10C6A50465;
        Mon,  1 Jul 2019 23:50:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id PfvrNpBOv_17; Mon,  1 Jul 2019 23:49:53 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/18] header: Add backport-include/net/ipv6_stubs.h
Date:   Mon,  1 Jul 2019 23:49:02 +0200
Message-Id: <20190701214914.8066-8-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

ipv6_stubs.h was added in kernel commit 3616d08bcbb5 ("ipv6: Move ipv6
stubs to a separate header file").
Most of its content is from include/net/addrconf.h, so include that file
indirectly on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/ipv6_stubs.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/net/ipv6_stubs.h

diff --git a/backport/backport-include/net/ipv6_stubs.h b/backport/backport-include/net/ipv6_stubs.h
new file mode 100644
index 00000000..7d9a5226
--- /dev/null
+++ b/backport/backport-include/net/ipv6_stubs.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BACKPORT_IPV6_STUBS_H
+#define _BACKPORT_IPV6_STUBS_H
+
+#if LINUX_VERSION_IS_LESS(5,2,0)
+
+#include <net/addrconf.h>
+
+#else
+#include_next <net/ipv6_stubs.h>
+#endif
+
+#endif	/* _BACKPORT_IPV6_STUBS_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
