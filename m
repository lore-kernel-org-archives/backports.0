Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:49199 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab3G1BQm (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 27 Jul 2013 21:16:42 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so4609733pab.10
        for <backports@vger.kernel.org>; Sat, 27 Jul 2013 18:16:42 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 1/9] backports: simplify space regexp for src_line
Date: Sat, 27 Jul 2013 18:16:22 -0700
Message-Id: <1374974190-31561-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130728_031644_143134_4143AC5D)
In-Reply-To: <1374974190-31561-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374974190-31561-1-git-send-email-mcgrof@do-not-panic.com>
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

