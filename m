Return-Path: <SRS0=kiHp=QC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6193C282C9
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857ED2184C
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfAZWA7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 26 Jan 2019 17:00:59 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:28276 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfAZWA6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sat, 26 Jan 2019 17:00:58 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 109FAA12DD;
        Sat, 26 Jan 2019 23:00:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 28vdqp35h4ck; Sat, 26 Jan 2019 23:00:55 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/7] backports: Add DEFINE_SHOW_ATTRIBUTE macro
Date:   Sat, 26 Jan 2019 23:00:28 +0100
Message-Id: <20190126220033.27634-3-hauke@hauke-m.de>
In-Reply-To: <20190126220033.27634-1-hauke@hauke-m.de>
References: <20190126220033.27634-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This was introduced in Linux commit a08f06bb7a07 ("seq_file: Introduce
DEFINE_SHOW_ATTRIBUTE() helper macro" and is used by the cw1200 and the
wil6210 driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/seq_file.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/backport/backport-include/linux/seq_file.h b/backport/backport-include/linux/seq_file.h
index ad1bded5..5b88f6f8 100644
--- a/backport/backport-include/linux/seq_file.h
+++ b/backport/backport-include/linux/seq_file.h
@@ -48,4 +48,20 @@ void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
 		  bool ascii);
 #endif
 
+#ifndef DEFINE_SHOW_ATTRIBUTE
+#define DEFINE_SHOW_ATTRIBUTE(__name)					\
+static int __name ## _open(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, __name ## _show, inode->i_private);	\
+}									\
+									\
+static const struct file_operations __name ## _fops = {			\
+	.owner		= THIS_MODULE,					\
+	.open		= __name ## _open,				\
+	.read		= seq_read,					\
+	.llseek		= seq_lseek,					\
+	.release	= single_release,				\
+}
+#endif /* DEFINE_SHOW_ATTRIBUTE */
+
 #endif /* __BACKPORT_SEQ_FILE_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
