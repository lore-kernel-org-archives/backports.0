Return-Path: <SRS0=6Pme=4J=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221C0C35640
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF492067D
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgBUI4f (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:56:35 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54730 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbgBUI4f (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Feb 2020 03:56:35 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j546r-00EncU-DF; Fri, 21 Feb 2020 09:56:33 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/15] backports: debugfs: add unsigned long helpers
Date:   Fri, 21 Feb 2020 09:56:18 +0100
Message-Id: <20200221095437.8e51d00ee118.I8721de5b950a581febb54720dfdc6253389df021@changeid>
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

debugfs_create_ulong and debugfs_create_xul.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/debugfs.h | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
index fb50c4f5750e..973c545cf0e0 100644
--- a/backport/backport-include/linux/debugfs.h
+++ b/backport/backport-include/linux/debugfs.h
@@ -60,4 +60,30 @@ debugfs_real_fops(const struct file *filp)
 	debugfs_create_file(name, mode, parent, data, fops)
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,4,0)
+static inline struct dentry *
+debugfs_create_ulong(const char *name, umode_t mode,
+		     struct dentry *parent, unsigned long *value)
+{
+	if (sizeof(unsigned long) == sizeof(u64))
+		return debugfs_create_u64(name, mode, parent, (u64 *)value);
+	if (sizeof(unsigned long) == sizeof(u32))
+		return debugfs_create_u32(name, mode, parent, (u32 *)value);
+	WARN_ON(1);
+	return ERR_PTR(-EINVAL);
+}
+#endif
+
+#if LINUX_VERSION_IS_LESS(5,5,0)
+static inline void debugfs_create_xul(const char *name, umode_t mode,
+				      struct dentry *parent,
+				      unsigned long *value)
+{
+	if (sizeof(*value) == sizeof(u32))
+		debugfs_create_x32(name, mode, parent, (u32 *)value);
+	else
+		debugfs_create_x64(name, mode, parent, (u64 *)value);
+}
+#endif
+
 #endif /* __BACKPORT_DEBUGFS_H_ */
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
