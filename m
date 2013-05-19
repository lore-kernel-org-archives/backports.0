Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:38309 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab3ESCeO (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 May 2013 22:34:14 -0400
Received: by mail-da0-f46.google.com with SMTP id e20so844435dak.5
        for <backports@vger.kernel.org>; Sat, 18 May 2013 19:34:13 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: mricon@kernel.org, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Felix Bitterli <ic.felix@gmail.com>
Subject: [PATCH 5/8] rel-html: fix next release URLs
Date: Sat, 18 May 2013 19:33:39 -0700
Message-Id: <1368930822-13641-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20130519_043415_654539_6765D8DA)
In-Reply-To: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

The tarball URL was completely missing.

Cc: Felix Bitterli <ic.felix@gmail.com>
Reported-by: Felix Bitterli <ic.felix@gmail.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 rel-html.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rel-html.py b/rel-html.py
index ef83833..c962006 100755
--- a/rel-html.py
+++ b/rel-html.py
@@ -408,7 +408,7 @@ class index_tarball_hunter(HTMLParser):
 		tar_next = dict(version=next_version,
 				weight = w,
 				rel = rel_name_next,
-				url = '',
+				url = self.base_url + '/' + tar_next,
 				specifics = rel_specifics,
 				base_url = self.base_url,
 				base_url_validated = False,
-- 
1.7.10.4

