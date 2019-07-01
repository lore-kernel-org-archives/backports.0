Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849B7C5B578
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6610D21479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGAVuD (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:03 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:45702 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfGAVuC (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:02 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id C462AA0017;
        Mon,  1 Jul 2019 23:50:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id YETVlL3oBnl8; Mon,  1 Jul 2019 23:49:54 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/18] header: Add sdio_retune*() functions
Date:   Mon,  1 Jul 2019 23:49:03 +0200
Message-Id: <20190701214914.8066-9-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The brcmfmac driver now uses new sdio_retune*() functions. They are
added with kernel 5.2-rc6 and are backported to kernel 4.19.56 and
5.1.15

sdio_retune_hold_now() and sdio_retune_release() should work like in the
upstream kernel, the implementation of mmc_retune_release() and
mmc_retune_hold() was copied to backports into these functions. On
kernel < 4.3 backporting this is not so easy, so just use an empty
implementation there.

It is not possible to backport sdio_retune_crc_disable() and
sdio_retune_crc_enable() because they need an additional member in a
structure, just add an empty implementation.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../backport-include/linux/mmc/sdio_func.h    | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/backport/backport-include/linux/mmc/sdio_func.h b/backport/backport-include/linux/mmc/sdio_func.h
index 2d3e92b6..0a67f992 100644
--- a/backport/backport-include/linux/mmc/sdio_func.h
+++ b/backport/backport-include/linux/mmc/sdio_func.h
@@ -7,4 +7,80 @@
 #define dev_to_sdio_func(d)	container_of(d, struct sdio_func, dev)
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,2,0) && \
+    !LINUX_VERSION_IN_RANGE(5,1,15, 5,2,0) && \
+    !LINUX_VERSION_IN_RANGE(4,19,56, 4,20,0)
+    
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+
+/**
+ *	sdio_retune_hold_now - start deferring retuning requests till release
+ *	@func: SDIO function attached to host
+ *
+ *	This function can be called if it's currently a bad time to do
+ *	a retune of the SDIO card.  Retune requests made during this time
+ *	will be held and we'll actually do the retune sometime after the
+ *	release.
+ *
+ *	This function could be useful if an SDIO card is in a power state
+ *	where it can respond to a small subset of commands that doesn't
+ *	include the retuning command.  Care should be taken when using
+ *	this function since (presumably) the retuning request we might be
+ *	deferring was made for a good reason.
+ *
+ *	This function should be called while the host is claimed.
+ */
+#define sdio_retune_hold_now LINUX_BACKPORT(sdio_retune_hold_now)
+#if LINUX_VERSION_IS_LESS(4,3,0)
+static inline void sdio_retune_hold_now(struct sdio_func *func)
+{
+}
+#else
+static inline void sdio_retune_hold_now(struct sdio_func *func)
+{
+	struct mmc_host *host = func->card->host;
+
+	host->retune_now = 0;
+	host->hold_retune += 1;
+}
+#endif /* < 4.3 */
+
+/**
+ *	sdio_retune_release - signal that it's OK to retune now
+ *	@func: SDIO function attached to host
+ *
+ *	This is the complement to sdio_retune_hold_now().  Calling this
+ *	function won't make a retune happen right away but will allow
+ *	them to be scheduled normally.
+ *
+ *	This function should be called while the host is claimed.
+ */
+#define sdio_retune_release LINUX_BACKPORT(sdio_retune_release)
+#if LINUX_VERSION_IS_LESS(4,3,0)
+static inline void sdio_retune_release(struct sdio_func *func)
+{
+}
+#else
+static inline void sdio_retune_release(struct sdio_func *func)
+{
+	struct mmc_host *host = func->card->host;
+
+	if (host->hold_retune)
+		host->hold_retune -= 1;
+	else
+		WARN_ON(1);
+}
+#endif
+
+#define sdio_retune_crc_disable LINUX_BACKPORT(sdio_retune_crc_disable)
+static inline void sdio_retune_crc_disable(struct sdio_func *func)
+{
+}
+#define sdio_retune_crc_enable LINUX_BACKPORT(sdio_retune_crc_enable)
+static inline void sdio_retune_crc_enable(struct sdio_func *func)
+{
+}
+#endif /* < 5.2 */
+
 #endif /* __BACKPORT_MMC_SDIO_FUNC_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
