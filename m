Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16690C71155
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC0620709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="hdZBFLP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388565AbgLAWGg (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389580AbgLAWGf (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:06:35 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E82FC08ED7E
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:05:09 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Clx3G4fHMzQlM3;
        Tue,  1 Dec 2020 23:04:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pNI5i/lv/nV2XSHp4bZr7M/RenqgUk/UkxnJgLQeLqU=;
        b=hdZBFLP6SfqbGVR8dNRHFAEhPQduv39vbzlBa8093Go1OfHckBRpcLAvsjdJocol9aj72A
        LtT2Wk1F8v/xkyne0T6SicHs3Qv/6wvypglHiS1xU1tKTF6WvoXxhhAi7yxTjBopbBCu31
        mfwZMMgsVwP1LhhJmwD2DGKTNE3nliWD93AW9nZrHdM9jeo+KPlT5r5SyJCQZhR0QqI/kE
        76u4TT0+ccDimxl4i7maS19pbhsEd6GCIz4Q8SMTMi5ZjCio3H/UhY1gP/FN1Gs4TpJKfs
        hTQXqjBFdqSPUVQ90+kqAhG1JO6gfL0baUkZuBkPj40fXOqyOOm1HUpZ5RhdNw==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 0d1dbnt2vFhj; Tue,  1 Dec 2020 23:04:39 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 25/30] headers: Add DEFINE_SEQ_ATTRIBUTE
Date:   Tue,  1 Dec 2020 23:04:10 +0100
Message-Id: <20201201220415.30582-26-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: C64D31855
X-Rspamd-UID: ca80d6
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add the DEFINE_SEQ_ATTRIBUTE which was added in commit d2c0e6e91c79
("include/linux/seq_file.h: introduce DEFINE_SEQ_ATTRIBUTE() helper
macro") in kernel 5.8. This is used by ath5k.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/seq_file.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/backport/backport-include/linux/seq_file.h b/backport/backport-include/linux/seq_file.h
index 5b88f6f8..1d78bbbd 100644
--- a/backport/backport-include/linux/seq_file.h
+++ b/backport/backport-include/linux/seq_file.h
@@ -64,4 +64,25 @@ static const struct file_operations __name ## _fops = {			\
 }
 #endif /* DEFINE_SHOW_ATTRIBUTE */
 
+#ifndef DEFINE_SEQ_ATTRIBUTE
+#define DEFINE_SEQ_ATTRIBUTE(__name)					\
+static int __name ## _open(struct inode *inode, struct file *file)	\
+{									\
+	int ret = seq_open(file, &__name ## _sops);			\
+	if (!ret && inode->i_private) {					\
+		struct seq_file *seq_f = file->private_data;		\
+		seq_f->private = inode->i_private;			\
+	}								\
+	return ret;							\
+}									\
+									\
+static const struct file_operations __name ## _fops = {			\
+	.owner		= THIS_MODULE,					\
+	.open		= __name ## _open,				\
+	.read		= seq_read,					\
+	.llseek		= seq_lseek,					\
+	.release	= seq_release,					\
+}
+#endif /* DEFINE_SEQ_ATTRIBUTE */
+
 #endif /* __BACKPORT_SEQ_FILE_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
