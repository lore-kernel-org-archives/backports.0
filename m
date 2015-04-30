Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52581 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbbD3RKY (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 30 Apr 2015 13:10:24 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] rel-html: fix url for next signature.
Date: Thu, 30 Apr 2015 19:10:13 +0200
Message-Id: <1430413814-4817-1-git-send-email-hauke@hauke-m.de> (sfid-20150430_191026_892242_4AA71337)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The link to the signature of the next tarball was missing a slash.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 rel-html.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rel-html.py b/rel-html.py
index 0a48ea0..7977b4c 100755
--- a/rel-html.py
+++ b/rel-html.py
@@ -1185,7 +1185,7 @@ class rel_html_gen(HTMLParser):
                              (r.get('url'), r.get('rel')))
             if (not r.get('ignore_signature')):
                 sys.stdout.write('\t\t\t\t<td><a href="%s">signed</a></td>\n' %
-                                 (r.get('base_url') + r.get('signed_tarball')))
+                                 (r.get('base_url') + '/' + r.get('signed_tarball')))
             else:
                 sys.stdout.write('\t\t\t\t<td></td>\n')
             if (r.get('maintained')):
-- 
1.9.1

