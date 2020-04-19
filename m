Return-Path: <SRS0=xZrn=6D=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194AEC54FC9
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE2C21473
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgDSRLF (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:11:05 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:54938 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgDSRLF (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 19 Apr 2020 13:11:05 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 494xDj3q45zQlF1;
        Sun, 19 Apr 2020 19:11:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id Uw9ZmtGv4lWh; Sun, 19 Apr 2020 19:10:58 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/8] backports: fs: Adapt struct proc_ops
Date:   Sun, 19 Apr 2020 19:10:38 +0200
Message-Id: <20200419171039.17268-8-hauke@hauke-m.de>
In-Reply-To: <20200419171039.17268-1-hauke@hauke-m.de>
References: <20200419171039.17268-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B693C176F
X-Rspamd-Score: -5.43 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Since upstream commit 97a32539b956 ("proc: convert everything to "struct
proc_ops"") the drivers ate not using struct file_operations for proc
files any more, but the new struct proc_ops. This replaces the new names
with the old ones to make the driver still work on older kernel
versions.

The kernel commit also removed the .owner attribute which is not added
by this change again.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/fs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/fs.h b/backport/backport-include/linux/fs.h
index 9854290a..4e03adf6 100644
--- a/backport/backport-include/linux/fs.h
+++ b/backport/backport-include/linux/fs.h
@@ -59,4 +59,13 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 #endif
 #endif /* < 5.5 */
 
+#if LINUX_VERSION_IS_LESS(5,6,0)
+#define proc_ops file_operations
+#define proc_open open
+#define proc_read read
+#define proc_lseek llseek
+#define proc_release release
+#define proc_write write
+#endif /* < 5.6 */
+
 #endif	/* _COMPAT_LINUX_FS_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
