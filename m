Return-Path: <SRS0=FSCw=RQ=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4389FC43381
	for <backports@archiver.kernel.org>; Wed, 13 Mar 2019 09:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0588D2147C
	for <backports@archiver.kernel.org>; Wed, 13 Mar 2019 09:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="akgVJker"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfCMJFr (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:05:47 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:51148 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbfCMJFr (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 13 Mar 2019 05:05:47 -0400
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Mar 2019 05:05:46 EDT
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 33A4830C020;
        Wed, 13 Mar 2019 01:57:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 33A4830C020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1552467459;
        bh=N7czKOZFdjZ7xFFvn7lxAXOKdBBcoOLWmcA/Yok5aqg=;
        h=From:To:Cc:Subject:Date:From;
        b=akgVJkermPk0AdEtb76HneP+jwQuQ4s+pMNJvp7CnsRYGAKx1pvRWSfJ+u7YmEZz3
         rrNSmaNC2QluoOAgs4lIIsEHAV6KmXkyziQjd0UU12SX8icYkPdkaU6Ool4jGVRqhU
         XmMbdfeW7E7PJc270TUPMp2enho/x5Cl3jWPa4IU=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 11D3381EBF;
        Wed, 13 Mar 2019 01:57:49 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id C9176B02A66; Wed, 13 Mar 2019 09:57:47 +0100 (CET)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     backports@vger.kernel.org
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] backport-include: add newly introduced macros in cordic.h
Date:   Wed, 13 Mar 2019 09:57:40 +0100
Message-Id: <1552467460-10165-1-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The kernel header file linux/cordic.h changed in v5.0 kernel
resulting in backport build to fail for brcmsmac (and probably
b43 as well). So backport those definitions for older kernels.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
Hi,

It has been a while since I submitted or did anything with the backports
repo. I was using it on Ubuntu 14.04 and had a problem building coccinelle
v1.0.7. I finally fixed that so I wanted to share here what was going on so
it may help others.

So while building coccinelle it failed with following:

make[1]: Entering directory `/projects/hnd_software_nl/work/arend/utils/coccinelle-1.0.7/bundles/parmap'
/usr/bin/ocamlc.opt -unsafe -I parmap   -c parmap/bytearray.ml -o parmap/bytearray.cmo
File "parmap/bytearray.ml", line 1:
Error: Could not find the .cmi file for interface parmap/bytearray.mli.
make[1]: *** [parmap/bytearray.cmo] Error 2
make[1]: Leaving directory `/projects/hnd_software_nl/work/arend/utils/coccinelle-1.0.7/bundles/parmap'
make: *** [all] Error 2

So what is going on. During configure it is detected that my machine does not
have the parmap ocaml library. This library is also bundled in coccinelle tarbal
so it decides to build that. However, that fails for some reason. I decided to
take a closer look. I found that if I went to bundles/parmap/parmap and run make
there the build went fine so I went along and installed it. Rerun configure picked
up the installed parmap library and the reset of coccinelle build went fine.

So I am back in business and here is the patch that should fix the cordic users.

Regards,
Arend
---
 backport/backport-include/linux/cordic.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/cordic.h b/backport/backport-include/linux/cordic.h
index 67d6a4a..101da91 100644
--- a/backport/backport-include/linux/cordic.h
+++ b/backport/backport-include/linux/cordic.h
@@ -5,6 +5,16 @@

 #if (LINUX_VERSION_CODE > KERNEL_VERSION(3,1,0))
 #include_next <linux/cordic.h>
+#if LINUX_VERSION_IS_LESS(5,0,0)
+#define CORDIC_ANGLE_GEN	39797
+#define CORDIC_PRECISION_SHIFT	16
+#define CORDIC_NUM_ITER	(CORDIC_PRECISION_SHIFT + 2)
+
+#define CORDIC_FIXED(X)	((s32)((X) << CORDIC_PRECISION_SHIFT))
+#define CORDIC_FLOAT(X)	(((X) >= 0) \
+		? ((((X) >> (CORDIC_PRECISION_SHIFT - 1)) + 1) >> 1) \
+		: -((((-(X)) >> (CORDIC_PRECISION_SHIFT - 1)) + 1) >> 1))
+#endif
 #else

 /*
--
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
