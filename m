Return-Path: <SRS0=6Pme=4J=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF16C35642
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE44206DB
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgBUI4d (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:56:33 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54710 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgBUI4d (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Feb 2020 03:56:33 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j546q-00EncU-4X; Fri, 21 Feb 2020 09:56:32 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/15] backports: add some more atomic functions
Date:   Fri, 21 Feb 2020 09:56:13 +0100
Message-Id: <20200221095437.a7707d432cb0.Ib3fe021525950f62eba9fbebb67bd6374d4835e3@changeid>
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

Some of the new fetch atomics are now required, add them by
using the _return ones and changing the value accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/atomic.h | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/backport/backport-include/linux/atomic.h b/backport/backport-include/linux/atomic.h
index 9ceb586e864a..6669831ca8a9 100644
--- a/backport/backport-include/linux/atomic.h
+++ b/backport/backport-include/linux/atomic.h
@@ -60,4 +60,36 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 #endif
 #endif
 
+#ifndef __atomic_pre_full_fence
+#define __atomic_pre_full_fence         smp_mb__before_atomic
+#endif
+
+#ifndef __atomic_post_full_fence
+#define __atomic_post_full_fence        smp_mb__after_atomic
+#endif
+
+#if LINUX_VERSION_IS_LESS(4,8,0)
+static inline int
+atomic_fetch_add(int i, atomic_t *v)
+{
+	return atomic_add_return(i, v) - i;
+}
+
+static inline int
+atomic_fetch_sub(int i, atomic_t *v)
+{
+	return atomic_sub_return(i, v) + i;
+}
+#endif
+
+#ifndef atomic_fetch_add_relaxed
+#define atomic_fetch_add_relaxed atomic_fetch_add
+#endif
+
+#ifndef atomic_fetch_sub_relaxed
+#define atomic_fetch_sub_acquire atomic_fetch_sub
+#define atomic_fetch_sub_release atomic_fetch_sub
+#define atomic_fetch_sub_relaxed atomic_fetch_sub
+#endif
+
 #endif /* __BP_ATOMIC_H */
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
