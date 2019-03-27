Return-Path: <SRS0=sLXW=R6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F28C43381
	for <backports@archiver.kernel.org>; Wed, 27 Mar 2019 03:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A252082F
	for <backports@archiver.kernel.org>; Wed, 27 Mar 2019 03:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvK5KkyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbfC0DAx (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:00:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46880 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfC0DAx (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 26 Mar 2019 23:00:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so8988214pfj.13
        for <backports@vger.kernel.org>; Tue, 26 Mar 2019 20:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=YLOk9AIveWTj1Mb4Yl5OAp2WZPbkTo+QjIG+cLHKRQU=;
        b=cvK5KkyJLsFBZVkF8frHYJyG5HTVP0o2Mq13g7U9WWR4DG79NT1CoLluetXq7CFdge
         tyT2K+3QIiIvgFiBOw7aGRJ+CF5dN/9A15J1ydDyBka5hGY81+F7X2rA21HWplEOsoqF
         80uyynfa1nP/jFaH8jk9N/Vj2uitt6YQ0wysl1exNZyXz1NYlZrJfcMHCkgLBG89AzvG
         5EEYujPyOjv9qBxONus0uvsOSsyX7FhrB+i7FMa5psztbQspJZgrXZmOqiK7hGiO4NN0
         QOPN8xHYJmVjoOT/lkws8QerOF6iEyWS33JyQ/VIQPI0uik27pMKXjK3m2daZHdOQcU/
         +jGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=YLOk9AIveWTj1Mb4Yl5OAp2WZPbkTo+QjIG+cLHKRQU=;
        b=uSPMhHKfWC5to2yeXgR/3+pfd+mL6btkSea2K2FNopOjqynhSvxriRy/aX/ikiKqE7
         dG8ugeIWFszsNxHQcQomrq+DAuaJ0r01H0bDYVjmSKhGOcdl0RdKRdBum1y07uTwf/gX
         6IdBE/iaomczXiq1+q7oOo2J9d3/3P16KZfeVpXaeQrp5UEvzbziYCACb2spdM0WySbg
         jhCw/x8EAMaJ3GVd+qQEMaeHPT5ToxlSLyL5tKtYDm72oR/ftuR51OhFvQsf+nJm4Fy8
         N2y8v+pfYaaJk0JUJryj1q4ryw7fL6ZZsvWW9nr+jKbnI8NOvlo75ybFDHISQ0aOy/7i
         mEaQ==
X-Gm-Message-State: APjAAAU0iVOpnn0NtEjnujSVoBbvWpOh98twNUBEulEpBV5qXizJf647
        kll6A1tr3DlAVGi9K9qzC7M=
X-Google-Smtp-Source: APXvYqzWzqFuqDZ47OQFE9i1QbTBGB/cnsgC5q43vJb1wHR0WWuRwG8QBUBo5OLZHFrae88lWLnCPA==
X-Received: by 2002:a65:5b44:: with SMTP id y4mr14825293pgr.446.1553655652961;
        Tue, 26 Mar 2019 20:00:52 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id c134sm29470974pfc.87.2019.03.26.20.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 20:00:52 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH v3 2/3] backports: update backport/backport-include/net/netlink.h
Date:   Wed, 27 Mar 2019 11:00:43 +0800
Message-Id: <20190327030044.28263-3-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327030044.28263-1-acelan.kao@canonical.com>
References: <20190327030044.28263-1-acelan.kao@canonical.com>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add new macros introduced from v5.1-rc1
   23323289b154 netlink: reduce NLA_POLICY_NESTED{,_ARRAY} arguments

v3: Fix v4.20 compilation error

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 backport/backport-include/net/netlink.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 4af73631..d8237f10 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -4,6 +4,19 @@
 #include <linux/version.h>
 #include <linux/in6.h>
 
+#if LINUX_VERSION_IS_LESS(5,1,0)
+#undef NLA_POLICY_NESTED
+#undef NLA_POLICY_NESTED_ARRAY
+#define _NLA_POLICY_NESTED(maxattr, policy) \
+	{ .type = NLA_NESTED, .validation_data = policy, .len = maxattr }
+#define _NLA_POLICY_NESTED_ARRAY(maxattr, policy) \
+	{ .type = NLA_NESTED_ARRAY, .validation_data = policy, .len = maxattr }
+#define NLA_POLICY_NESTED(policy) \
+	_NLA_POLICY_NESTED(ARRAY_SIZE(policy) - 1, policy)
+#define NLA_POLICY_NESTED_ARRAY(policy) \
+	_NLA_POLICY_NESTED_ARRAY(ARRAY_SIZE(policy) - 1, policy)
+#endif /* < 5.1 */
+
 #if LINUX_VERSION_IS_LESS(4,20,0)
 /* can't backport using the enum - need to override */
 #define NLA_UNSPEC		0
@@ -59,11 +72,6 @@ struct backport_nla_policy {
 #define NLA_POLICY_ETH_ADDR		NLA_POLICY_EXACT_LEN(ETH_ALEN)
 #define NLA_POLICY_ETH_ADDR_COMPAT	NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN)
 
-#define NLA_POLICY_NESTED(maxattr, policy) \
-	{ .type = NLA_NESTED, .validation_data = policy, .len = maxattr }
-#define NLA_POLICY_NESTED_ARRAY(maxattr, policy) \
-	{ .type = NLA_NESTED_ARRAY, .validation_data = policy, .len = maxattr }
-
 #define __NLA_ENSURE(condition) (sizeof(char[1 - 2*!(condition)]) - 1)
 #define NLA_ENSURE_INT_TYPE(tp)				\
 	(__NLA_ENSURE(tp == NLA_S8 || tp == NLA_U8 ||	\
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
