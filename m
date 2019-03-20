Return-Path: <SRS0=IQna=RX=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CF8C43381
	for <backports@archiver.kernel.org>; Wed, 20 Mar 2019 02:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9525A2184D
	for <backports@archiver.kernel.org>; Wed, 20 Mar 2019 02:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7lX8vQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfCTCek (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:34:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38637 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfCTCek (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Mar 2019 22:34:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so765675pfo.5
        for <backports@vger.kernel.org>; Tue, 19 Mar 2019 19:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=7N1ouRxa4TSFGu4udslbaDq+i5rQRCGlHsRn/0j1M6I=;
        b=G7lX8vQoYd+fIpQmIHgnkxHEvsrSW6JCCBZeIzp6yTDcJABTNC9FKPnfVw7NzSvTtS
         1pdpyx+zOepgOxNWNIQEOZUWe4i3di1D6Qm2IRk1b8Qa/oWE7LrvvKsCDstaA3JCb/BH
         oAUYtojJQ8PDMXP9FFEjxpsFfF8su1x9qz/brfHfsYP72dM5/ELrM8Jf/pggD107kb4l
         sTCiBctfw2mWy7cMP4g0jlJ9eqbU1Kt+0/7X1c/rJ9biZGUKQGqW8Dp34fBUSTTqAL+t
         dUQ92G2OraljGMXnaxOh0ZFK2ZtFUKJ+6fgHi3Kg+AEgOY56IjHnbwgjZ3DFoQ1Uvtro
         ePBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=7N1ouRxa4TSFGu4udslbaDq+i5rQRCGlHsRn/0j1M6I=;
        b=VkWbhX2qmTcbG6+pYXbgS/zb17y0ces8LhZ0ezYxr7/JiTgHAaP7L7HA4q6d7b8Uyt
         BgMO6/7EfQbunPAu2HChYaUXJm9hEI3nzc42aBgF6OF+2XNOHvjI+dK+1GAhZPloDdrm
         8Hmh0XagTKsyItxnrmaCafcDlhsNXfP+ju6MXcQZf45wRyjx0aQUaqR1dTBWsPcK1ntt
         T+FZL1KYdsmtIShr6eaF6OGOqwm6CibQlk1/Ah3wREHoBE4GjFFixQ3CZTCFg+ftKJjy
         LNqpOTskThELHFCiUliBPbv8gJ2LB6iT0vZvVRGVsdc0YW03NqL3Wjpv7l8pIO0nArP6
         9alA==
X-Gm-Message-State: APjAAAWLPjD/zBnuQtncgUIdIoGYKFEVcQOrjkP/ENuWbohIZ4vXUzAP
        CMFkFEggvxE5u/aXVQN6A/M=
X-Google-Smtp-Source: APXvYqw8qJD3t4G/unOdNH+01xW6YCEVikGKZJ+KqYOvEj+b0oDzb1qsTUKCRQeSMjmg2mjOCOl7xQ==
X-Received: by 2002:a63:145b:: with SMTP id 27mr5367086pgu.74.1553049279468;
        Tue, 19 Mar 2019 19:34:39 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id c11sm339476pfn.65.2019.03.19.19.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 19:34:38 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH v2 1/2] backports: remove mt76.patch
Date:   Wed, 20 Mar 2019 10:34:33 +0800
Message-Id: <20190320023434.2804-2-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190320023434.2804-1-acelan.kao@canonical.com>
References: <20190320023434.2804-1-acelan.kao@canonical.com>
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
