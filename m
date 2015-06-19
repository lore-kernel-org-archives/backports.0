Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34596 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932547AbbFSVT1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jun 2015 17:19:27 -0400
Received: by pdbki1 with SMTP id ki1so98269762pdb.1
        for <backports@vger.kernel.org>; Fri, 19 Jun 2015 14:19:26 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] backports-update-manager: bump 4.1-rc1 to 4.1-rc8
Date: Fri, 19 Jun 2015 14:17:13 -0700
Message-Id: <1434748633-23279-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20150619_232000_720088_C2B139B2)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 devel/backports-update-manager | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 65ca9a3..1a85d7b 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -44,7 +44,7 @@ KERNEL_URLS = [
     KPATH + "v3.18.12-vivid/linux-headers-3.18.12-031812_3.18.12-031812.201504221338_all.deb",
     KPATH + "v3.19.5-vivid/linux-headers-3.19.5-031905_3.19.5-031905.201504211114_all.deb",
     KPATH + "v4.0-vivid/linux-headers-4.0.0-040000_4.0.0-040000.201504121935_all.deb",
-    KPATH + "v4.1-rc1-vivid/linux-headers-4.1.0-040100rc1_4.1.0-040100rc1.201504270235_all.deb"
+    KPATH + "v4.1-rc8-unstable/linux-headers-4.1.0-040100rc8_4.1.0-040100rc8.201506150335_all.deb"
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
2.3.2.209.gd67f9d5.dirty

--
To unsubscribe from this list: send the line "unsubscribe backports" in
