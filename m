Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:51296 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbaDLBfO (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 21:35:14 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so6049856pab.41
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:35:13 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 07/10] backports: backport define of SIOCGHWTSTAMP
Date: Fri, 11 Apr 2014 18:34:32 -0700
Message-Id: <1397266475-14442-8-git-send-email-mcgrof@do-not-panic.com> (sfid-20140412_033515_967785_39CA6B1F)
In-Reply-To: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Ben added ioctl support for the unprivileged SIOCGHWTSTAMP
which is designed to just get the configuration, unlike
SIOCSHWTSTAMP which requires you to set it and only after
it returns the configuration.

Since we are carrying over a small addition to a UAPI header
without carrying it over completely (we use copy-list to
carry over full UAPI headers) its worth making a design note
about this.

We carry UAPI headers for backports to enable compilation
of kernel / driver code to compile without any changes. If
it so happens that a feature is backported it can be added
here but notice that if full subsystems are backported you
should just include the respective full header onto the
copy-list file so that its copied intact. The strategy on this
patch can be used to either backport a specific feature or
to just avoid having to do ifdef changes to compile kernel
or driver carried over by backports.

Userspace is *not expected* to copy over backports headers
to compile userspace programs, userspace programs can
and should consider carrying over a respective copy-list
of the latest UAPI kernel headers they need in their
upstream sources, the kernel the user uses, whether with
backports or not should be able to return -EOPNOTSUPP if
the feature is not available and let it through if its
supported and meats the expected form.

In this particular case if userspace tries to send the
SIOCGHWTSTAMP they'd end up with -ENOTTY.

mcgrof@ergon ~/linux (git::master)$ git describe --contains fd468c74
v3.14-rc1~94^2~622^2~12

commit fd468c74bd4d6949736810a80d6ca05eb20fba84
Author: Ben Hutchings <bhutchings@solarflare.com>
Date:   Thu Nov 14 01:19:29 2013 +0000

    net_tstamp: Add SIOCGHWTSTAMP ioctl to match SIOCSHWTSTAMP

    SIOCSHWTSTAMP returns the real configuration to the application
    using it, but there is currently no way for any other
    application to find out the configuration non-destructively.
    Add a new ioctl for this, making it unprivileged.

    Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/uapi/linux/sockios.h | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 backport/backport-include/uapi/linux/sockios.h

diff --git a/backport/backport-include/uapi/linux/sockios.h b/backport/backport-include/uapi/linux/sockios.h
new file mode 100644
index 0000000..6c4febe
--- /dev/null
+++ b/backport/backport-include/uapi/linux/sockios.h
@@ -0,0 +1,31 @@
+#ifndef __BACKPORT_LINUX_SOCKIOS_H
+#define __BACKPORT_LINUX_SOCKIOS_H
+#include_next <linux/sockios.h>
+#include <linux/version.h>
+
+/*
+ * Kernel backports UAPI note:
+ *
+ * We carry UAPI headers for backports to enable compilation
+ * of kernel / driver code to compile without any changes. If
+ * it so happens that a feature is backported it can be added
+ * here but notice that if full subsystems are backported you
+ * should just include the respective full header onto the
+ * copy-list file so that its copied intact. This strategy
+ * is used to either backport a specific feature or to just
+ * avoid having to do ifdef changes to compile.
+ *
+ * Userspace is not expected to copy over backports headers
+ * to compile userspace programs, userspace programs can
+ * and should consider carrying over a respective copy-list
+ * of the latest UAPI kernel headers they need in their
+ * upstream sources, the kernel the user uses, whether with
+ * backports or not should be able to return -EOPNOTSUPP if
+ * the feature is not available and let it through if its
+ * supported and meats the expected form.
+ */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+#define SIOCGHWTSTAMP	0x89b1		/* get config			*/
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
+#endif /* __BACKPORT_LINUX_SOCKIOS_H */
-- 
1.9.1

