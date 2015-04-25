Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49626 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756966AbbDYNvX (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 09:51:23 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/9] header: do not use genl backport on RHEL 7.0
Date: Sat, 25 Apr 2015 15:51:03 +0200
Message-Id: <1429969864-16831-9-git-send-email-hauke@hauke-m.de> (sfid-20150425_155128_374839_6CA35FD9)
In-Reply-To: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
References: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The genl changes were backported to RHEL 7.0

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/genetlink.h | 2 +-
 backport/compat/backport-3.13.c           | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 0535b0f..5761268 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -18,7 +18,7 @@
 #define genl_dump_check_consistent(cb, user_hdr, family)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
 static inline int __real_genl_register_family(struct genl_family *family)
 {
 	return genl_register_family(family);
diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
index e281ac8..6ce72b2 100644
--- a/backport/compat/backport-3.13.c
+++ b/backport/compat/backport-3.13.c
@@ -93,6 +93,7 @@ EXPORT_SYMBOL_GPL(devm_regulator_unregister);
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)) */
 
 /************* generic netlink backport *****************/
+#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
 
 #undef genl_register_family
 #undef genl_unregister_family
@@ -154,6 +155,8 @@ int backport_genl_unregister_family(struct genl_family *family)
 }
 EXPORT_SYMBOL_GPL(backport_genl_unregister_family);
 
+#endif /* RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0) */
+
 #ifdef __BACKPORT_NET_GET_RANDOM_ONCE
 struct __net_random_once_work {
 	struct work_struct work;
-- 
1.9.1

