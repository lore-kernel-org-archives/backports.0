Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C447C0650E
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6A521479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfGAVuI (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:08 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:46036 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfGAVuI (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:08 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 84C12A0190;
        Mon,  1 Jul 2019 23:50:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id byAd4MXEvp_f; Mon,  1 Jul 2019 23:49:57 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/18] header: Make napi_complete_done() return bool
Date:   Mon,  1 Jul 2019 23:49:06 +0200
Message-Id: <20190701214914.8066-12-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

In the current kernel napi_complete_done() returns a bool and this is
now used by the mt76 driver. Try to backport this functionality by
doing the check which makes the function return false already in
backports.

This was added in upstream kernel commit 364b6055738b ("net: busy-poll:
return busypolling status to drivers")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index c3e91a0c..76b57e4d 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -289,13 +289,21 @@ static inline void u64_stats_init(struct u64_stats_sync *syncp)
 })
 #endif /* netdev_alloc_pcpu_stats */
 
-#if LINUX_VERSION_IS_LESS(3,19,0)
-#define napi_complete_done LINUX_BACKPORT(napi_complete_done)
-static inline void napi_complete_done(struct napi_struct *n, int work_done)
+#if LINUX_VERSION_IS_LESS(4,10,0)
+static inline bool backport_napi_complete_done(struct napi_struct *n, int work_done)
 {
+	if (unlikely(test_bit(NAPI_STATE_NPSVC, &n->state)))
+		return false;
+
+#if LINUX_VERSION_IS_LESS(3,19,0)
 	napi_complete(n);
-}
+#else
+	napi_complete_done(n, work_done);
 #endif /* < 3.19 */
+	return true;
+}
+#define napi_complete_done LINUX_BACKPORT(napi_complete_done)
+#endif /* < 4.10 */
 
 #if LINUX_VERSION_IS_LESS(4,5,0)
 #define netif_tx_napi_add LINUX_BACKPORT(netif_tx_napi_add)
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
