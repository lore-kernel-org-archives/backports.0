Return-Path: <SRS0=dpLs=UV=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE75C43613
	for <backports@archiver.kernel.org>; Sat, 22 Jun 2019 08:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B6C2070B
	for <backports@archiver.kernel.org>; Sat, 22 Jun 2019 08:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfFVIvB (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 22 Jun 2019 04:51:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53996 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFVIvB (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 22 Jun 2019 04:51:01 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <anthony.wong@canonical.com>)
        id 1hebjf-0001qy-FK
        for backports@vger.kernel.org; Sat, 22 Jun 2019 08:50:59 +0000
Received: by mail-pg1-f198.google.com with SMTP id s195so5511362pgs.13
        for <backports@vger.kernel.org>; Sat, 22 Jun 2019 01:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nRsTsEdNQs10LB0kne5DEeG896N+NmVkAoKfo79DZuw=;
        b=XNSVH/hyx6HY2jBcQaOLHgS1iey7tvaZQruRxaqa5J9W9yUVHGXVIm1Z7tnD8SToqw
         Vfz0ssb+gbZ1xUhnk4lmV3tendc+rGHMonGXPgyYdY2Vcc5R5qlDE01jlmFHobZlIuK9
         gUNMSmaekpVD9KJzcn2WDG8wcCBXaaSDJ9NEzTKiK8cNrTV/z85HOLrKfVYKC0VG8XxB
         oGa8XVPrpAjY4x6Yii56sWya88AiTtv8biRRa+Y81fNL9xCz2ZGPQoTXQUG1uCrzEBSC
         BIZBrzF/lgTmK37Zt/nbTF51Kpcr1q18DyoIwQAFna9YbJw5y5pD7od4qUFN56WLWBvf
         reqQ==
X-Gm-Message-State: APjAAAUZlaOyD72/0TXzTgFOlNlZlXxfKST5PQeVI426dDTZxUS2R3UQ
        hlRkkp88IGC3RsJZa8xtsyR5gnmaJpQc/OZF3EFECYj2JwXx7s66fHELY6DYMEbq0HnC/nCQewR
        3vA2liRI4n5Qd0veIjNdAv6XwNwvMK8me2zsWHg==
X-Received: by 2002:a17:90a:258b:: with SMTP id k11mr11399972pje.110.1561193457683;
        Sat, 22 Jun 2019 01:50:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy3QgHq5to5+XG6zk8SCEPqe8BLVWQVQxi7nnPd2j9FIx8t6+8Cs0oIG+6VSHE4JpEuwmurgQ==
X-Received: by 2002:a17:90a:258b:: with SMTP id k11mr11399950pje.110.1561193457388;
        Sat, 22 Jun 2019 01:50:57 -0700 (PDT)
Received: from canonical.com (124244234215.ctinets.com. [124.244.234.215])
        by smtp.gmail.com with ESMTPSA id c18sm5259674pfc.180.2019.06.22.01.50.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 22 Jun 2019 01:50:56 -0700 (PDT)
From:   anthony.wong@canonical.com
X-Google-Original-From: yp@anthonywong.net
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org
Subject: [PATCH] backports: Keep kconf/zconf.{lex,tab}.c during "make clean"
Date:   Sat, 22 Jun 2019 16:50:53 +0800
Message-Id: <20190622085053.6709-1-yp@anthonywong.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Anthony Wong <yp@anthonywong.net>

On recent kernel versions, build fails after "make clean" is run
because "make clean" removes kconf/zconf.{lex,tab}.c, so presesrve
them during "make clean".

Signed-off-by: Anthony Wong <yp@anthonywong.net>
---
 backport/Makefile.real | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/backport/Makefile.real b/backport/Makefile.real
index 65508028..e772a9cf 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -115,7 +115,10 @@ uninstall:
 	@echo Reboot.
 	@echo
 
+EXCLUDE_CLEAN := kconf/zconf.lex.c kconf/zconf.tab.c
 .PHONY: clean
 clean:
+	@$(foreach f, $(EXCLUDE_CLEAN), mv $(f) $(f).orig;)
 	@$(MAKE) -f Makefile.build clean
 	@$(MAKE) -C kconf clean
+	@$(foreach f, $(EXCLUDE_CLEAN), mv $(f).orig $(f);)
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
