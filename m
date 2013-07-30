Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:37069 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275Ab3G3MBJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 30 Jul 2013 08:01:09 -0400
Message-ID: <51F7A889.2000500@fh-kl.de> (sfid-20130730_140114_321477_D93D2FD8)
Date: Tue, 30 Jul 2013 13:50:33 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [RFC 3/8] backports: define PM_EVENT_AUTO
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
