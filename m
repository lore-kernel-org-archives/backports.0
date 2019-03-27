Return-Path: <SRS0=sLXW=R6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67A6C43381
	for <backports@archiver.kernel.org>; Wed, 27 Mar 2019 03:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AC82082F
	for <backports@archiver.kernel.org>; Wed, 27 Mar 2019 03:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omUuBi3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbfC0DA4 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:00:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43516 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfC0DA4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 26 Mar 2019 23:00:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so2925146pgu.10
        for <backports@vger.kernel.org>; Tue, 26 Mar 2019 20:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=0iO9tkOGqcI0tvGbQKa6YOU9sxnGsx47exhRnLQXXSw=;
        b=omUuBi3Sg3LPZTm3wqsBo+9Zeq7W6xN7vEKBybOzQpise8TB90WPlJkZaDU6C5c9fn
         6rg2w039CYvuLJv4A1H9cggpRqZymqBTirpRv2ygV7aCwmz9THIgzrpmo4Yd08ibLOvz
         BEDuoDmf+WXuxVgJ6XCont+cNdxNkd9PI77l+ZN7d2KAkeI3AhHAuWhwq8oGzvwaoHFl
         s5wNKit1DyKnbQiXTPKyBwRIIlnsP7SR1ORNDQNBBCSgMVrMjMdJD7golArXpDFDTnWE
         wqyuUXvgJwuzxheQKHN3fiW6ImyrWFtVizP6cXZlYa6cUoUAiMY7/5xggoe45EqgHPMi
         MzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=0iO9tkOGqcI0tvGbQKa6YOU9sxnGsx47exhRnLQXXSw=;
        b=tdCBcEk8qkvX7iB/+u+8LJZuBZRB75l9tDsg2tbcIlPr4nv+zs3HKA0qkU25pW+IQ6
         0CYngcbuB6VRi2K141S3/A2HK6MvOtMEm2ewajdwcNYbAQHV/+jvDRDofYwfuS94ero6
         u3W45jcV3/vcdatLbFHiaVUPdDBl9mL4Htpi+hdUh36O8DbOhC3zhqKhRLzvRTn1jC8b
         asrr3MVDjsQEQkmEQ6ebVdpw6LwFHSwk7CGaI1WXQS2ntUj7pPs9abDkV2+FDDofxnWo
         MDl8bwji8gptRdCcgtu0pVwqZsGWOd8YPujql4sVjXNMymlgKOPdxQ+bk2/yLNxJfeNM
         g00w==
X-Gm-Message-State: APjAAAXhzD2rp+gGZ3pEyQoYxw/P+uRjswMdthG66FkhXDjCUcXvpmzB
        gLTiJLT2r8Xptf5RD+1Dn7U=
X-Google-Smtp-Source: APXvYqy2ZKsY4U1h5Em7qAQCPpYhJr3ZGct9zXzypSxU6JvB/xr3PMiylUvS0M2qlVTl1/fqMDhklA==
X-Received: by 2002:aa7:8609:: with SMTP id p9mr32982477pfn.166.1553655655451;
        Tue, 26 Mar 2019 20:00:55 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id z77sm38785243pfi.155.2019.03.26.20.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 20:00:54 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH v3 3/3] backports: fix compilation error against v4.4 kernel
Date:   Wed, 27 Mar 2019 11:00:44 +0800
Message-Id: <20190327030044.28263-4-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327030044.28263-1-acelan.kao@canonical.com>
References: <20190327030044.28263-1-acelan.kao@canonical.com>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add the smp_acquire__after_ctrl_dep macro to compat/lib-refcount.c to
fix the compilation error

/tmp/tmp.Z85sMNyuzD/backports-5.1-rc1-test1/backports-5.1-rc1/compat/lib-refcount.c:
In function 'backport_refcount_sub_and_test_checked':
/tmp/tmp.Z85sMNyuzD/backports-5.1-rc1-test1/backports-5.1-rc1/compat/lib-refcount.c:198:3:
error: implicit declaration of function 'smp_acquire__after_ctrl_dep'
[-Werror=implicit-function-declaration]
   smp_acquire__after_ctrl_dep();
   ^

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 patches/lib-refcount.patch | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/patches/lib-refcount.patch b/patches/lib-refcount.patch
index 28106342..ae568f8d 100644
--- a/patches/lib-refcount.patch
+++ b/patches/lib-refcount.patch
@@ -2,11 +2,15 @@ diff --git a/compat/lib-refcount.c b/compat/lib-refcount.c
 index 5d0582a..8d108f9 100644
 --- a/compat/lib-refcount.c
 +++ b/compat/lib-refcount.c
-@@ -39,6 +39,7 @@
+@@ -42,6 +42,11 @@
  #include <linux/refcount.h>
  #include <linux/spinlock.h>
  #include <linux/bug.h>
 +#include <linux/export.h>
++
++#ifndef smp_acquire__after_ctrl_dep
++#define smp_acquire__after_ctrl_dep()           smp_rmb()
++#endif
  
  /**
   * refcount_add_not_zero_checked - add a value to a refcount unless it is 0
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
