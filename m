Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org
Subject: [PATCH for 3.7 3/6] compat-drivers: add disable_drm to driver-select
Date: Tue, 26 Feb 2013 21:46:57 +0100
Message-Id: <1361911620-29333-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911620-29333-1-git-send-email-hauke@hauke-m.de>
References: <1361911620-29333-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Upstream commit 465d036de8310671c5ed6ad161276d30c05f952b

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 scripts/driver-select |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/driver-select b/scripts/driver-select
index 885033f..e5cc177 100755
--- a/scripts/driver-select
+++ b/scripts/driver-select
@@ -183,6 +183,10 @@ function disable_80211 {
 	perl -i -ne 'print if ! /CONFIG_COMPAT_WIRELESS/' Makefile
 }
 
+function disable_drm {
+	perl -i -ne 'print if ! /CONFIG_COMPAT_VIDEO_MODULES/' Makefile
+}
+
 function disable_bt_usb_ethernet {
 	backup_file Makefile
 	disable_usbnet
@@ -205,6 +209,7 @@ function enable_only_ethernet {
 	disable_usbnet
 	disable_var_03
 	disable_bt
+	disable_drm
 	# rfkill may be needed if you enable b44 as you may have b43
 	disable_rfkill
 	disable_80211
-- 
1.7.10.4
