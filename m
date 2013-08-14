Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:55807 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759447Ab3HNISA (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 14 Aug 2013 04:18:00 -0400
Message-ID: <520B3D32.3010307@fh-kl.de> (sfid-20130814_101801_567693_2D71A498)
Date: Wed, 14 Aug 2013 10:17:54 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [PATCH v2 3/9] backports: define PM_EVENT_AUTO
References: <cover.1376467862.git.patrick.ziegler@fh-kl.de>
In-Reply-To: <cover.1376467862.git.patrick.ziegler@fh-kl.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This macro is missing for < 2.6.25

Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/backport-include/linux/pm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/pm.h b/backport/backport-include/linux/pm.h
index 70f3a21..d217c81 100644
--- a/backport/backport-include/linux/pm.h
+++ b/backport/backport-include/linux/pm.h
@@ -2,6 +2,10 @@
 #define __BACKPORT_PM_H
 #include_next <linux/pm.h>
 
+#ifndef PM_EVENT_AUTO
+#define PM_EVENT_AUTO		0x0400
+#endif
+
 #ifndef PM_EVENT_SLEEP
 #define PM_EVENT_SLEEP  (PM_EVENT_SUSPEND)
 #endif
-- 
1.8.1.2



-- 
Dipl.-Inf. (FH) Patrick Ziegler

University Of Applied Sciences
Kaiserslautern

Amerikastrasse 1
D-66482 Zweibruecken
Germany

Phone:  +49 631 3724 5526
Mail:   patrick.ziegler@fh-kl.de
PGP KeyID 0xB4796B8C

http://www.fh-kl.de
http://www.fh-kl.de/fachbereiche/imst/iuk-knowhow.html
