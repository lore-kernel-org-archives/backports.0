Return-Path: <SRS0=CrYV=YC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305FCC47404
	for <backports@archiver.kernel.org>; Wed,  9 Oct 2019 21:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0943121929
	for <backports@archiver.kernel.org>; Wed,  9 Oct 2019 21:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfJIVVL (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 9 Oct 2019 17:21:11 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:11899 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfJIVVL (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 9 Oct 2019 17:21:11 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id 928A8A1C9B;
        Wed,  9 Oct 2019 23:12:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id OOFKpvIzb0KG; Wed,  9 Oct 2019 23:12:36 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] backports: xfrm: Add skb_ext_reset()
Date:   Wed,  9 Oct 2019 23:12:07 +0200
Message-Id: <20191009211207.29212-2-hauke@hauke-m.de>
In-Reply-To: <20191009211207.29212-1-hauke@hauke-m.de>
References: <20191009211207.29212-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

skb_ext_reset() was added in upstream commit 174e23810cd3 ("sk_buff:
drop all skb extensions on free and skb scrubbing") and is now used by
mac80211_hwsim.

skb_ext_reset() replaced the old call to secpath_reset() in
mac80211_hwsim and other places and it also does similar things than
this function. Juts call the old secpath_reset() on older kernel
versions.

This was added to net/xfrm.h and not linux/skbuff.h because
secpath_reset() is only available in net/xfrm.h in the upstream kernel
and this is not included in linux/skbuff.h.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/xfrm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 backport/backport-include/net/xfrm.h

diff --git a/backport/backport-include/net/xfrm.h b/backport/backport-include/net/xfrm.h
new file mode 100644
index 00000000..7e55984b
--- /dev/null
+++ b/backport/backport-include/net/xfrm.h
@@ -0,0 +1,14 @@
+#ifndef __BACKPORT_NET_XFRM_H
+#define __BACKPORT_NET_XFRM_H
+#include_next <net/xfrm.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(5,4,0)
+#define skb_ext_reset LINUX_BACKPORT(skb_ext_reset)
+static inline void skb_ext_reset(struct sk_buff *skb)
+{
+	secpath_reset(skb);
+}
+#endif
+
+#endif /* __BACKPORT_NET_XFRM_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
