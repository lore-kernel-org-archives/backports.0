Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E7CC433EF
	for <backports@archiver.kernel.org>; Sun,  6 Feb 2022 22:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbiBFW11 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346658AbiBFW10 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 6 Feb 2022 17:27:26 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C6CC061353
        for <backports@vger.kernel.org>; Sun,  6 Feb 2022 14:27:25 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B18723200B8B;
        Sun,  6 Feb 2022 17:27:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 06 Feb 2022 17:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=5lGvaqrQR2dW/T01s0B6Ba5MSXIKnr
        kAlO+JKo0cQ2A=; b=LDCWTxzPFf1R8YqPylDecg968DIFJo0mWiHlndnkIGlFtR
        j4EFT+9khyUNXeD7KywKIWj3PuPJRz6qVxB1plf3HyhcnMXI9FgUZ9woNtLilY51
        havVQq8d+mXDdo1tybAHyEMvFcjmvnqL+OCjbOr/lpCFQWkgD6hdZZUZgUPROF70
        ow14zTzVhlidlZBKQXDOmPGpaYc40rz34k2SNm7MoYLWwM2V2x6H3b1D0P/u+fa2
        0U7cugNWTHW60xw6fmUlkKcktfD3Ymg+kYUWhSWDvJnwi+0bjYadtcC2FeFqnSTo
        O9CK+UI/9NNXD0TnaHBgztNzD4JPtdONQC96ADoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5lGvaq
        rQR2dW/T01s0B6Ba5MSXIKnrkAlO+JKo0cQ2A=; b=FdU8KDTHAPp2SWHEExxLBz
        o/VQ86JFYIQYTo+vidQtdmma3CntNhped1gtGlrnP90bfL66vZnxRk0g/b3x6sNd
        Jbd0r9reBDQSdHNO1Ie+Xz7QzhZ0SCcfweFOmWrvNEKmUucOUpQVQrHqCJhyzYVW
        k7p8dFuh7orai/ryCiSZJPL0b3A/rA424mjORWLNAB1G46KNPcmn+8KKwfGRSQQq
        NeV8ZnTUqxF66MbbReAciewdAShu3nZDUt7jZ8Pa9dHWt4smJCdF+5LdbVcYblap
        DfDyNXebLBga3rTvH5unTCc7/Avn6/Y+iLFIEhrU85LaOo3lYHKwpj5OpzU7m6rQ
        ==
X-ME-Sender: <xms:TEsAYrkN1k35PlpY1KyBcFsoTpHjBgMDpLw5h3aLSKKDLd3j81fzug>
    <xme:TEsAYu0p-tCRH-oxwhtN5mAZ6q7iETMKZMHH0JEcuf5guqq-kgn10m3Z24bK0DZoK
    9Ko9xevWV9aWYwmFVs>
X-ME-Received: <xmr:TEsAYhogC-CZHoPU9VrVgtCKmFq48iEJH2fzxBxskkTfbCJg6irAYGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheefgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejiefhgfetleekleffud
    ektdehvedujedvgeekkeejfefhhffhtedutefgtdffueenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:TEsAYjlzb8zEbrQ_S68FXs23DgXxRCpGM2j--gPovZ7Bx_OyFuz_qw>
    <xmx:TEsAYp0JyQ_LqI8pKRZ4E_oSwo36rnRC7Zl3ut5_lUYnGUyMoBXl2g>
    <xmx:TEsAYivC3tp-s812MNQ_L1SJ4UVDYD96iXkavZlO8K7v0pb53wxWMg>
    <xmx:TEsAYnDNXomVocrHs5QqcJ5VNZiZzGYoF12l-tbvvmAFY4423ypdMw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Feb 2022 17:27:23 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/6] backports: backport {get,set}_user_ifreq
Date:   Sun,  6 Feb 2022 22:26:53 +0000
Message-Id: <20220206222656.210655-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
References: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Backport them from 5.15, they are required by QRTR.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 backport/backport-include/linux/netdevice.h |  5 +++
 backport/compat/Makefile                    |  1 +
 backport/compat/backport-5.15.c             | 47 +++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 backport/compat/backport-5.15.c

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 22942398..4e553791 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -152,6 +152,11 @@ bp_dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
 #endif /* < 4.11 */
 
 #if LINUX_VERSION_IS_LESS(5,15,0)
+#define get_user_ifreq LINUX_BACKPORT(get_user_ifreq)
+int get_user_ifreq(struct ifreq *ifr, void __user **ifrdata, void __user *arg);
+#define put_user_ifreq LINUX_BACKPORT(put_user_ifreq)
+int put_user_ifreq(struct ifreq *ifr, void __user *arg);
+
 static inline void backport_dev_put(struct net_device *dev)
 {
 	if (dev)
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 2761e5f5..b9f1dee9 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -20,6 +20,7 @@ compat-$(CPTCFG_KERNEL_5_5) += backport-5.5.o
 compat-$(CPTCFG_KERNEL_5_10) += backport-5.10.o
 compat-$(CPTCFG_KERNEL_5_11) += backport-5.11.o
 compat-$(CPTCFG_KERNEL_5_13) += backport-5.13.o
+compat-$(CPTCFG_KERNEL_5_15) += backport-5.15.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7.asn1.o
diff --git a/backport/compat/backport-5.15.c b/backport/compat/backport-5.15.c
new file mode 100644
index 00000000..cc0a48fd
--- /dev/null
+++ b/backport/compat/backport-5.15.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/compat.h>
+#include <linux/export.h>
+#include <linux/uaccess.h>
+#include <linux/netdevice.h>
+
+#include <uapi/linux/if.h>
+
+int get_user_ifreq(struct ifreq *ifr, void __user **ifrdata, void __user *arg)
+{
+	if (in_compat_syscall()) {
+		struct compat_ifreq *ifr32 = (struct compat_ifreq *)ifr;
+
+		memset(ifr, 0, sizeof(*ifr));
+		if (copy_from_user(ifr32, arg, sizeof(*ifr32)))
+			return -EFAULT;
+
+		if (ifrdata)
+			*ifrdata = compat_ptr(ifr32->ifr_data);
+
+		return 0;
+	}
+
+	if (copy_from_user(ifr, arg, sizeof(*ifr)))
+		return -EFAULT;
+
+	if (ifrdata)
+		*ifrdata = ifr->ifr_data;
+
+	return 0;
+}
+EXPORT_SYMBOL(get_user_ifreq);
+
+int put_user_ifreq(struct ifreq *ifr, void __user *arg)
+{
+	size_t size = sizeof(*ifr);
+
+	if (in_compat_syscall())
+		size = sizeof(struct compat_ifreq);
+
+	if (copy_to_user(arg, ifr, size))
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL(put_user_ifreq);
-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
