Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:45526 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab3G3J0K (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:26:10 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so44602pbc.16
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:26:09 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 01/14] backports: simplify space regexp for src_line
Date: Tue, 30 Jul 2013 02:25:46 -0700
Message-Id: <1375176359-1331-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_112611_749140_977CB7AD)
In-Reply-To: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

The regexp doesn't require the extra brackets.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/kconfig.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kconfig.py b/lib/kconfig.py
index 8a30ddc..179121a 100644
--- a/lib/kconfig.py
+++ b/lib/kconfig.py
@@ -4,7 +4,7 @@
 
 import os, re
 
-src_line = re.compile(r'^[\s]*source\s+"?(?P<src>[^\s"]*)"?\s*$')
+src_line = re.compile(r'^\s*source\s+"?(?P<src>[^\s"]*)"?\s*$')
 tri_line = re.compile(r'^(?P<spc>\s+)tristate')
 bool_line = re.compile(r'^(?P<spc>\s+)bool')
 cfg_line = re.compile(r'^(config|menuconfig)\s+(?P<sym>[^\s]*)')
-- 
1.7.10.4

