Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788E1C4321E
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJKVFY (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJKVFB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C19228E20
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ug/pkXvdSrGiDEUP1E/SuE/0uSHKuABkjYQXrkZXdak=;
        t=1665522297; x=1666731897; b=OPKANp8GtwiaU7246KBgubH1yzlrsAtgcyARLYiIoFYsEAO
        +yDZSe9rLygP22WNTWTaKwbzpUA+DqNumj7tWJful08OZ5GqER6Mh/0YgHTiinZEqNwNw1V4KU/2J
        0z7Qn0xD4vu/eQlkRWws5ZVUWkWH9hCDU8mKkDRNCFzglT6lS6V4wIDQYm/Ngjy6R37AkzcpVm1OJ
        gXXXjkuza/CtZNeWWcxQS6rsb7BAYSt4zJlDG4S1OIYCEjSDXRuiysturiKuSXU5Mfv5+gWg6o/VX
        ucJqHF6J08TbeHmPi9/5uDNGr+ne3ha/3BaezcnmNz+d5oWa0j62piD81Y+LY1zw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQo-0045LP-39;
        Tue, 11 Oct 2022 23:04:55 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 22/38] backports: add module namespace support
Date:   Tue, 11 Oct 2022 23:04:30 +0200
Message-Id: <20221011230356.7685cc3373dc.Id7fdad79d5130d44fe2e2bf5ea64ab10ec9f0022@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add EXPORT_SYMBOL_NS_GPL() and MODULE_IMPORT_NS(),
for kernels that don't yet know about it. Just do
nothing about namespaces in that case, of course.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/export.h | 12 ++++++++++++
 backport/backport-include/linux/module.h |  4 ++++
 2 files changed, 16 insertions(+)
 create mode 100644 backport/backport-include/linux/export.h

diff --git a/backport/backport-include/linux/export.h b/backport/backport-include/linux/export.h
new file mode 100644
index 000000000000..c24c9f99c78b
--- /dev/null
+++ b/backport/backport-include/linux/export.h
@@ -0,0 +1,12 @@
+#ifndef _COMPAT_LINUX_EXPORT_H
+#define _COMPAT_LINUX_EXPORT_H 1
+
+#include <linux/version.h>
+
+#include_next <linux/export.h>
+
+#ifndef EXPORT_SYMBOL_NS_GPL
+#define EXPORT_SYMBOL_NS_GPL(sym, ns) EXPORT_SYMBOL_GPL(sym)
+#endif
+
+#endif /* _COMPAT_LINUX_EXPORT_H */
diff --git a/backport/backport-include/linux/module.h b/backport/backport-include/linux/module.h
index efe970f174ed..b93a56d97611 100644
--- a/backport/backport-include/linux/module.h
+++ b/backport/backport-include/linux/module.h
@@ -67,4 +67,8 @@ extern void backport_dependency_symbol(void);
 	__CFI_ADDRESSABLE(cleanup_module, __exitdata);
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,4,0)
+#define MODULE_IMPORT_NS(ns)
+#endif
+
 #endif /* __BACKPORT_LINUX_MODULE_H */
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
