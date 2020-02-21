Return-Path: <SRS0=6Pme=4J=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A795C35640
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 09:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EDD206E2
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 09:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgBUJDS (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:03:18 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54818 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgBUJDS (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Feb 2020 04:03:18 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j546s-00EncU-D3; Fri, 21 Feb 2020 09:56:34 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/15] git-tracker: use python2 explicitly
Date:   Fri, 21 Feb 2020 09:56:21 +0100
Message-Id: <20200221095437.987c61c5267d.Icf8fe383c99c7f2fa0bd8c5e8077aabee77fb777@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221085624.6213-1-johannes@sipsolutions.net>
References: <20200221085624.6213-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/git-tracker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devel/git-tracker.py b/devel/git-tracker.py
index ef5eba51e2c2..1cb26ec82eb0 100755
--- a/devel/git-tracker.py
+++ b/devel/git-tracker.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python2
 """
  backports git tracker
 =======================
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
