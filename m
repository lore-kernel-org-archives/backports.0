Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:59514 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751335AbeBRNzo (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 18 Feb 2018 08:55:44 -0500
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Sun, 18 Feb 2018 15:24:54 +0200
Message-Id: <20180218132459.11011-6-luca@coelho.fi> (sfid-20180218_145545_390270_5C56D086)
In-Reply-To: <20180218132459.11011-1-luca@coelho.fi>
References: <20180218132459.11011-1-luca@coelho.fi>
Subject: [PATCH 05/10] backport: remove pkcs7_verify.c patch hunk
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The change that used to be patched into the pkcs7_verify.c file is now
part of newer kernels, so we don't need to patch it anymore.  Remove
this hunk from verify.patch accordingly.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 patches/verify.patch | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/patches/verify.patch b/patches/verify.patch
index 0fda8411e43a..442f2f622351 100644
--- a/patches/verify.patch
+++ b/patches/verify.patch
@@ -62,14 +62,3 @@
  struct x509_certificate {
  	struct x509_certificate *next;
  	struct x509_certificate *signer;	/* Certificate that signed this one */
---- a/compat/verification/pkcs7_verify.c
-+++ b/compat/verification/pkcs7_verify.c
-@@ -150,7 +150,7 @@
- 		pr_devel("Sig %u: Found cert serial match X.509[%u]\n",
- 			 sinfo->index, certix);
- 
--		if (x509->pub->pkey_algo != sinfo->sig->pkey_algo) {
-+		if (strcmp(x509->pub->pkey_algo, sinfo->sig->pkey_algo)) {
- 			pr_warn("Sig %u: X.509 algo and PKCS#7 sig algo don't match\n",
- 				sinfo->index);
- 			continue;
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
