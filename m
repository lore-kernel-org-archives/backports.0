Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49392 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdJMKEl (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 06:04:41 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add fixed version of __verify_pcpu_ptr
Date: Fri, 13 Oct 2017 12:04:37 +0200
Message-Id: <20171013100437.18073-1-johannes@sipsolutions.net> (sfid-20171013_120442_575458_4E11F624)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Some parts of the code (ath_cmn_is_fft_buf_full) use a per-CPU
pointer to an array, so we need to backport the fixed version
or this fails to compile in 3.10/3.11.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/percpu-defs.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/linux/percpu-defs.h

diff --git a/backport/backport-include/linux/percpu-defs.h b/backport/backport-include/linux/percpu-defs.h
new file mode 100644
index 000000000000..87a92e07e04f
--- /dev/null
+++ b/backport/backport-include/linux/percpu-defs.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_PERCPU_DEFS_H
+#define __BACKPORT_PERCPU_DEFS_H
+#include_next <linux/percpu-defs.h>
+
+/* override this with the array-safe version */
+#undef __verify_pcpu_ptr
+#define __verify_pcpu_ptr(ptr)						\
+do {									\
+	const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;	\
+	(void)__vpp_verify;						\
+} while (0)
+
+#endif /* __BACKPORT_PERCPU_DEFS_H */
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
