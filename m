Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34619 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbcILJRz (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 12 Sep 2016 05:17:55 -0400
Received: by mail-pa0-f46.google.com with SMTP id to9so49138886pac.1
        for <backports@vger.kernel.org>; Mon, 12 Sep 2016 02:17:55 -0700 (PDT)
Subject: Re: [PATCH] gentree: create Kconfig.local, use it to restrict compat
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
References: <1472493101-6058-1-git-send-email-johannes@sipsolutions.net>
Cc: Jouni Malinen <j@w1.fi>, Johannes Berg <johannes.berg@intel.com>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <4d5c9281-7f15-37ec-d0f7-099cc9a12f53@broadcom.com> (sfid-20160912_111812_391584_15C26800)
Date: Mon, 12 Sep 2016 11:17:47 +0200
MIME-Version: 1.0
In-Reply-To: <1472493101-6058-1-git-send-email-johannes@sipsolutions.net>
Content-Type: multipart/mixed;
 boundary="------------20DF901D04546C1BDCA104A2"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a multi-part message in MIME format.
--------------20DF901D04546C1BDCA104A2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 29-8-2016 19:51, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Not all the compat code is always necessary, for example code
> enabled by BPAUTO_CRYPTO_SKCIPHER and by BPAUTO_RHASHTABLE is
> gated on other symbols being selected. Checking against the
> Kconfig symbols as it's done right now is wrong though, since
> the base kernel's Kconfig symbols would be used, selecting,
> for example, BPAUTO_CRYPTO_SKCIPHER when the base kernel has
> CONFIG_BT set, but doing that when BT isn't even part of the
> backport, or when it's disabled in the backport.

Excellent. Thanks for this. I have been spending some time on fixing
that skcipher stuff (attached) although the stuff in my selective
backport does not need it.

Regards,
Arend

--------------20DF901D04546C1BDCA104A2
Content-Type: text/plain; charset=UTF-8;
 name="0001-backports-patches-update-the-crypto-skcipher-patch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-backports-patches-update-the-crypto-skcipher-patch.patc";
 filename*1="h"

>From 3f3cdff75e845d1b0cf0af06efb2b0ad56e486d9 Mon Sep 17 00:00:00 2001
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Date: Wed, 24 Aug 2016 10:07:17 +0100
Subject: [PATCH] backports: patches: update the crypto-skcipher patch

The upstream code in crypto/skcipher.c has been changed. Although
the crypto-skcipher.patch still applies it results in some undefined
functions. This patch adds those or the needed function prototypes.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 patches/backport-adjustments/crypto-skcipher.patch | 104 ++++++++++++++++++++-
 1 file changed, 101 insertions(+), 3 deletions(-)

diff --git a/patches/backport-adjustments/crypto-skcipher.patch b/patches/backport-adjustments/crypto-skcipher.patch
index c7584c6..61be77a 100644
--- a/patches/backport-adjustments/crypto-skcipher.patch
+++ b/patches/backport-adjustments/crypto-skcipher.patch
@@ -1,10 +1,91 @@
 --- a/compat/crypto-skcipher.c
 +++ b/compat/crypto-skcipher.c
-@@ -18,7 +18,28 @@
- #include <linux/bug.h>
- #include <linux/module.h>
+@@ -22,7 +22,109 @@
+ #include <linux/seq_file.h>
+ #include <net/netlink.h>
  
 -#include "internal.h"
++#define CRYPTO_ALG_TYPE_SKCIPHER	0x00000005
++
++struct skcipher_alg {
++        int (*setkey)(struct crypto_skcipher *tfm, const u8 *key,
++                      unsigned int keylen);
++        int (*encrypt)(struct skcipher_request *req);
++        int (*decrypt)(struct skcipher_request *req);
++        int (*init)(struct crypto_skcipher *tfm);
++        void (*exit)(struct crypto_skcipher *tfm);
++
++        unsigned int min_keysize;
++        unsigned int max_keysize;
++        unsigned int ivsize;
++        unsigned int chunksize;
++
++        struct crypto_alg base;
++};
++
++struct crypto_alg *crypto_find_alg(const char *alg_name,
++                                   const struct crypto_type *frontend,
++                                   u32 type, u32 mask);
++
++struct skcipher_instance {
++        void (*free)(struct skcipher_instance *inst);
++        union {
++                struct {
++                        char head[offsetof(struct skcipher_alg, base)];
++                        struct crypto_instance base;
++                } s;
++                struct skcipher_alg alg;
++        };
++};
++
++static inline struct skcipher_alg *crypto_skcipher_alg(
++        struct crypto_skcipher *tfm)
++{
++        return container_of(crypto_skcipher_tfm(tfm)->__crt_alg,
++                            struct skcipher_alg, base);
++}
++
++static inline struct crypto_instance *skcipher_crypto_instance(
++        struct skcipher_instance *inst)
++{
++        return &inst->s.base;
++}
++
++static unsigned int crypto_alg_extsize(struct crypto_alg *alg)
++{
++        return alg->cra_ctxsize +
++               (alg->cra_alignmask & ~(crypto_tfm_ctx_alignment() - 1));
++}
++
++static int crypto_grab_spawn(struct crypto_spawn *spawn, const char *name,
++			      u32 type, u32 mask)
++{
++        struct crypto_alg *alg;
++        int err;
++
++        alg = crypto_find_alg(name, spawn->frontend, type, mask);
++        if (IS_ERR(alg))
++                return PTR_ERR(alg);
++
++        err = crypto_init_spawn(spawn, alg, spawn->inst, mask);
++        crypto_mod_put(alg);
++        return err;
++}
++
++static int crypto_type_has_alg(const char *name, const struct crypto_type *fe,
++				u32 type, u32 mask)
++{
++        int ret = 0;
++        struct crypto_alg *alg = crypto_find_alg(name, fe, type, mask);
++
++        if (!IS_ERR(alg)) {
++                crypto_mod_put(alg);
++                ret = 1;
++        }
++
++        return ret;
++}
++
 +struct crypto_tfm *__crypto_alloc_tfm(struct crypto_alg *alg, u32 type,
 +				      u32 mask);
 +
@@ -30,3 +111,20 @@
  
  static unsigned int crypto_skcipher_extsize(struct crypto_alg *alg)
  {
+@@ -257,6 +359,8 @@
+ }
+
+ static void crypto_skcipher_free_instance(struct crypto_instance *inst)
++	__attribute__((unused));
++static void crypto_skcipher_free_instance(struct crypto_instance *inst)
+ {
+	struct skcipher_instance *skcipher =
+		container_of(inst, struct skcipher_instance, s.base);
+@@ -314,7 +418,6 @@
+ static const struct crypto_type crypto_skcipher_type2 = {
+	.extsize = crypto_skcipher_extsize,
+	.init_tfm = crypto_skcipher_init_tfm,
+-	.free = crypto_skcipher_free_instance,
+ #ifdef CONFIG_PROC_FS
+	.show = crypto_skcipher_show,
+ #endif
-- 
1.9.1


--------------20DF901D04546C1BDCA104A2--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
