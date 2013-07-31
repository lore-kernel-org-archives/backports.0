Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:51471 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759134Ab3GaIjh (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 31 Jul 2013 04:39:37 -0400
Message-ID: <51F8CD43.2060306@fh-kl.de> (sfid-20130731_103939_150376_FFC4AA8C)
Date: Wed, 31 Jul 2013 10:39:31 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [RFC v2 3/8] backports: define PM_EVENT_AUTO
References: <cover.1375259597.git.patrick.ziegler@fh-kl.de>
In-Reply-To: <cover.1375259597.git.patrick.ziegler@fh-kl.de>
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
