Return-Path: <SRS0=GVy1=45=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79548C2BB1D
	for <backports@archiver.kernel.org>; Thu, 12 Mar 2020 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1ED206E2
	for <backports@archiver.kernel.org>; Thu, 12 Mar 2020 15:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgCLP7X (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:59:23 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:57512 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbgCLP7X (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 12 Mar 2020 11:59:23 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jCQEz-004nuk-Bv; Thu, 12 Mar 2020 16:59:21 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] backports: add linux/units.h
Date:   Thu, 12 Mar 2020 16:59:11 +0100
Message-Id: <20200312165913.e9a97c70de23.Idb983599e482232ae3cfc3328e837e8a9bf1af7a@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We can just copy this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 copy-list       | 1 +
 copy-list.intel | 1 +
 2 files changed, 2 insertions(+)

diff --git a/copy-list b/copy-list
index 328e92d0fde5..ba10a0bf4b3a 100644
--- a/copy-list
+++ b/copy-list
@@ -23,6 +23,7 @@ include/linux/crc32poly.h
 include/linux/bitfield.h
 include/linux/average.h
 include/linux/overflow.h
+include/linux/units.h
 
 # crypto_memneq
 crypto/memneq.c -> compat/memneq.c
diff --git a/copy-list.intel b/copy-list.intel
index ee944edaaefb..28b6bc87ddfe 100644
--- a/copy-list.intel
+++ b/copy-list.intel
@@ -21,6 +21,7 @@ scripts/spelling.txt -> intc-scripts/spelling.txt
 include/linux/bitfield.h
 include/linux/average.h
 include/linux/overflow.h
+include/linux/units.h
 
 # crypto_memneq
 crypto/memneq.c -> compat/memneq.c
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
