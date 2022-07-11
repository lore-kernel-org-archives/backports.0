Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB25C43334
	for <backports@archiver.kernel.org>; Mon, 11 Jul 2022 16:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiGKQLo (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Jul 2022 12:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGKQLn (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Jul 2022 12:11:43 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777E07A502
        for <backports@vger.kernel.org>; Mon, 11 Jul 2022 09:11:42 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DE0253F8D6
        for <backports@vger.kernel.org>; Mon, 11 Jul 2022 16:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657555900;
        bh=wVpXsqnpCwF85ChCzDHdsKZ9P2qYgExGI2oXRwfQYX8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=k29xVZVrTwSaioMM9KbJEeeKjI8LH6mdZRYCH3943Y6QARtRmA0Yyu92t626Dxrtm
         CwtTQ7bfpLtvDNg+vRKtryWckfYwFRHJSWyCsXu1wbA0ePyDnz7MM/jZFsIR8Buypl
         1+GS00Kik2t9WSl8q+rWWCd/f6k1F0l5FF2QGBihfO+Am6Gv5YMPnSA1nkJB3LZnNQ
         rNMQScompgHrZEEtiSFuXvP1mlFdo/c6CGOstzALe+H1NX79nUMTUEaCnZXNhjdPtu
         ff+bp1MOVfmQwuV/YWvhtAsg6ZOiRZ9sCBEwanEMFaKjjfxI/0PKv2F1mnbaocT3H+
         4ENL9pXoHgjKw==
Received: by mail-wr1-f72.google.com with SMTP id h29-20020adfaa9d000000b0021d67fc0b4aso776414wrc.9
        for <backports@vger.kernel.org>; Mon, 11 Jul 2022 09:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVpXsqnpCwF85ChCzDHdsKZ9P2qYgExGI2oXRwfQYX8=;
        b=UxcyjkQIJ9zRfwtRgc2ltO8j0YLv846LL8dop1aDOkW3diSMZqDF0K6PBobE65k+SW
         yDQ1TMQyyglhKE0tu1iRXjl61t+H+ts68PGhT2uu+UAfZ+qlgQnM1NE0V6saddSAaU8V
         N4EJ/96MYUW6fhRqxs4zgtFht4UvwHXvpEM7HL8Sdx+9xCTmnsnbGf/IU6uroMVyZ96L
         yadKAsV8TP7FD9bqd5PoztbisoJqI9N7sfiWjpY+ZMYT4g3bgWXkluJ2FsCnOZukCyGH
         5wQMWGciDXvd/NPFdavFvhyYjUxnxR/SEsIUI8yQK2Z41w3bee0zMETENXptdtzmwUC3
         LVoQ==
X-Gm-Message-State: AJIora8VHe0gQk6Kj907VtLVB728W3DukRwEAfPfG1r6ET3dp1PFweKF
        rMXh1qmVCww8x23A3Kum9jmdzbkzrCmE4rhLEECRLAeFLH6tLi4WO6n+X389MkEACwcE6tObl2i
        kjR0SoOSSimIEV5XBzwm6lY3C0jWZEQOEqj0s5w==
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id v16-20020a1cf710000000b003941960e8a1mr16790643wmh.154.1657555895309;
        Mon, 11 Jul 2022 09:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tGXBr2aNmAldbUOlCNh8SQdgdZJuTMN3rg4wB4p2HgEPex23uAfJjuu7AMjI4myUfLA6OFwQ==
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id v16-20020a1cf710000000b003941960e8a1mr16790621wmh.154.1657555895050;
        Mon, 11 Jul 2022 09:11:35 -0700 (PDT)
Received: from localhost ([2a01:4b00:85fd:d700:2a48:63cb:df6d:cbf4])
        by smtp.gmail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm7197837wmc.16.2022.07.11.09.11.34
        for <backports@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 09:11:34 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     backports@vger.kernel.org
Subject: [PATCH] headers: backport IBT / CFI support
Date:   Mon, 11 Jul 2022 17:11:30 +0100
Message-Id: <20220711161130.529294-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Kernels that support IBT on x86 require module_init/exit() functions
to have cfi protection included. Backport __CFI_ADDRESSABLE changes
from upstream linux/module.h into backports version of module.h
header.

This results in backported modules correctly pick up CFI protection
only when building against IBT enabled kernels.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 backport/backport-include/linux/module.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/module.h b/backport/backport-include/linux/module.h
index cd342e0d2fdd..efe970f174ed 100644
--- a/backport/backport-include/linux/module.h
+++ b/backport/backport-include/linux/module.h
@@ -3,6 +3,10 @@
 #include_next <linux/module.h>
 #include <linux/rcupdate.h>
 
+#ifndef __CFI_ADDRESSABLE
+#define __CFI_ADDRESSABLE(fn, __attr)
+#endif
+
 /*
  * The define overwriting module_init is based on the original module_init
  * which looks like this:
@@ -34,6 +38,7 @@ extern void backport_dependency_symbol(void);
 		return initfn();					\
 	}								\
 	int init_module(void) __attribute__((cold,alias("__init_backport")));\
+	__CFI_ADDRESSABLE(init_module, __initdata); \
 	BACKPORT_MOD_VERSIONS
 
 /*
@@ -58,7 +63,8 @@ extern void backport_dependency_symbol(void);
 		exitfn();						\
 		rcu_barrier();						\
 	}								\
-	void cleanup_module(void) __attribute__((cold,alias("__exit_compat")));
+	void cleanup_module(void) __attribute__((cold,alias("__exit_compat"))); \
+	__CFI_ADDRESSABLE(cleanup_module, __exitdata);
 #endif
 
 #endif /* __BACKPORT_LINUX_MODULE_H */
-- 
2.32.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
