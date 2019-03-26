Return-Path: <SRS0=w1W3=R5=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E89C10F06
	for <backports@archiver.kernel.org>; Tue, 26 Mar 2019 15:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BB72146E
	for <backports@archiver.kernel.org>; Tue, 26 Mar 2019 15:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfCZPL4 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:11:56 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:28746 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfCZPLz (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 26 Mar 2019 11:11:55 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 213B64CA9E;
        Tue, 26 Mar 2019 16:11:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id qkzi4uAUSGwM; Tue, 26 Mar 2019 16:11:47 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] backports: Add missing include for brcmfmac
Date:   Tue, 26 Mar 2019 16:11:37 +0100
Message-Id: <20190326151138.4141-3-hauke@hauke-m.de>
In-Reply-To: <20190326151138.4141-1-hauke@hauke-m.de>
References: <20190326151138.4141-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

When building against kernel 4.8, 3.14 and older, brcmfmac failed
because struct sk_buff was not declared in brcmfmac/bus.h. This is used
in the brcmf_bus_ops.txdata() callback.

I do not know why this was working before.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0013-fix-makefile-includes/brcmfmac.patch | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 patches/0013-fix-makefile-includes/brcmfmac.patch

diff --git a/patches/0013-fix-makefile-includes/brcmfmac.patch b/patches/0013-fix-makefile-includes/brcmfmac.patch
new file mode 100644
index 00000000..9147c80f
--- /dev/null
+++ b/patches/0013-fix-makefile-includes/brcmfmac.patch
@@ -0,0 +1,13 @@
+brcmf_bus_ops.txdata() uses a paramater of type struct sk_buff which
+was not declared here when compiling against kernele 4.8 and older.
+
+--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
++++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+@@ -17,6 +17,7 @@
+ #ifndef BRCMFMAC_BUS_H
+ #define BRCMFMAC_BUS_H
+ 
++#include <linux/skbuff.h>
+ #include "debug.h"
+ 
+ /* IDs of the 6 default common rings of msgbuf protocol */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
