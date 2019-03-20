Return-Path: <SRS0=IQna=RX=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BDAC43381
	for <backports@archiver.kernel.org>; Wed, 20 Mar 2019 02:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F2F2184D
	for <backports@archiver.kernel.org>; Wed, 20 Mar 2019 02:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmolYxgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfCTCen (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:34:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42829 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfCTCen (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Mar 2019 22:34:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so752044pfn.9
        for <backports@vger.kernel.org>; Tue, 19 Mar 2019 19:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=yGRGme722hHhdJZt9XFqgfh6kYYfHE8aexQKr571aEk=;
        b=UmolYxgSKnscEpFPEupWOmXE490UcaV2n7PjXLJMD0ZS6y9lbK6eZPpXoTYsc/kFby
         Psv9AmaxaMNN2/F9ioAmsl/xddadoSYf699x6ZHN7xODXw+oU1KqyJsPMj47epnppHTk
         n91jXkUj4KXhIEfyMMIR90/EuTJET960yliotvO+7/v67YLETP+0//f93t+NBCkkmvxy
         VPaLQfaMXawJcvb5duoxwou9pFjAn8muokSukzneVbPIXCP6LY3q1Tp+ctOd+oXNLOyD
         UaQOz9y7aJGIfVaZzXySghLNetHUESS7QTE06U40nwiFVh6+H+qHJRm3OqoEmWfUj8V+
         HYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=yGRGme722hHhdJZt9XFqgfh6kYYfHE8aexQKr571aEk=;
        b=ngdF8Oj8eevuFjlXIxOqrEfsEBtSeaxt5vtDtRp2sNkknuVp8t+GcP29zQcdIywLD/
         9x4KG4NSdOOcbrjtIBSYBjQ3sGJFCZlLnqqCJG0eGgCrXQgU/cVo7+6FN3N+PmG/B5x9
         YyLjrsruSLmoVIF+ewjGjvnNTeY9e+axfl+LYkRjPGqVhw8M8+7oHOOXvoFtzi/fQDrQ
         x+/ZZ7IRfj6siXaECR9JWuUvRkQAg7lCdPy6Q+/hftdWyEDWnwiLlLEg3AtjeOXDIeQM
         dBFjCbHAcqvuz3Rbx8eP4Lj55gsi/Qn3H4FsoHYAoBzKTliJ30I6Vj/wszx/5OnW/Bq7
         IT0A==
X-Gm-Message-State: APjAAAX55q8lN5uaT8vGg7mvIBxXKG3pbknZHy/Fcw6eqboBwCfybVDH
        2G/B34P7KQxtkFbqkdoh5DM=
X-Google-Smtp-Source: APXvYqyQsTloCgRHHrP1q87vjH6WQzyI19wgGNTxqy1vvQcUQF58Tea+6wP8DqtVCCXFamslIM9Rjw==
X-Received: by 2002:a17:902:8644:: with SMTP id y4mr5221719plt.99.1553049282613;
        Tue, 19 Mar 2019 19:34:42 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id k8sm411707pgq.37.2019.03.19.19.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 19:34:41 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH v2 2/2] backports: update backport/backport-include/net/netlink.h
Date:   Wed, 20 Mar 2019 10:34:34 +0800
Message-Id: <20190320023434.2804-3-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190320023434.2804-1-acelan.kao@canonical.com>
References: <20190320023434.2804-1-acelan.kao@canonical.com>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add new macros has been introduced since v5.1-rc1
   23323289b154 netlink: reduce NLA_POLICY_NESTED{,_ARRAY} arguments

V2: The new macros are required under v5.1, v1 put the macros only under
v4.20

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 backport/backport-include/net/netlink.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 4af73631..c5db02da 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -4,6 +4,17 @@
 #include <linux/version.h>
 #include <linux/in6.h>
 
+#if LINUX_VERSION_IS_LESS(5,1,0)
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
@@ -59,10 +70,14 @@ struct backport_nla_policy {
 #define NLA_POLICY_ETH_ADDR		NLA_POLICY_EXACT_LEN(ETH_ALEN)
 #define NLA_POLICY_ETH_ADDR_COMPAT	NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN)
 
+#ifndef NLA_POLICY_NESTED
 #define NLA_POLICY_NESTED(maxattr, policy) \
 	{ .type = NLA_NESTED, .validation_data = policy, .len = maxattr }
+#endif
+#ifndef NLA_POLICY_NESTED_ARRAY
 #define NLA_POLICY_NESTED_ARRAY(maxattr, policy) \
 	{ .type = NLA_NESTED_ARRAY, .validation_data = policy, .len = maxattr }
+#endif
 
 #define __NLA_ENSURE(condition) (sizeof(char[1 - 2*!(condition)]) - 1)
 #define NLA_ENSURE_INT_TYPE(tp)				\
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
