Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F297C4167D
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0257F61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhJSVqI (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhJSVqD (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:03 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1FCC061768
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:50 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLX2FhDzQjgJ;
        Tue, 19 Oct 2021 23:43:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kUsKRzJuQqh7eYM5FFUyLsA1/D/8C+Nv+ZDDdXQWmXM=;
        b=Rb5ZnbzHwajiZIK15JngT+nZWdyb+VOs8rf2WZ+ybFzsxKoO73+vdzlR/bTJGG6K6Vb9Wr
        Apa11v/FV1clnCCjcRq/2mfs0LF6cm73ev5qwr6zcBjjH54wC2nHFSWivCEvdYtMGCvmrL
        CMveylNPB4OyfoZfWAvPbyJvdjHfNnnibltSziI3LXr544nPjx7kFGlkqTCSZNxyjBG2/q
        IzWsl9W8u82m60hjSllpOQaVL/80IbFyBggB5BDAIV07slS9tui6DmOfyXFGisGLI30hU0
        joJQYBAA/ndxPq36VP69EYAGnVEhm79ltsstEaGa9nqZiYBEsk33YYHXWMdRKQ==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 27/47] headers: Add FW_ACTION_NOUEVENT and FW_ACTION_UEVENT
Date:   Tue, 19 Oct 2021 23:43:00 +0200
Message-Id: <20211019214320.2035704-28-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 94279731
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

FW_ACTION_NOHOTPLUG and FW_ACTION_HOTPLUG were renamed to
FW_ACTION_NOUEVENT and FW_ACTION_UEVENT in kernel 5.14.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/firmware.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/firmware.h b/backport/backport-include/linux/firmware.h
index 7d41637c..c12ce98c 100644
--- a/backport/backport-include/linux/firmware.h
+++ b/backport/backport-include/linux/firmware.h
@@ -14,4 +14,12 @@ static inline int firmware_request_cache(struct device *device, const char *name
 }
 #endif
 
+#ifndef FW_ACTION_NOUEVENT
+#define FW_ACTION_NOUEVENT FW_ACTION_NOHOTPLUG
+#endif
+
+#ifndef FW_ACTION_UEVENT
+#define FW_ACTION_UEVENT FW_ACTION_HOTPLUG
+#endif
+
 #endif /* __BACKPORT_LINUX_FIRMWARE_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
