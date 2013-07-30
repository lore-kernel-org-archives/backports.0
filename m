Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:37068 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094Ab3G3MBJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 30 Jul 2013 08:01:09 -0400
Message-ID: <51F7A89F.7080807@fh-kl.de> (sfid-20130730_140112_481254_75EA6AB1)
Date: Tue, 30 Jul 2013 13:50:55 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [RFC 6/8] backports: include headers directly if math64 header is
 missing
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

If math64 header is not available, include div64.h directly. It is required for
do_div() that is used inside the backport version of math64.h.

Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/backport-include/linux/math64.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/backport/backport-include/linux/math64.h b/backport/backport-include/linux/math64.h
index 7f3a81b..775c2d3 100644
--- a/backport/backport-include/linux/math64.h
+++ b/backport/backport-include/linux/math64.h
@@ -5,6 +5,9 @@
 
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25))
 #include_next <linux/math64.h>
+#else
+#include <linux/types.h>
+#include <asm/div64.h>
 #endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
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
