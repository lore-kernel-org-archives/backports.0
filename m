Return-path: <backports-owner@vger.kernel.org>
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:63721
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754223AbeASICc (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 19 Jan 2018 03:02:32 -0500
Date: Fri, 19 Jan 2018 02:02:21 -0600
From: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Winnie Chang <winnie.chang@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH] backports: include linux/err.h in key.c
Message-ID: <20180119080215.GA102758@aremote07.aus.cypress.com> (sfid-20180119_090250_042216_85C253C3)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Winnie Chang <winnie.chang@cypress.com>

Function IS_ERR, PTR_ERR and ERR_PTR are not found. Need to include
linux/err.h to fix compiling errors.

Signed-off-by: Winnie Chang <winnie.chang@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 backport/compat/verification/key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/compat/verification/key.c b/backport/compat/verification/key.c
index 3a3c9bc..329f8b2 100644
--- a/backport/compat/verification/key.c
+++ b/backport/compat/verification/key.c
@@ -1,6 +1,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/key.h>
+#include <linux/err.h>
 #include <keys/asymmetric-type.h>
 #include "x509_parser.h"
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
