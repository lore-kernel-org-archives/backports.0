Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/5] compat-drivers: force using include/drm for header namespace
Date: Fri, 28 Sep 2012 23:54:43 -0700
Message-Id: <1348901686-15036-3-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1348901686-15036-1-git-send-email-mcgrof@do-not-panic.com>
References: <1348901686-15036-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Turns out DRM drivers use this:

 #include "drmP.h"

Instead of:

 #include <drm/drmP.h>

Withtout this change we are using the older kernel's header
file and not the one we are cherry pickng over from the kernel
we want to help backport.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index d8c7d27..e3c3fa6 100644
--- a/Makefile
+++ b/Makefile
@@ -33,6 +33,7 @@ include $(COMPAT_CONFIG_CW)
 
 NOSTDINC_FLAGS := \
 	-I$(M)/include/ \
+	-I$(M)/include/drm \
 	-include $(M)/include/linux/compat-2.6.h \
 	$(CFLAGS)
 
-- 
1.7.10.4
