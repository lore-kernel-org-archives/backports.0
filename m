Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/5] compat-drivers: separate NOSTDINC_FLAGS include dir lines
Date: Fri, 28 Sep 2012 23:54:42 -0700
Message-Id: <1348901686-15036-2-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1348901686-15036-1-git-send-email-mcgrof@do-not-panic.com>
References: <1348901686-15036-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This will make it easier to review changes to this variable
later.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6eccff6..d8c7d27 100644
--- a/Makefile
+++ b/Makefile
@@ -31,7 +31,8 @@ ifneq ($(KERNELRELEASE),)
 -include $(COMPAT_CONFIG)
 include $(COMPAT_CONFIG_CW)
 
-NOSTDINC_FLAGS := -I$(M)/include/ \
+NOSTDINC_FLAGS := \
+	-I$(M)/include/ \
 	-include $(M)/include/linux/compat-2.6.h \
 	$(CFLAGS)
 
-- 
1.7.10.4
