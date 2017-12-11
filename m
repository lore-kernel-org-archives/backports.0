Return-path: <backports-owner@vger.kernel.org>
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:27376
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750836AbdLKIVY (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 11 Dec 2017 03:21:24 -0500
Date: Mon, 11 Dec 2017 02:21:14 -0600
From: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To: backports@vger.kernel.org
Subject: [PATCH] backports: clean up kconf/conf when doing make mrproper
Message-ID: <20171211082109.GA156729@aremote07.aus.cypress.com> (sfid-20171211_092126_763745_C0635476)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

kconf/ is built during "make defconfig-*" but not cleaned up during
"make mrproper" or "make clean". Add the clean up work to "make clean".

Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 backport/Makefile.real | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/Makefile.real b/backport/Makefile.real
index c874d31..6550802 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -118,3 +118,4 @@ uninstall:
 .PHONY: clean
 clean:
 	@$(MAKE) -f Makefile.build clean
+	@$(MAKE) -C kconf clean
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
