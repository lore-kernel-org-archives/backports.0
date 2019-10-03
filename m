Return-Path: <SRS0=jmjh=X4=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E8DC10F14
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D43220830
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfJCRmW (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:42:22 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38310 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730925AbfJCP5W (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 3 Oct 2019 11:57:22 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 291E2A35FD;
        Thu,  3 Oct 2019 17:57:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id NTRCAQQyKg4b; Thu,  3 Oct 2019 17:57:18 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/11] backports: pci: include linux/pci-aspm.h
Date:   Thu,  3 Oct 2019 17:56:33 +0200
Message-Id: <20191003155642.14909-3-hauke@hauke-m.de>
In-Reply-To: <20191003155642.14909-1-hauke@hauke-m.de>
References: <20191003155642.14909-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

In upstream commit 7ce2e76a0420 linux/pci-aspm.h was removed and the
content included into pci.h. Add an include to have the functions
defined in linux/pci-aspm.h available when linux/pci.h is included.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 3a141bf3..84c4e8f6 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -3,6 +3,10 @@
 #include_next <linux/pci.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_IS_LESS(5,4,0)
+#include <linux/pci-aspm.h>
+#endif
+
 #ifndef module_pci_driver
 /**
  * module_pci_driver() - Helper macro for registering a PCI driver
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
