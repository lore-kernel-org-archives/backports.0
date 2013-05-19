Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:45984 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769Ab3ESCeG (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 May 2013 22:34:06 -0400
Received: by mail-pb0-f50.google.com with SMTP id wy17so1436647pbc.37
        for <backports@vger.kernel.org>; Sat, 18 May 2013 19:34:05 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: mricon@kernel.org, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 3/8] rel-html: really listen to ignore_changelogs
Date: Sat, 18 May 2013 19:33:37 -0700
Message-Id: <1368930822-13641-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130519_043407_937163_7AB0E6F2)
In-Reply-To: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

When a project was setting ignore_changelogs the changelog
was still printed if and only if the changelog happened
to be found by chance and it was also signed. In practice
if a project wants to abandon changelogs this would then
produce an output that would likely make users think the
developers forgot to provide a changelog. Simply ignore
changelogs even if they are found for older releases when
ignore_changelogs is set.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 rel-html.py |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/rel-html.py b/rel-html.py
index 068d855..f50fa6f 100755
--- a/rel-html.py
+++ b/rel-html.py
@@ -1008,14 +1008,7 @@ class rel_html_gen(HTMLParser):
 				sys.stdout.write('\t\t\t\t<td><a href="%s">%s</a></td>\n' % \
 						 (r.get('changelog_url'), "ChangeLog"))
 			else:
-				if (r.get('changelog_exists')):
-					if (r['signed_changelog_exists']):
-						sys.stdout.write('\t\t\t\t<td><a href="%s">%s</a></td>\n' % \
-								 (r.get('changelog_url'), "ChangeLog"))
-					else:
-						sys.stdout.write('\t\t\t\t<td></td>\n')
-				else:
-					sys.stdout.write('\t\t\t\t<td></td>\n')
+				sys.stdout.write('\t\t\t\t<td></td>\n')
 			sys.stdout.write('\t\t\t\t</tr>')
 
 		sys.stdout.write('\t\t\t</table>\n')
@@ -1053,14 +1046,7 @@ class rel_html_gen(HTMLParser):
 				sys.stdout.write('\t\t\t\t<td><a href="%s">%s</a></td>\n' % \
 						 (r.get('changelog_url'), "ChangeLog"))
 			else:
-				if (r.get('changelog_exists')):
-					if (r['signed_changelog_exists']):
-						sys.stdout.write('\t\t\t\t<td><a href="%s">%s</a></td>\n' % \
-								 (r.get('changelog_url'), "ChangeLog"))
-					else:
-						sys.stdout.write('\t\t\t\t<td></td>\n')
-				else:
-					sys.stdout.write('\t\t\t\t<td></td>\n')
+				sys.stdout.write('\t\t\t\t<td></td>\n')
 			sys.stdout.write('\t\t\t\t</tr>')
 
 		sys.stdout.write('\t\t\t</table>\n')
-- 
1.7.10.4

