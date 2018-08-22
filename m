Return-path: <backports-owner@vger.kernel.org>
Received: from mail-bl2nam02on0105.outbound.protection.outlook.com ([104.47.38.105]:49231
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726469AbeHVG3N (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 22 Aug 2018 02:29:13 -0400
Date: Tue, 21 Aug 2018 22:06:05 -0500
From: Winnie Chang <winnie.chang@cypress.com>
To: backports@vger.kernel.org
Cc: Chi-Hsien.Lin@cypress.com
Subject: [PATCH v2] backports: add header file for function memcmp
Message-ID: <20180822030554.GA73398@aremote01.aus.cypress.com> (sfid-20180822_050625_036935_A42BDE44)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Function memcmp is implicit declaration on kernel 4.9.88 ARM platform.
backport-include/keys/asymmetric-type.h uses function memcmp but its
caller compat/verification/verify.c and all its related header files
do not include string.h. The header file is usually included from
arch/arm/include/asm, but in this configuration, it doesn't. We need
to be safe and insure string.h is there.

Signed-off-by: Winnie Chang <winnie.chang@cypress.com>
---
 backport/backport-include/keys/asymmetric-type.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/keys/asymmetric-type.h b/backport/backport-include/keys/asymmetric-type.h
index ee9c418..5744de9 100644
--- a/backport/backport-include/keys/asymmetric-type.h
+++ b/backport/backport-include/keys/asymmetric-type.h
@@ -2,6 +2,8 @@
 #define __BP_ASYMMETRIC_TYPE_H
 #ifdef CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION
 
+#include <linux/string.h>
+
 struct asymmetric_key_id {
 	unsigned short	len;
 	unsigned char	data[];
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
