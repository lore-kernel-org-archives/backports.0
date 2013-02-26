Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 6/6] compat-drivers: move disable_drm
Date: Tue, 26 Feb 2013 21:47:00 +0100
Message-Id: <1361911620-29333-7-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911620-29333-1-git-send-email-hauke@hauke-m.de>
References: <1361911620-29333-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Upstream commit 483aca89f39525a0d9bfcddade5beed19d659d7f

drm should be disabled when disable_bt_usb_ethernet is selected. This
disables drm also for e.g. b43.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 scripts/driver-select |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/driver-select b/scripts/driver-select
index 033d7e5..6eed37e 100755
--- a/scripts/driver-select
+++ b/scripts/driver-select
@@ -193,13 +193,13 @@ function disable_bt_usb_ethernet {
 	disable_ethernet
 	disable_bt
 	disable_update-initramfs
+	disable_drm
 }
 
 function disable_bt_usb_ethernet_var {
 	backup_file Makefile
 	disable_bt_usb_ethernet
 	disable_var_03
-	disable_drm
 }
 
 function enable_only_ethernet {
-- 
1.7.10.4
