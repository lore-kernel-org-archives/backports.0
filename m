Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ozancag@gmail.com>
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 5/7] compat-drivers: Fix comments
Date: Sun, 28 Oct 2012 19:04:19 +0200
Message-Id: <1351443861-26280-5-git-send-email-ozancag@gmail.com>
In-Reply-To: <1351443861-26280-1-git-send-email-ozancag@gmail.com>
References: <1351443861-26280-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

The comments were wrong causing a misunderstanding while analyzing
the script's function.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 scripts/check_config.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/check_config.sh b/scripts/check_config.sh
index e7041bd..648c05b 100755
--- a/scripts/check_config.sh
+++ b/scripts/check_config.sh
@@ -3,10 +3,11 @@
 # regenerates the compat_autoconf header.
 
 # These variables are expected to be exported:
-#COMPAT_CONFIG=".config"
-#COMPAT_CONFIG_CW="config"
-#CONFIG_CHECK=".${COMPAT_CONFIG}.md5"
-#COMPAT_AUTOCONF="include/linux/compat_autoconf.h"
+#COMPAT_CONFIG_CW=$(PWD)/config.mk
+#COMPAT_CONFIG=$(PWD)/.config
+#CONFIG_CHECK=$(PWD)/.config.mk_md5sum.txt
+#COMPAT_AUTOCONF=include/linux/compat_autoconf.h
+
 
 function gen_compat_autoconf {
 	echo "./scripts/gen-compat-autoconf.sh $COMPAT_CONFIG $COMPAT_CONFIG_CW > $COMPAT_AUTOCONF"
-- 
1.7.11.7
