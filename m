Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1B3C433EF
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 12:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358820AbiBGMqg (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 07:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386376AbiBGLeb (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 06:34:31 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2E4C043188
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 03:34:30 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9DC6E3202455;
        Mon,  7 Feb 2022 06:34:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 07 Feb 2022 06:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=5lGvaqrQR2dW/T01s0B6Ba5MSXIKnr
        kAlO+JKo0cQ2A=; b=nSEpxmXhPT/QWLmV+prPVEynUoMILWZfjAiCKlhU2Fm/tT
        Au3klPyBoSN6+W5tY8zd/c7T7KS0NCIl4StrHyw4XCIBz1sbtJQC7S+Z/jxd/1P1
        2WLPr2KUWcm+kA3572jTEo2UaZzgX/hdqNeuUQI+0Nk8NnYkg2bclu6K6iLjUhXT
        igwgPMFZZhg+LHwZFOTTrwve0Y3ICVWKQbJ5n60abX48KYpkaIQpPLaLEp2FYuNO
        s4XQwwnhhVj0wPfPpSLYcgGai9VK6Wp6oUp+SFW9QIhLXa+JRnJUBoPbRoZIcWvR
        HtrliNn0iHr0SE3kILPmKhlf9ueutAjmwdt8Q/lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5lGvaq
        rQR2dW/T01s0B6Ba5MSXIKnrkAlO+JKo0cQ2A=; b=IdjlgK5u651OHhjsbXW98T
        vhqcQkbehZWUDkUdQDrfdxx5fmKY9k67TDauhHa/kXN+63MX1oqVKdr7/5zm6+nJ
        YNIkmolV0IYQTTkLD6l2VqBgjaw9/XBf9TgEbfio6P3pCJUN7yyLQjZfduU3hnXy
        vw979A6I8F2YdED714S80bxdWmv/IuWTxy/aOHQhIDG5UAqPhIvyo2Ta1sQl0X8y
        Zx+PX02w8iD9B1HJrOTBlyurCqD3Mpc/V5WFeNC/9/XE5RHCrvK/n15Qbh6kqpzW
        /SxWEWuiVCNw2WSFd1qSLD1XCGqhcA/k72nFJaNqBh8aGPWCaokTXgOFrIan9VPg
        ==
X-ME-Sender: <xms:xAMBYteMoWJGyiPgcSEWfkW0ExszfDn5l3hbkSoqMccdHI9kJluoXA>
    <xme:xAMBYrM9fLPM4EDflYVtTXuK6jVz5YbZM-nJW3LlPGTzqmibjXZVGEntWnAm5JAMt
    fNVmUOW7chNFBRUmWM>
X-ME-Received: <xmr:xAMBYmhvuR0S-d8Byar--tNmde3G8N_RTnNDA2bEshkJtdI2a0XIvtY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:xQMBYm9Lz2r-ZnXs9zLbFLRDdE7sA5U1pWj4ZswLCvY7VwmbXPFafQ>
    <xmx:xQMBYpucoMA9REfngLDJoqrZvbJ4zpsPxqQ6_Bzx_u2iklXRNwjsjw>
    <xmx:xQMBYlGM4JqFkvRLKEMl8pJxNLkwHL-7Xo3yn6N55r3gr-J5oApgNg>
    <xmx:xQMBYi6CKjonFf0h0ON5kb-Izrnpix2NdkOoghV_zxtdKzPBBWJcJg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 06:34:28 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 3/7] backports: backport {get,set}_user_ifreq
Date:   Mon,  7 Feb 2022 11:33:34 +0000
Message-Id: <20220207113338.214748-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
References: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
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
