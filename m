Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49092 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823Ab3JaWBa (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 31 Oct 2013 18:01:30 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] gentree.py: add v as prefix for stable folder name
Date: Thu, 31 Oct 2013 23:01:23 +0100
Message-Id: <1383256883-32241-1-git-send-email-hauke@hauke-m.de> (sfid-20131031_230131_485873_B8A71D00)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The folder name did not started with an v.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 gentree.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 25e6250..744f48d 100755
--- a/gentree.py
+++ b/gentree.py
@@ -348,7 +348,7 @@ def get_rel_prep(rel):
         if (rel_specs['RELMOD_TYPE'] != ''):
             ignore += rel_specs['RELMOD_TYPE']
         base_rel = rel.replace(ignore, "")
-        paths.append(base_rel)
+        paths.append("v" + base_rel)
         rel_tag = "v" + rel.replace(rel_specs['RELMOD_TYPE'], "")
 
     rel_prep = dict(stable = is_stable,
-- 
1.7.10.4

