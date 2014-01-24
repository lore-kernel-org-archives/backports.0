Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:59496 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbaAXWru (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 24 Jan 2014 17:47:50 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so3639290pdj.29
        for <backports@vger.kernel.org>; Fri, 24 Jan 2014 14:47:50 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 05/11] rel-html: use system's date to determine current year
Date: Fri, 24 Jan 2014 14:47:10 -0800
Message-Id: <1390603636-27841-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20140124_234753_335667_BB156147)
In-Reply-To: <1390603636-27841-1-git-send-email-mcgrof@do-not-panic.com>
References: <1390603636-27841-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used for the software that does snapshot / next type of
releases based on dates.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 rel-html.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rel-html.py b/rel-html.py
index d787b92..ae61187 100755
--- a/rel-html.py
+++ b/rel-html.py
@@ -3,7 +3,7 @@
 # Provided an index URL and a few project hints page this
 # will spit out a shiny HTML 5 W3C compliant releases page.
 
-# Copyright (C) 2012-2013 Luis R. Rodriguez <mcgrof@do-not-panic.com>
+# Copyright (C) 2012-2014 Luis R. Rodriguez <mcgrof@do-not-panic.com>
 #
 # This program is free software: you can redistribute it and/or modify
 # it under the terms of the GNU Affero General Public License as
@@ -27,13 +27,14 @@ import sys
 import os
 import getopt
 from operator import itemgetter
+from datetime import date
 
 debug = 0
 
 
 def rel_html_license_verbose():
     print '-----------------------------------------------------------------------'
-    print 'Copyright (C) 2012-2013 Luis R. Rodriguez <mcgrof@do-not-panic.com>'
+    print 'Copyright (C) 2012-2014 Luis R. Rodriguez <mcgrof@do-not-panic.com>'
     print ''
     print 'This program is free software: you can redistribute it and/or modify'
     print 'it under the terms of the GNU Affero General Public License as'
@@ -859,8 +860,7 @@ class index_parser(HTMLParser):
             url + self.next_rel_month)
         self.next_rel_url   = url + \
             self.next_rel_month + '/' + self.next_rel_day
-        # XXX: automatically look for the largest year
-        self.next_rel_date_rfc3339  = '2013' + '-' + \
+        self.next_rel_date_rfc3339  = str(date.today().year) + '-' + \
             self.next_rel_month + '-' + self.next_rel_day
         self.next_rel_date = self.next_rel_date_rfc3339.replace("-", "")
         self.next_rel_dates.append(self.next_rel_date_rfc3339)
@@ -884,7 +884,7 @@ class index_parser(HTMLParser):
             if url.endswith('stable/'):
                 self.get_stable_ext_urls(url)
                 self.evaluate_stable_ext_urls()
-            elif url.endswith('2013/'):
+            elif url.endswith(str(date.today().year) + '/'):
                 self.get_next_url(url)
                 self.evaluate_next_url()
             else:
-- 
1.8.5.2

