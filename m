Return-Path: <SRS0=6Pme=4J=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895A3C35641
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 09:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6626E206EF
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 09:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgBUJD1 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:03:27 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54828 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgBUJD1 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Feb 2020 04:03:27 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j546r-00EncU-Mh; Fri, 21 Feb 2020 09:56:33 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/15] backports: patch lib/refcount.c to make sparse happy
Date:   Fri, 21 Feb 2020 09:56:19 +0100
Message-Id: <20200221095437.ab78be8ac2e8.I1154c5725b98fb8535c25fce7862eeb546535515@changeid>
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

We're testing sparse, so don't want warnings here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/lib-refcount.patch | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/patches/lib-refcount.patch b/patches/lib-refcount.patch
index cca07cfb7df2..0f63ec6aa6d9 100644
--- a/patches/lib-refcount.patch
+++ b/patches/lib-refcount.patch
@@ -10,3 +10,21 @@ index 5d0582a..8d108f9 100644
  
  /**
   * refcount_add_not_zero_checked - add a value to a refcount unless it is 0
+@@ -153,6 +153,8 @@ bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
+ 		return false;
+ 	}
+ 
++	__release(lock);
++
+ 	return true;
+ }
+ EXPORT_SYMBOL(refcount_dec_and_lock);
+@@ -182,6 +184,8 @@ bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
+ 		return false;
+ 	}
+ 
++	__release(lock);
++
+ 	return true;
+ }
+ EXPORT_SYMBOL(refcount_dec_and_lock_irqsave);
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
