Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48930 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754198AbdHUW2o (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:44 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/21] header: add module_param_hw_array()
Date: Tue, 22 Aug 2017 00:28:03 +0200
Message-Id: <20170821222817.17376-8-hauke@hauke-m.de> (sfid-20170822_002846_062483_690DDA19)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This macro is used for some module parameters.

This hwtype was newly introduced for module parameters in kernel 4.12,
just ignore it on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/moduleparam.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/moduleparam.h b/backport/backport-include/linux/moduleparam.h
index 1c7dfad4..9a8e03b5 100644
--- a/backport/backport-include/linux/moduleparam.h
+++ b/backport/backport-include/linux/moduleparam.h
@@ -36,4 +36,9 @@ extern int param_get_ullong(char *buffer, const struct kernel_param *kp);
 #define param_check_ullong(name, p) __param_check(name, p, unsigned long long)
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,12,0)
+#define module_param_hw_array(name, type, hwtype, nump, perm) \
+	module_param_array(name, type, nump, perm)
+#endif
+
 #endif /* __BACKPORT_LINUX_MODULEPARAM_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
