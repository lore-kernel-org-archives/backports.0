Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ozancag@gmail.com>
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 7/7] compat-drivers: Update README
Date: Sun, 28 Oct 2012 19:04:21 +0200
Message-Id: <1351443861-26280-7-git-send-email-ozancag@gmail.com>
In-Reply-To: <1351443861-26280-1-git-send-email-ozancag@gmail.com>
References: <1351443861-26280-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

Add GPU subsystem information to README.md.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 README.md | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README.md b/README.md
index 8945bc2..b647eb2 100644
--- a/README.md
+++ b/README.md
@@ -6,6 +6,7 @@ down to older kernels. It currently backports 3 subsystems:
   * Ethernet
   * Wireless
   * Bluetooth
+  * GPU
 
 This package provides the latest Linux kernel subsystem enhancements
 for kernels 2.6.24 and above. It is technically possible to support
-- 
1.7.11.7
