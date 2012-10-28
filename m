Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ozancag@gmail.com>
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 1/7] compat-drivers: Handle int's when generating compat_autoconf.h
Date: Sun, 28 Oct 2012 19:04:15 +0200
Message-Id: <1351443861-26280-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

Some Kconfig variables take integer values instead of y/m/N like
CONFIG_NOUVEAU_DEBUG and CONFIG_NOUVEAU_DEBUG_DEFAULT. Currently all
values other than y/m/N were escaped with double-quotes to define
them as strings. Fix this to allow integer values for Kconfig
variables.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 scripts/gen-compat-autoconf.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/gen-compat-autoconf.sh b/scripts/gen-compat-autoconf.sh
index f9fed36..c9ab9da 100755
--- a/scripts/gen-compat-autoconf.sh
+++ b/scripts/gen-compat-autoconf.sh
@@ -57,13 +57,19 @@ function define_config {
 		echo "#define $VAR 1"
 		echo "#endif /* $VAR */ "
 		;;
-	*) # Assume string
-		# XXX: add better checks to make sure what was on
-		# the right was indeed a string
+	[0-9]*)
+		# Leave integers as is
+		echo "#ifndef $VAR"
+		echo "#define $VAR $VALUE"
+		echo "#endif /* $VAR */ "
+		;;
+	*)
+		# Escape every other thing with double quotes
 		echo "#ifndef $VAR"
 		echo "#define $VAR \"$VALUE\""
 		echo "#endif /* $VAR */ "
 		;;
+
 	esac
 }
 
-- 
1.7.11.7
