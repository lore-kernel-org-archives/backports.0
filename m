Return-Path: <SRS0=sLXW=R6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD7EC43381
	for <backports@archiver.kernel.org>; Wed, 27 Mar 2019 03:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D336B2082F
	for <backports@archiver.kernel.org>; Wed, 27 Mar 2019 03:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZTBBxgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbfC0DAv (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:00:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37005 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfC0DAv (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 26 Mar 2019 23:00:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so9216063pgq.4
        for <backports@vger.kernel.org>; Tue, 26 Mar 2019 20:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=7N1ouRxa4TSFGu4udslbaDq+i5rQRCGlHsRn/0j1M6I=;
        b=lZTBBxgqp8Z7wfUg2Bi9Po3UaIc6CdQeNi3kc7y53Yrzu4ZUv9L0DLGybaEQCTF/xb
         1lJVIplqyqgVbCN7XpfNZUKNKHFbfRt/pIWHAEgD0jRmuYQZxhrL/ooOK44tXE040FNE
         YQJRrH3dBPzM9krXjvkgU4AcqAeUz2RWq8JtWLZicM/LU1M+zBL+SuiZZfgRkpHk1JrP
         E8Ff8TqRdD6YywGG2URtm7qVhzRpNBfSvXxg0wd/MNWBYaG873G5UzJWX2nMKQg/o6E5
         pY6BttEF+CaqM3ZN/EpuSo7Va5AeB9/Cy3SkfDxp7HopDbRrNhI9KTi3avebOeAlvQ4j
         YWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=7N1ouRxa4TSFGu4udslbaDq+i5rQRCGlHsRn/0j1M6I=;
        b=m0O2zTrcjSTlgmEAktGK5DQ6zr7W+nld8tUftbg4dDhbmk+y8FIxi8axB6Ia7Qmct2
         rRQJp5lm/gHcbzeCQtPxvuelSujfmD6gkd/5rcUa9tanh1LUIMgebYJGVY84eGkQ0hqx
         uZV26q7CJtSd1A5lwWqqlW5UtZvUGGOfysB8XSdCJ+X3uMx0GzXiOttPRAJj0MmN/Ql9
         OCPGsdVbgHWwLUxYD1xbOef7LacSg+fwuD5U3SKglsURWTBZI7jCEhVkW//X9oZwju0g
         +tLKMf+lN+QDVJQr5+oXKQr/JCozn3dcxNdpCRtA/mg8a8Z6vxQDiPEVNSJEu1xgMyF6
         OoYQ==
X-Gm-Message-State: APjAAAVngNSjgyEpaVpOj746kzS4rcpHATAak4wU3v7KudSM1dyKXv5o
        YO56RYW3nDs+50rUbbkKCSk=
X-Google-Smtp-Source: APXvYqz6+k7SsYrDLUTwwicSNfLvGYJtn2MX6VZpuFa6KQ1+EZKuBlGSkPO/S8+hwNO14suHcCw7LA==
X-Received: by 2002:aa7:9090:: with SMTP id i16mr31965796pfa.85.1553655650614;
        Tue, 26 Mar 2019 20:00:50 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id w67sm35854665pfw.173.2019.03.26.20.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 20:00:49 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH v3 1/3] backports: remove mt76.patch
Date:   Wed, 27 Mar 2019 11:00:42 +0800
Message-Id: <20190327030044.28263-2-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327030044.28263-1-acelan.kao@canonical.com>
References: <20190327030044.28263-1-acelan.kao@canonical.com>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The patch patches/0013-fix-makefile-includes/mt76.patch was added in
upstream Linux commit 85b7e2acd31b ("mt76: Add missing include of
linux/module.h") which was added in v5.1-rc1

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 patches/0013-fix-makefile-includes/mt76.patch | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 patches/0013-fix-makefile-includes/mt76.patch

diff --git a/patches/0013-fix-makefile-includes/mt76.patch b/patches/0013-fix-makefile-includes/mt76.patch
deleted file mode 100644
index 4f122c46..00000000
--- a/patches/0013-fix-makefile-includes/mt76.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
-+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
-@@ -15,6 +15,7 @@
-  */
- #include <linux/kernel.h>
- #include <linux/firmware.h>
-+#include <linux/module.h>
- 
- #include "mt76x0.h"
- #include "mcu.h"
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
