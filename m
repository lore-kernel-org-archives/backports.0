Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EC1C433FE
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA8C61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhJSVqH (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhJSVqB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:01 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB27C061746
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:47 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HYnLV05bFzQk0m;
        Tue, 19 Oct 2021 23:43:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLPufhc4z8GFOATm4A4CWzJ7OXvRp+REclfe6ZuNXUk=;
        b=Vhr1KhjAdwc7SvSLLGjhq9hDnDSLNAgSV9FGQ/OlOX08HJbt67tAXF7d+UMJmR1vGmIxPc
        Hjh1GpW5XrcoJqTo5Xq7+nhFX2HgwJqzV5iEK30hcCY3Uq3aRl5MLqd0NwgQFH+AhOobQj
        TLtdW89mkxHS4qXDC92I+Ls4p+FchnZi3DLTZBHdswCVRamYhB15KaM6H4BIkH/zn35fn+
        Fq+IsIR38QBA+cr1QnUdXZZlThNQSizRSrSj1KrNunZ1V/gQRtWO24MBmyEZxtELzRQPO7
        qvPY7auYygRJPM25rLq6zjCe3Wqesdl4f0gtEBLXvEY+C//1xqC+NjTVn0VE5w==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 21/47] headers: Adapt signature of of_get_mac_address()
Date:   Tue, 19 Oct 2021 23:42:54 +0200
Message-Id: <20211019214320.2035704-22-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E43B1318
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The function signature of of_get_mac_address() changed in kernel 5.13.
This code converts calls using the new signature to the old API.
The return value changed in kernel 5.2, which is still taken care of.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of_net.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/backport/backport-include/linux/of_net.h b/backport/backport-include/linux/of_net.h
index 866aec57..9b9276f1 100644
--- a/backport/backport-include/linux/of_net.h
+++ b/backport/backport-include/linux/of_net.h
@@ -2,19 +2,23 @@
 #define _BP_OF_NET_H
 #include_next <linux/of_net.h>
 #include <linux/version.h>
+#include <linux/etherdevice.h>
 
 /* The behavior of of_get_mac_address() changed in kernel 5.2, it now
  * returns an error code and not NULL in case of an error.
  */
-#if LINUX_VERSION_IS_LESS(5,2,0)
-static inline const void *backport_of_get_mac_address(struct device_node *np)
+#if LINUX_VERSION_IS_LESS(5,13,0)
+static inline int backport_of_get_mac_address(struct device_node *np, u8 *mac_out)
 {
 	const void *mac = of_get_mac_address(np);
 
 	if (!mac)
-		return ERR_PTR(-ENODEV);
-
-	return mac;
+		return -ENODEV;
+	if (IS_ERR(mac))
+		return PTR_ERR(mac);
+	ether_addr_copy(mac_out, mac);
+	
+	return 0;
 }
 #define of_get_mac_address LINUX_BACKPORT(of_get_mac_address)
 #endif /* < 5.2 */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
