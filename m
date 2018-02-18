Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:59526 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751335AbeBRNzs (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 18 Feb 2018 08:55:48 -0500
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Sun, 18 Feb 2018 15:24:57 +0200
Message-Id: <20180218132459.11011-9-luca@coelho.fi> (sfid-20180218_145550_844968_653115B8)
In-Reply-To: <20180218132459.11011-1-luca@coelho.fi>
References: <20180218132459.11011-1-luca@coelho.fi>
Subject: [PATCH 08/10] backport: remove stddef.h inclusions
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The verification code was copied from userspace code which includes
stddef.h.  In the kernel, this header should not be included, so
remove those cases.

Fixes: 988e2af4b7a0 ("backports: add signature verification code")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/compat/verification/mbedtls/asn1.h | 2 --
 backport/compat/verification/mbedtls/md.h   | 2 --
 backport/compat/verification/mbedtls/oid.h  | 2 --
 3 files changed, 6 deletions(-)

diff --git a/backport/compat/verification/mbedtls/asn1.h b/backport/compat/verification/mbedtls/asn1.h
index bc6b48b8d9ce..46eb214be942 100644
--- a/backport/compat/verification/mbedtls/asn1.h
+++ b/backport/compat/verification/mbedtls/asn1.h
@@ -31,8 +31,6 @@
 #include MBEDTLS_CONFIG_FILE
 #endif
 
-#include <stddef.h>
-
 #if defined(MBEDTLS_BIGNUM_C)
 #include "bignum.h"
 #endif
diff --git a/backport/compat/verification/mbedtls/md.h b/backport/compat/verification/mbedtls/md.h
index 9385116c14e5..5342e4f54f59 100644
--- a/backport/compat/verification/mbedtls/md.h
+++ b/backport/compat/verification/mbedtls/md.h
@@ -27,8 +27,6 @@
 #ifndef MBEDTLS_MD_H
 #define MBEDTLS_MD_H
 
-#include <stddef.h>
-
 #define MBEDTLS_ERR_MD_FEATURE_UNAVAILABLE                -0x5080  /**< The selected feature is not available. */
 #define MBEDTLS_ERR_MD_BAD_INPUT_DATA                     -0x5100  /**< Bad input parameters to function. */
 #define MBEDTLS_ERR_MD_ALLOC_FAILED                       -0x5180  /**< Failed to allocate memory. */
diff --git a/backport/compat/verification/mbedtls/oid.h b/backport/compat/verification/mbedtls/oid.h
index 117ee47567bf..b2ff08879aea 100644
--- a/backport/compat/verification/mbedtls/oid.h
+++ b/backport/compat/verification/mbedtls/oid.h
@@ -34,8 +34,6 @@
 #include "asn1.h"
 #include "pk.h"
 
-#include <stddef.h>
-
 #if defined(MBEDTLS_CIPHER_C)
 #include "cipher.h"
 #endif
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
