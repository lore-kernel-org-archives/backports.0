Return-Path: <SRS0=hPYX=RW=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F71DC43381
	for <backports@archiver.kernel.org>; Tue, 19 Mar 2019 06:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD6220989
	for <backports@archiver.kernel.org>; Tue, 19 Mar 2019 06:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJS6fqNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfCSGJW (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:09:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37110 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSGJW (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Mar 2019 02:09:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so13141014pgq.4
        for <backports@vger.kernel.org>; Mon, 18 Mar 2019 23:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=j0++b0fzdwuZf7R5hW002r1Pov7AleyQ0YEZsDZ6PCY=;
        b=kJS6fqNBnoj4z7vq7fqw0kZtBP6XNFF8fkuxREcU5dB0jic//1DDCIFFmp9A0Tf/vZ
         i3qieHD4spOop6cglkMjjEefEvZFfYhbXm681LIb7LUeOlmu78p26yhXhDgXO/ann/N0
         mQvJg14sfARmAHog2NjCsnb+1UIXerQawEJgeU19xJ2ToL2QJvnK54srAhVOyWvN+RF9
         EMiuD4YjS9ROU4PRRCXmr1EPqfpsdH7T2zYRBDiQ3M6rIT9ClL0n8uXlYUeBiCdX+C80
         RKnravb5U5c/pplgz7R76nqDssi7E/g8MmbFZ3dr9kU0SYlrSnY5g70L+ag+jrwxlAuY
         2Jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=j0++b0fzdwuZf7R5hW002r1Pov7AleyQ0YEZsDZ6PCY=;
        b=CF7TYKotpFlMNM0/zIhJxq4SXl9Ia4aOH+Z9jG4hWp7rpsliO/yMXc/1KKTzpSfGO3
         i6gsndlhuaJVaZegb52i6bdTk6G2CBNy635v0Wy4ugwoUtdjFiO/CYW8fO2rJfrTS1yB
         Hb82aD60Bjf43QFOfN/FWP7+fLFF7XkVh21Bt9Paq5MPiDCj1sl2ZHwyQAPItskvkJhh
         9d9fSQOG03swrzEZTCxCYZ472ttaTWUJ6XDrwso+omFud5VEw7bicwBm0bzIkwEx3QyB
         2WtQxtz4kX2AghbFKRRbm25/5hZGkIz7/v5BNSlcnwhvaqCuwvAi8+mTFxYNoPj1alH7
         wn8g==
X-Gm-Message-State: APjAAAXBWufgUH6lED0HdqKJyTBYIngAwggnIMaXCxrwwQ0aF5BWiOfV
        dxkBbywp8kt67h0dFoKeqmw=
X-Google-Smtp-Source: APXvYqyQWvqb1qZkAqk/LkUpVdLb3Fz9yf/KjOcTL/Z4dR76Dyqf8uBB00J1kGXVW8UwBYJQ/O+NLQ==
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr306439plt.195.1552975761915;
        Mon, 18 Mar 2019 23:09:21 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id u13sm19701500pfa.169.2019.03.18.23.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 23:09:21 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH 2/2] backports: update backport/backport-include/net/netlink.h
Date:   Tue, 19 Mar 2019 14:09:15 +0800
Message-Id: <20190319060915.19849-3-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190319060915.19849-1-acelan.kao@canonical.com>
References: <20190319060915.19849-1-acelan.kao@canonical.com>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add new macros introduced from
   23323289b154 netlink: reduce NLA_POLICY_NESTED{,_ARRAY} arguments

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 backport/backport-include/net/netlink.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 4af73631..6f6630ae 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -59,10 +59,14 @@ struct backport_nla_policy {
 #define NLA_POLICY_ETH_ADDR		NLA_POLICY_EXACT_LEN(ETH_ALEN)
 #define NLA_POLICY_ETH_ADDR_COMPAT	NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN)
 
-#define NLA_POLICY_NESTED(maxattr, policy) \
+#define _NLA_POLICY_NESTED(maxattr, policy) \
 	{ .type = NLA_NESTED, .validation_data = policy, .len = maxattr }
-#define NLA_POLICY_NESTED_ARRAY(maxattr, policy) \
+#define _NLA_POLICY_NESTED_ARRAY(maxattr, policy) \
 	{ .type = NLA_NESTED_ARRAY, .validation_data = policy, .len = maxattr }
+#define NLA_POLICY_NESTED(policy) \
+	_NLA_POLICY_NESTED(ARRAY_SIZE(policy) - 1, policy)
+#define NLA_POLICY_NESTED_ARRAY(policy) \
+	_NLA_POLICY_NESTED_ARRAY(ARRAY_SIZE(policy) - 1, policy)
 
 #define __NLA_ENSURE(condition) (sizeof(char[1 - 2*!(condition)]) - 1)
 #define NLA_ENSURE_INT_TYPE(tp)				\
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
