Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] compat: fix cordic backport header
Date: Tue, 26 Mar 2013 15:19:22 -0700
Message-Id: <1364336362-10826-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

mcgrof@frijol ~/linux-next (git::master)$ git describe --contains \
	10f8113ecb76eea72f96c7cfb72d7fed7c282565
v3.1-rc1~24^2~10^2^2~515

The cordic backport added the cordic library
and the cordic header. It correctly only compiled
cordic for kernels < 3.1 but the header however was
left intact. This is non-issue until cordic itself
gets updated with some new features or changes but
also an issue was created when we switched the
backort namespace. The issue is that the header
declares backport_cordic_calc_iq() exists while
it actually is not compiled on newer kernels.

Fix this by doing the kernel revision check on the
backported header, otherwise use #include_next to
get the next header, the proper kernel header.

This does not have to be added to the older releases
given that the header is the same for older kernels,
and we are not exporting the symbol twice given that
the proper check was already in place for cordic.c.

Reported-by: Camaleón <noelamac@gmail.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 include/linux/cordic.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/cordic.h b/include/linux/cordic.h
index 2de0aa3..7f27b00 100644
--- a/include/linux/cordic.h
+++ b/include/linux/cordic.h
@@ -1,3 +1,12 @@
+#ifndef _BACKPORT_LINUX_CORDIC_H
+#define _BACKPORT_LINUX_CORDIC_H 1
+
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(3,1,0))
+#include_next <linux/cordic.h>
+#else
+
 /*
  * Copyright (c) 2011 Broadcom Corporation
  *
@@ -47,3 +56,5 @@ struct cordic_iq {
 struct cordic_iq cordic_calc_iq(s32 theta);
 
 #endif /* __CORDIC_H_ */
+#endif /* LINUX_VERSION_CODE > KERNEL_VERSION(3,1,0)) */
+#endif /* _BACKPORT_LINUX_CORDIC_H */
-- 
1.7.10.4
