Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:47025 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbcDSVvC (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 19 Apr 2016 17:51:02 -0400
Received: from [192.168.178.24] (p4FFCCF1D.dip0.t-ipconnect.de [79.252.207.29])
	by hauke-m.de (Postfix) with ESMTPSA id 5DD94100163
	for <backports@vger.kernel.org>; Tue, 19 Apr 2016 23:50:57 +0200 (CEST)
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: Bluetooth skcipher backport
Message-ID: <5716A840.6060903@hauke-m.de> (sfid-20160419_235106_184162_5A0A0218)
Date: Tue, 19 Apr 2016 23:50:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

I looked at backports and saw that bluetooth now uses skcipher. I get
the following compile error. Does someone want to look into it or
already has a patch for it?

This is caused by this changeset:

commit 71af2f6bb22a4bf42663e10f1d8913d4967ed07f
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sun Jan 24 21:18:30 2016 +0800

Bluetooth: Use skcipher and hash



  CC [M]
/home/hauke/compat-wireless/tmp/drivers/media/dvb-frontends/tda10021.o
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c: In function ‘smp_e’:
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:366:2: error:
implicit declaration of function ‘SKCIPHER_REQUEST_ON_STACK’
[-Werror=implicit-function-declaration]
  SKCIPHER_REQUEST_ON_STACK(req, tfm);
  ^
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:366:28: error: ‘req’
undeclared (first use in this function)
  SKCIPHER_REQUEST_ON_STACK(req, tfm);
                            ^
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:366:28: note: each
undeclared identifier is reported only once for each function it appears in
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:367:2: warning: ISO
C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
  struct scatterlist sg;
  ^
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:381:8: error:
implicit declaration of function ‘crypto_skcipher_setkey’
[-Werror=implicit-function-declaration]
  err = crypto_skcipher_setkey(tfm, tmp, 16);
        ^
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:392:2: error:
implicit declaration of function ‘skcipher_request_set_tfm’
[-Werror=implicit-function-declaration]
  skcipher_request_set_tfm(req, tfm);
  ^
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:393:2: error:
implicit declaration of function ‘skcipher_request_set_callback’
[-Werror=implicit-function-declaration]
  skcipher_request_set_callback(req, 0, NULL, NULL);
  ^
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:394:2: error:
implicit declaration of function ‘skcipher_request_set_crypt’
[-Werror=implicit-function-declaration]
  skcipher_request_set_crypt(req, &sg, &sg, 16, NULL);
  ^
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:396:8: error:
implicit declaration of function ‘crypto_skcipher_encrypt’
[-Werror=implicit-function-declaration]
  err = crypto_skcipher_encrypt(req);
        ^
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:397:2: error:
implicit declaration of function ‘skcipher_request_zero’
[-Werror=implicit-function-declaration]
  skcipher_request_zero(req);
  ^
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c: In function
‘smp_chan_destroy’:
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:767:2: error:
implicit declaration of function ‘crypto_free_skcipher’
[-Werror=implicit-function-declaration]
  crypto_free_skcipher(smp->tfm_aes);
  ^
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c: In function
‘smp_chan_create’:
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:1367:17: error:
implicit declaration of function ‘crypto_alloc_skcipher’
[-Werror=implicit-function-declaration]
  smp->tfm_aes = crypto_alloc_skcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
                 ^
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:1367:15: warning:
assignment makes pointer from integer without a cast [-Wint-conversion]
  smp->tfm_aes = crypto_alloc_skcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
               ^
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c: In function
‘smp_add_cid’:
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:3146:10: warning:
assignment makes pointer from integer without a cast [-Wint-conversion]
  tfm_aes = crypto_alloc_skcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
          ^
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c: In function
‘bt_selftest_smp’:
/home/hauke/compat-wireless/tmp/net/bluetooth/smp.c:3782:10: warning:
assignment makes pointer from integer without a cast [-Wint-conversion]
  tfm_aes = crypto_alloc_skcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
          ^
cc1: some warnings being treated as errors
scripts/Makefile.build:258: recipe for target
'/home/hauke/compat-wireless/tmp/net/bluetooth/smp.o' failed
make[6]: *** [/home/hauke/compat-wireless/tmp/net/bluetooth/smp.o] Error 1
scripts/Makefile.build:403: recipe for target
'/home/hauke/compat-wireless/tmp/net/bluetooth' failed
make[5]: *** [/home/hauke/compat-wireless/tmp/net/bluetooth] Error 2



--
To unsubscribe from this list: send the line "unsubscribe backports" in
