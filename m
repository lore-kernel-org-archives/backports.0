Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:50986 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727029AbeITRL4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:11:56 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:35 +0300
Message-Id: <20180920112842.27198-8-luca@coelho.fi> (sfid-20180920_132855_908835_A0FCB0E3)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 07/14] backport: remove duplicate leds.h inclusion from backport-4.5.c
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

We were including leds.h twice in backport-4.5.c and one of them was
very early, which caused inclusion conflicts at least with < 3.16
kernels.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/compat/backport-4.5.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/backport/compat/backport-4.5.c b/backport/compat/backport-4.5.c
index 69751d515234..13764dc76cd4 100644
--- a/backport/compat/backport-4.5.c
+++ b/backport/compat/backport-4.5.c
@@ -8,7 +8,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/leds.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/errno.h>
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
