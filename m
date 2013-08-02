Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:32818 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab3HBLaM (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 2 Aug 2013 07:30:12 -0400
Message-ID: <51FB983E.2090901@fh-kl.de> (sfid-20130802_133014_603075_57238858)
Date: Fri, 2 Aug 2013 13:30:06 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [PATCH 8/9] backports: define phys_addr_t for ARM on kernel version
 < 2.6.25
References: <cover.1375442885.git.patrick.ziegler@fh-kl.de>
In-Reply-To: <cover.1375442885.git.patrick.ziegler@fh-kl.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

phys_addr_t is not defined on ARM systems if kernel version < 2.6.25.

Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/backport-include/linux/types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/linux/types.h b/backport/backport-include/linux/types.h
index 504a615..0aadc80 100644
--- a/backport/backport-include/linux/types.h
+++ b/backport/backport-include/linux/types.h
@@ -4,7 +4,7 @@
 #include <linux/version.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
-#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
+#if defined(CONFIG_X86) || defined(CONFIG_X86_64) || defined(CONFIG_ARM)
 
 #if defined(CONFIG_64BIT) || defined(CONFIG_X86_PAE) || defined(CONFIG_PHYS_64BIT)
 typedef u64 phys_addr_t;
@@ -12,7 +12,7 @@ typedef u64 phys_addr_t;
 typedef u32 phys_addr_t;
 #endif
 
-#endif /* x86 */
+#endif /* x86 || ARM */
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28) /* < 2.6.25 */
 
 #if defined(CONFIG_X86) || defined(CONFIG_X86_64) || defined(CONFIG_PPC)
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
