Return-Path: <SRS0=zoIX=ST=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E108C282DA
	for <backports@archiver.kernel.org>; Wed, 17 Apr 2019 12:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAF0206BA
	for <backports@archiver.kernel.org>; Wed, 17 Apr 2019 12:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="tzGND+nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbfDQMFn (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:05:43 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:51488 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731704AbfDQMFn (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 17 Apr 2019 08:05:43 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 0BDD830C013;
        Wed, 17 Apr 2019 05:05:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 0BDD830C013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1555502742;
        bh=9FdVlkBM8filCGSj0Qc8H/k8yWhR6HP8Po25oZVke+g=;
        h=From:To:Cc:Subject:Date:From;
        b=tzGND+nl5U8OxtYFxhCD8PzMZoyknRbT0pVfHgrec/qto22sWBQgWMeYtbsGTECbP
         kwTJHgJ2MzD5w9XPX8iWll9Xk+rtoZOIkYvWwsrJftbz9OvI4gregrp3wBc19dn2zs
         X1+vcv8574f3B1BnmX0fXMJ1IVoYspAoz4CmKHUE=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 99E8F81EC5;
        Wed, 17 Apr 2019 05:05:41 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 623E9B014B9; Wed, 17 Apr 2019 14:05:40 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     backports@vger.kernel.org
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] backport-include: add empty lockdep_map structure in lockdep.h
Date:   Wed, 17 Apr 2019 14:05:34 +0200
Message-Id: <1555502734-15388-1-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

include/linux/rhashtable.h now uses struct lockdep_map unconditionally
which is fine for upstream as lockdep.h defines an empty lockdep_map
structure if CONFIG_LOCKDEP is not set. However, that is only true
since kernel 4.15 so adding such definition in our lockdep.h to cover
older kernels.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/linux/lockdep.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
index 5a5d0d0..12b91b4 100644
--- a/backport/backport-include/linux/lockdep.h
+++ b/backport/backport-include/linux/lockdep.h
@@ -14,4 +14,10 @@
 #endif /* CONFIG_LOCKDEP */
 #endif /* LINUX_VERSION_IS_LESS(3,9,0) */
 
+#if LINUX_VERSION_IS_LESS(4,15,0)
+#ifndef CONFIG_LOCKDEP
+struct lockdep_map { };
+#endif /* CONFIG_LOCKDEP */
+#endif /* LINUX_VERSION_IS_LESS(4,15,0) */
+
 #endif /* __BACKPORT_LINUX_LOCKDEP_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
