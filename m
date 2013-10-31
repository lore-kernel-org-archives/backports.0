Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49073 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823Ab3JaWAt (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 31 Oct 2013 18:00:49 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] genlib: add missing slash to korg_path for stable
Date: Thu, 31 Oct 2013 23:00:42 +0100
Message-Id: <1383256842-32180-1-git-send-email-hauke@hauke-m.de> (sfid-20131031_230050_816793_D3309E5B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Without this slash it wants to use the directory /backportsstable/

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 gentree.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index bc446d4..25e6250 100755
--- a/gentree.py
+++ b/gentree.py
@@ -400,7 +400,7 @@ def upload_release(args, rel_prep, logwrite=lambda x:None):
     korg_path = "/pub/linux/kernel/projects/backports"
 
     if (rel_prep['stable']):
-        korg_path += "stable"
+        korg_path += "/stable"
 
     parent = os.path.dirname(args.outdir)
     release = os.path.basename(args.outdir)
-- 
1.7.10.4

