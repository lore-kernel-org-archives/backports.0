Return-Path: <SRS0=vn7s=4C=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A18C2BA83
	for <backports@archiver.kernel.org>; Fri, 14 Feb 2020 09:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360FB222C4
	for <backports@archiver.kernel.org>; Fri, 14 Feb 2020 09:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgBNJc0 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:32:26 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:39642 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgBNJc0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 14 Feb 2020 04:32:26 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j2XKi-00BGbD-9K; Fri, 14 Feb 2020 10:32:24 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: suppress attribute((cold)) warnings with gcc 9
Date:   Fri, 14 Feb 2020 10:32:21 +0100
Message-Id: <20200214093221.11931-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since my last system upgrade I started building with gcc 9,
and that complains that a function is cold when the one we
create locally here isn't - mark it as cold always, I don't
think it would complain the other way around.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/module.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/linux/module.h b/backport/backport-include/linux/module.h
index 1a2c82f45b75..675d8d770954 100644
--- a/backport/backport-include/linux/module.h
+++ b/backport/backport-include/linux/module.h
@@ -33,7 +33,7 @@ extern void backport_dependency_symbol(void);
 		backport_dependency_symbol();				\
 		return initfn();					\
 	}								\
-	int init_module(void) __attribute__((alias("__init_backport")));\
+	int init_module(void) __attribute__((cold,alias("__init_backport")));\
 	BACKPORT_MOD_VERSIONS
 
 /*
@@ -58,7 +58,7 @@ extern void backport_dependency_symbol(void);
 		exitfn();						\
 		rcu_barrier();						\
 	}								\
-	void cleanup_module(void) __attribute__((alias("__exit_compat")));
+	void cleanup_module(void) __attribute__((cold,alias("__exit_compat")));
 #endif
 
 #if LINUX_VERSION_IS_LESS(3,3,0)
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
