Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:59512 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751335AbeBRNzm (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 18 Feb 2018 08:55:42 -0500
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Sun, 18 Feb 2018 15:24:58 +0200
Message-Id: <20180218132459.11011-10-luca@coelho.fi> (sfid-20180218_145544_524148_787AD41A)
In-Reply-To: <20180218132459.11011-1-luca@coelho.fi>
References: <20180218132459.11011-1-luca@coelho.fi>
Subject: [PATCH 09/10] backport: increase max stack frame size compiler check to 1280
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The verification code has some large data variables that are allocated
in the stack.  Increase the maximum stack frame size in the compiler
check slightly (from 1024 to 1280) to prevent harmless warnings.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/compat/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 5c79b9b849cb..ac70aaf82fcc 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -1,4 +1,4 @@
-ccflags-y += -I$(src)
+ccflags-y += -I$(src) -Wframe-larger-than=1280
 ifeq ($(CONFIG_BACKPORT_INTEGRATE),)
 obj-m += compat.o
 else
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
