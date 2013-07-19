Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50581 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab3GSWQJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 18:16:09 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so4890900pad.5
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 15:16:09 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: jani.nikula@intel.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 10/10] backports: lib/kconfig.py - fix src line regexp
Date: Fri, 19 Jul 2013 15:13:29 -0700
Message-Id: <1374272009-26152-11-git-send-email-mcgrof@do-not-panic.com> (sfid-20130720_001611_669391_8F766FF3)
In-Reply-To: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

The source line can be prefixed by spaces and tabs. Without
this a slew of kconfig options were not being parsed for
dependency checking and at compile time they'd obviously
fail.

Tested with ckmake against next-20130627

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.79              [  OK  ]
18  3.1.10              [  OK  ]
19  3.10-rc1            [  OK  ]
20  3.2.45              [  OK  ]
21  3.3.8               [  OK  ]
22  3.4.46              [  OK  ]
23  3.5.7               [  OK  ]
24  3.6.11              [  OK  ]
25  3.7.10              [  OK  ]
26  3.8.13              [  OK  ]
27  3.9.3               [  OK  ]

real    34m5.379s
user    921m5.112s
sys     128m8.156s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/kconfig.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kconfig.py b/lib/kconfig.py
index 880d7c3..8a30ddc 100644
--- a/lib/kconfig.py
+++ b/lib/kconfig.py
@@ -4,7 +4,7 @@
 
 import os, re
 
-src_line = re.compile(r'^source\s+"?(?P<src>[^\s"]*)"?\s*$')
+src_line = re.compile(r'^[\s]*source\s+"?(?P<src>[^\s"]*)"?\s*$')
 tri_line = re.compile(r'^(?P<spc>\s+)tristate')
 bool_line = re.compile(r'^(?P<spc>\s+)bool')
 cfg_line = re.compile(r'^(config|menuconfig)\s+(?P<sym>[^\s]*)')
-- 
1.7.10.4

