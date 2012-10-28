Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ozancag@gmail.com>
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 3/7] compat-drivers: Add missing config check
Date: Sun, 28 Oct 2012 19:04:17 +0200
Message-Id: <1351443861-26280-3-git-send-email-ozancag@gmail.com>
In-Reply-To: <1351443861-26280-1-git-send-email-ozancag@gmail.com>
References: <1351443861-26280-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

No configuration change was retriggering config update because
of this missing line unless you give the 'bt' target.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 52bc9a6..7a5a54a 100644
--- a/Makefile
+++ b/Makefile
@@ -96,6 +96,7 @@ all: modules
 $(COMPAT_CONFIG): ;
 
 modules: $(CREL_CHECK)
+	+@./scripts/check_config.sh
 	$(MAKE) -C $(KLIB_BUILD) M=$(PWD) modules
 	@touch $@
 
-- 
1.7.11.7
