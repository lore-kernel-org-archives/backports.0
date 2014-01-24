Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:42149 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbaAXWrf (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 24 Jan 2014 17:47:35 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so3799300pad.11
        for <backports@vger.kernel.org>; Fri, 24 Jan 2014 14:47:35 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 02/11] rel-html: change default file extension to tar.xz
Date: Fri, 24 Jan 2014 14:47:07 -0800
Message-Id: <1390603636-27841-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20140124_234750_089799_24679604)
In-Reply-To: <1390603636-27841-1-git-send-email-mcgrof@do-not-panic.com>
References: <1390603636-27841-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The kernel.org server is now not dumping out tar.bz2 files
so embrace their practice for preference for relying on tar.xz
tarballs. You can always override the extension with the
release_extension attribute, see the project file for hostapd
projects/hostapd.cfg as an example.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 rel-html.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rel-html.py b/rel-html.py
index c563280..d787b92 100755
--- a/rel-html.py
+++ b/rel-html.py
@@ -764,7 +764,7 @@ class index_parser(HTMLParser):
             self.release_extension = "." + \
                 self.config.get("project", "release_extension")
         else:
-            self.release_extension = ".tar.bz2"
+            self.release_extension = ".tar.xz"
 
         self.next_rel_day = 0
         self.next_rel_month = 0
-- 
1.8.5.2

