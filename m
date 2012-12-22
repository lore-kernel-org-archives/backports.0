Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ozancag@gmail.com>
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 2/3] update-initramfs: Silence lsb_release output
Date: Sat, 22 Dec 2012 13:04:12 +0200
Message-Id: <1356174253-2192-2-git-send-email-ozancag@gmail.com>
In-Reply-To: <1356174253-2192-1-git-send-email-ozancag@gmail.com>
References: <1356174253-2192-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

Silence lsb_release output to avoid command not found errors
on distributions not having lsb_release like Fedora.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 scripts/update-initramfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-initramfs b/scripts/update-initramfs
index dcc1ee6..f926eeb 100755
--- a/scripts/update-initramfs
+++ b/scripts/update-initramfs
@@ -6,7 +6,7 @@
 # of their distribution. This can also help people who may
 # want to wireless-boot their systems.
 
-LSB_RED_ID=$(/usr/bin/lsb_release -i -s)
+LSB_RED_ID=$(/usr/bin/lsb_release -i -s &> /dev/null)
 
 KLIB=/lib/modules/$(uname -r)/build
 ver=$(echo $KLIB | awk -F "/lib/modules/" '{print $2}' | awk -F"/" '{print $1}')
-- 
1.8.0.2
