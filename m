Return-Path: <SRS0=vds9=5F=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF27EC54EEB
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8608020714
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCTXkP (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:40:15 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:48168 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCTXkP (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 20 Mar 2020 19:40:15 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 48kgHc1kDMzQlFf;
        Sat, 21 Mar 2020 00:40:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id LreqJcfaWfIa; Sat, 21 Mar 2020 00:40:09 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/8] backports: fs.h: Add compat_ptr_ioctl()
Date:   Sat, 21 Mar 2020 00:39:44 +0100
Message-Id: <20200320233950.32257-3-hauke@hauke-m.de>
In-Reply-To: <20200320233950.32257-1-hauke@hauke-m.de>
References: <20200320233950.32257-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

compat_ptr_ioctl() was added in upstream commit 2952db0fd51b
("compat_ioctl: add compat_ptr_ioctl()") and is now used by the cdc-wdm
driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/fs.h | 10 +++++++
 backport/compat/Makefile             |  1 +
 backport/compat/backport-5.5.c       | 41 ++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 backport/compat/backport-5.5.c

diff --git a/backport/backport-include/linux/fs.h b/backport/backport-include/linux/fs.h
index 6e4d4a53..9854290a 100644
--- a/backport/backport-include/linux/fs.h
+++ b/backport/backport-include/linux/fs.h
@@ -49,4 +49,14 @@ static inline struct inode *file_inode(struct file *f)
 extern loff_t no_seek_end_llseek(struct file *, loff_t, int);
 #endif /* < 4.5 && >= 3.2 */
 
+#if LINUX_VERSION_IS_LESS(5,5,0)
+#ifdef CONFIG_COMPAT
+#define compat_ptr_ioctl LINUX_BACKPORT(compat_ptr_ioctl)
+extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
+					unsigned long arg);
+#else
+#define compat_ptr_ioctl NULL
+#endif
+#endif /* < 5.5 */
+
 #endif	/* _COMPAT_LINUX_FS_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index e92e3120..6f1b0a89 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -38,6 +38,7 @@ compat-$(CPTCFG_KERNEL_4_8) += backport-4.8.o
 compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
 compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
 compat-$(CPTCFG_KERNEL_5_2) += backport-5.2.o backport-genetlink.o
+compat-$(CPTCFG_KERNEL_5_5) += backport-5.5.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7.asn1.o
diff --git a/backport/compat/backport-5.5.c b/backport/compat/backport-5.5.c
new file mode 100644
index 00000000..6f46be9d
--- /dev/null
+++ b/backport/compat/backport-5.5.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/compat.h>
+
+#ifdef CONFIG_COMPAT
+/**
+ * compat_ptr_ioctl - generic implementation of .compat_ioctl file operation
+ *
+ * This is not normally called as a function, but instead set in struct
+ * file_operations as
+ *
+ *     .compat_ioctl = compat_ptr_ioctl,
+ *
+ * On most architectures, the compat_ptr_ioctl() just passes all arguments
+ * to the corresponding ->ioctl handler. The exception is arch/s390, where
+ * compat_ptr() clears the top bit of a 32-bit pointer value, so user space
+ * pointers to the second 2GB alias the first 2GB, as is the case for
+ * native 32-bit s390 user space.
+ *
+ * The compat_ptr_ioctl() function must therefore be used only with ioctl
+ * functions that either ignore the argument or pass a pointer to a
+ * compatible data type.
+ *
+ * If any ioctl command handled by fops->unlocked_ioctl passes a plain
+ * integer instead of a pointer, or any of the passed data types
+ * is incompatible between 32-bit and 64-bit architectures, a proper
+ * handler is required instead of compat_ptr_ioctl.
+ */
+long compat_ptr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	if (!file->f_op->unlocked_ioctl)
+		return -ENOIOCTLCMD;
+
+	return file->f_op->unlocked_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+EXPORT_SYMBOL(compat_ptr_ioctl);
+#endif
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
