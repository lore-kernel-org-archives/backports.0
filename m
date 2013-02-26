Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 4/6] compat-drivers: disable DRM drivers for 802.11 drivers
Date: Tue, 26 Feb 2013 21:46:58 +0100
Message-Id: <1361911620-29333-5-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911620-29333-1-git-send-email-hauke@hauke-m.de>
References: <1361911620-29333-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Upstream commit 2371a496060c87378c27eb0cb33feeefbc29f2fc

When using driver-select disable DRM driver sfor 802.11 drivers.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 scripts/driver-select |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/driver-select b/scripts/driver-select
index e5cc177..033d7e5 100755
--- a/scripts/driver-select
+++ b/scripts/driver-select
@@ -199,6 +199,7 @@ function disable_bt_usb_ethernet_var {
 	backup_file Makefile
 	disable_bt_usb_ethernet
 	disable_var_03
+	disable_drm
 }
 
 function enable_only_ethernet {
@@ -399,6 +400,7 @@ case $1 in
 		;;
 	ti)
 		select_drivers		CONFIG_WL_TI
+		disable_bt_usb_ethernet_var
 		disable_staging
 		disable_var_01
 		;;
-- 
1.7.10.4
