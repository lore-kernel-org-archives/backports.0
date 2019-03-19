Return-Path: <SRS0=hPYX=RW=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A2DC43381
	for <backports@archiver.kernel.org>; Tue, 19 Mar 2019 06:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138BE20989
	for <backports@archiver.kernel.org>; Tue, 19 Mar 2019 06:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4QFKd2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbfCSGJU (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:09:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45336 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSGJU (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Mar 2019 02:09:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so3912380pgk.12
        for <backports@vger.kernel.org>; Mon, 18 Mar 2019 23:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=7N1ouRxa4TSFGu4udslbaDq+i5rQRCGlHsRn/0j1M6I=;
        b=I4QFKd2ipugGCu8RMfGVpXd845Tn1Is9mdtSVRL+k3/v/5P8M+gEUNFophdiEEs5Xp
         EkMAhAGzXkgByjQEJISFQcjim6bHueHRRXAH73pxVXiQOlWgcnuHgHovmht4f/clK0tZ
         zwaPL5q0PIy1SU4wtSsnS/1kNihEgtPLjzvGU2FQXXfwB2V1EmzbWIq/FMdiecb023k5
         ZtyGdVLH+B4kAYO2AYqtyjDZcEzPv31o2Nd+yBcEGtPxbAh9YrjHjH56PWrYaY32GBll
         FjO5r19R/SctCSEB8kFrwuO11Q+WxA04siVrw9UoIu+BEBoqFQ+oeYzhtMAU6kWNjGVx
         5sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=7N1ouRxa4TSFGu4udslbaDq+i5rQRCGlHsRn/0j1M6I=;
        b=TZlekN1FOE2SDMqk84KyUGoMqiMDQ5K67DiXWS/hFLIJK3Iy6dF4ldNVKHGk4huJVj
         EEaJqM2AA/gIfzQlQ5u9fsqfYdim4ay/3sbd3bc8nHgYqELQcGUr3uJpcR2aPo7E7Jh+
         yvp/5I7VCzeLKJRx+oHwZZddecXJQ6SPmE1LI0gLZiIQmTZa9upDqcRYzP92ucC8jMuC
         1dczWQ9JtkpCJ3Pggy41TQujMpZnXMiulWIHkuvGqGIBJQXV3FnZ75oHif3yqXWDfhKW
         rc249mh2P+mUS2iTOnznbDYoo1nJb+s5aevwJwOJudbfmEBElUQ8LA9GaBTUFO6GD17G
         hzhQ==
X-Gm-Message-State: APjAAAUgOzDITkPi3Yl1elOTArbhN8Z+OjicqqfZA6LmxxHjhVqQ1THv
        wxIMIhZ1BxrpyVAJAQG8oJK9gpkU64w=
X-Google-Smtp-Source: APXvYqwMS0opi1voMy/8y0viQGD1A4HB50dfwmZmc/Y24DvfX0tjMMGCn6SblUm0naXDvFCItZgSAA==
X-Received: by 2002:a17:902:6804:: with SMTP id h4mr300782plk.115.1552975759736;
        Mon, 18 Mar 2019 23:09:19 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id x1sm19514951pge.73.2019.03.18.23.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 23:09:19 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH 1/2] backports: remove mt76.patch
Date:   Tue, 19 Mar 2019 14:09:14 +0800
Message-Id: <20190319060915.19849-2-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190319060915.19849-1-acelan.kao@canonical.com>
References: <20190319060915.19849-1-acelan.kao@canonical.com>
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
