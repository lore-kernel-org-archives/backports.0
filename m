Return-Path: <SRS0=+jjK=6E=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7A6C55184
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B172078C
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgDTWQd (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgDTWQd (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 20 Apr 2020 18:16:33 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C38BC061A0F
        for <backports@vger.kernel.org>; Mon, 20 Apr 2020 15:16:33 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 495gyl0Y4xzKmbl;
        Tue, 21 Apr 2020 00:16:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id gG9YB_fwYxlO; Tue, 21 Apr 2020 00:16:28 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/9] backports: Add include/uapi/linux/virtio_ids.h
Date:   Tue, 21 Apr 2020 00:16:11 +0200
Message-Id: <20200420221615.14734-6-hauke@hauke-m.de>
In-Reply-To: <20200420221615.14734-1-hauke@hauke-m.de>
References: <20200420221615.14734-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4567D1731
X-Rspamd-Score: -5.67 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add the missing constant VIRTIO_ID_MAC80211_HWSIM.

This is a stable user space API, so it should be save to copy this file.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index ba10a0bf..6aeb9cc6 100644
--- a/copy-list
+++ b/copy-list
@@ -54,6 +54,7 @@ include/linux/platform_data/brcmfmac.h
 include/linux/platform_data/net-cw1200.h
 include/uapi/linux/nl80211.h
 include/net/rsi_91x.h
+include/uapi/linux/virtio_ids.h
 
 include/net/cfg80211.h
 include/net/cfg80211-wext.h
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
