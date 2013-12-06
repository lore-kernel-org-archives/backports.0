Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51116 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab3LFSaD (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 6 Dec 2013 13:30:03 -0500
Received: by mail-wg0-f44.google.com with SMTP id a1so1026875wgh.23
        for <backports@vger.kernel.org>; Fri, 06 Dec 2013 10:30:02 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/3] backports: backport ktime_to_ms()
Date: Fri,  6 Dec 2013 19:29:28 +0100
Message-Id: <1386354570-23940-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20131206_193005_974323_C82194FD)
In-Reply-To: <1386354570-23940-1-git-send-email-mcgrof@do-not-panic.com>
References: <1386354570-23940-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backports ktime_to_ms()

mcgrof@cerro ~/linux-next (git::master)$ git describe --contains f56916b9
v2.6.35-rc1~490^2~16

commit f56916b97fe2031761ca611f0a342efd913afb33
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Fri May 7 13:34:37 2010 -0400

    ktime: introduce ktime_to_ms()

    To report ktime statistics to user space in milliseconds, a new helper
    is required.

    When considering how to do this conversion, I didn't immediately see
    why the extra step of converting ktime to a timeval was needed.  To
    make that more clear, introduce a couple of large comments.

    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/ktime.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 backport/backport-include/linux/ktime.h

diff --git a/backport/backport-include/linux/ktime.h b/backport/backport-include/linux/ktime.h
new file mode 100644
index 0000000..741be25
--- /dev/null
+++ b/backport/backport-include/linux/ktime.h
@@ -0,0 +1,14 @@
+#ifndef __BACKPORT_LINUX_KTIME_H
+#define __BACKPORT_LINUX_KTIME_H
+#include_next <linux/ktime.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+static inline s64 ktime_to_ms(const ktime_t kt)
+{
+	struct timeval tv = ktime_to_timeval(kt);
+	return (s64) tv.tv_sec * MSEC_PER_SEC + tv.tv_usec / USEC_PER_MSEC;
+}
+#endif /* #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35) */
+
+#endif
-- 
1.8.4.3

