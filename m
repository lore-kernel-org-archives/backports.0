Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:55244 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619Ab3KVTVv (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 22 Nov 2013 14:21:51 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: fix genetlink backport
Date: Fri, 22 Nov 2013 20:21:42 +0100
Message-Id: <1385148102-1224-1-git-send-email-johannes@sipsolutions.net> (sfid-20131122_202152_961432_33A5BC28)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

On kernels that already have pre_doit/post_doit, we don't
fake them by re-assigning all ops and their doit, but then
we clearly need to copy the pointers. Fix that oversight.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/backport-3.13.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
index 77eefef..d5b7029 100644
--- a/backport/compat/backport-3.13.c
+++ b/backport/compat/backport-3.13.c
@@ -159,6 +159,10 @@ int __backport_genl_register_family(struct genl_family *family)
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32)
 	__copy(netnsok);
 #endif
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)
+	__copy(pre_doit);
+	__copy(post_doit);
+#endif
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
 	__copy(parallel_ops);
 #endif
-- 
1.8.4.rc3

