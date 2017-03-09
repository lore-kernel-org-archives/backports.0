Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:43454 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932342AbdCINFi (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 9 Mar 2017 08:05:38 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 1/4] patches: update crypto-ccm.patch for v4.11-rc1
Date: Thu,  9 Mar 2017 12:57:30 +0000
Message-Id: <1489064253-3652-2-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170309_140610_645275_5055B3F1)
In-Reply-To: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Since v4.11-rc1 the patch file for crypto/ccm.c, which is incorporated
in the compat module, no longer applies. Update the patch file to fix
the issue.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 patches/crypto-ccm.patch | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/patches/crypto-ccm.patch b/patches/crypto-ccm.patch
index 8bdea3d..7a44d37 100644
--- a/patches/crypto-ccm.patch
+++ b/patches/crypto-ccm.patch
@@ -1,7 +1,7 @@
 --- a/compat/crypto-ccm.c
 +++ b/compat/crypto-ccm.c
-@@ -13,13 +13,44 @@
- #include <crypto/internal/aead.h>
+@@ -14,13 +14,44 @@
+ #include <crypto/internal/hash.h>
  #include <crypto/internal/skcipher.h>
  #include <crypto/scatterwalk.h>
 +#include <crypto/algapi.h>
@@ -46,7 +46,7 @@
  
  struct ccm_instance_ctx {
  	struct crypto_skcipher_spawn ctr;
-@@ -897,7 +928,7 @@ static struct crypto_template crypto_rfc
+@@ -1001,7 +1032,7 @@ static int cbcmac_create(struct crypto_template *tmpl, struct rtattr **tb)
  	.module = THIS_MODULE,
  };
  
@@ -55,7 +55,7 @@
  {
  	int err;
  
-@@ -923,18 +954,9 @@ out_undo_base:
+@@ -1033,19 +1064,10 @@ static int __init crypto_ccm_module_init(void)
  	goto out;
  }
  
@@ -65,6 +65,7 @@
  	crypto_unregister_template(&crypto_rfc4309_tmpl);
  	crypto_unregister_template(&crypto_ccm_tmpl);
  	crypto_unregister_template(&crypto_ccm_base_tmpl);
+ 	crypto_unregister_template(&crypto_cbcmac_tmpl);
  }
 -
 -module_init(crypto_ccm_module_init);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
