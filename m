Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:48024 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab3EaAGD (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 30 May 2013 20:06:03 -0400
Received: by mail-pb0-f53.google.com with SMTP id un4so1229149pbc.40
        for <backports@vger.kernel.org>; Thu, 30 May 2013 17:06:01 -0700 (PDT)
From: Anoop Karollil <anoop.karollil@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org,
	Anoop Karollil <anoop.karollil@gmail.com>
Subject: [PATCH] backports: fix firmware install for old udev on Ubuntu
Date: Thu, 30 May 2013 17:05:18 -0700
Message-Id: <1369958718-18711-1-git-send-email-anoop.karollil@gmail.com> (sfid-20130531_020605_177187_0CCEEE5A)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Rules for older versions of udev (e.g. version 113-0ubuntu16 on Ubuntu 7.10) are
looked for in /etc/udev/rules.d. For later versions, they are looked for in
either the default /lib/udev/rules.d location or the custom /etc/udev/rules.d
location. For backwards compatibility with older udev, the rules should be
installed in /etc/udev/rules.d.

Signed-off-by: Anoop Karollil <anoop.karollil@gmail.com>
---
 backport/scripts/backport_firmware_install.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/scripts/backport_firmware_install.sh b/backport/scripts/backport_firmware_install.sh
index e4b9fb0..5a82947 100755
--- a/backport/scripts/backport_firmware_install.sh
+++ b/backport/scripts/backport_firmware_install.sh
@@ -8,9 +8,9 @@ fi
 
 case $LSB_RED_ID in
 "Ubuntu")
-	mkdir -p /lib/udev/ /lib/udev/rules.d/
+	mkdir -p /lib/udev/ /etc/udev/rules.d/
 	cp udev/ubuntu/compat_firmware.sh /lib/udev/
-	cp udev/50-compat_firmware.rules /lib/udev/rules.d/
+	cp udev/50-compat_firmware.rules /etc/udev/rules.d/
         ;;
 *)
 	mkdir -p /lib/udev/ /lib/udev/rules.d/
-- 
1.8.1.2

