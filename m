Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC77C4332F
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJKVFK (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJKVFA (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBC722BEA
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fjx3SsFktLKgxODkCIHOB5G/dKYbW3gYapXz0bBCp+o=;
        t=1665522295; x=1666731895; b=O2pQG0qSjn2lLOI9CxOnK4lIgAFa4t7AzVG4YyTT3XbleTV
        bPQtRw4HUfZHgmY7bEYSD2iXnP2MNCcW2ODfIo23Zez4/FqDJTeE9eLCtwc7HPSzM6kD9vKBDpKm2
        KBHf6rCTco1NFPKJ4f9LYNmPWBLPCHYZe/TeXJflgEuTqXTo26gANkYpd1ALyL6GNNCrvaVGUlXpS
        6fi9s4AfpJfPBkwlI3HD/e9UoNNUUg+qVvkVrLEq8PR6xjLb2Cc7jg3yxx9UlIlOWmUG3p9g5xegI
        OfdOGLpYx71S5XD8pJwz/UwO7hfLWb9bjaGeFpRCnvcKzXMHN15mfpJLRGsLxtnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQj-0045LP-06;
        Tue, 11 Oct 2022 23:04:49 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 02/38] backport: implement NLA_POLICY_RANGE for NLA_BINARY
Date:   Tue, 11 Oct 2022 23:04:10 +0200
Message-Id: <20221011230356.c8e47a959e6d.Ife595e2dc94955bda3d7d3089ec6a219fde272c1@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The range checks for NLA_BINARY are supported since v5.10.  Unwrap the
macros and introduce a new function to test type.

type=maint
ticket=jira:WIFI-85592

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/135576
---
 backport/backport-include/net/netlink.h    | 31 +++++++++++++++++++---
 patches/0097-nla_policy_binary_range.cocci |  5 ++++
 2 files changed, 32 insertions(+), 4 deletions(-)
 create mode 100644 patches/0097-nla_policy_binary_range.cocci

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 3c7fdc7e3e0f..e94f32626782 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -546,10 +546,33 @@ static inline void *nla_memdup(const struct nlattr *src, gfp_t gfp)
 }
 #endif /* < 4.9 */
 
-#ifndef NLA_POLICY_MIN_LEN
-#define NLA_POLICY_MIN_LEN(_len) {		\
-	.type = NLA_BINARY			\
+#if LINUX_VERSION_IS_LESS(5,10,0)
+// pre-declare all the minimum lengths in use
+#define MIN_LEN_VALIDATION(n)						\
+static inline								\
+int nla_validate_min_len_##n(const struct nlattr *attr,			\
+			     struct netlink_ext_ack *extack)		\
+{									\
+	if (nla_len(attr) < n)						\
+		return -EINVAL;						\
+	return 0;							\
 }
-#endif
+
+MIN_LEN_VALIDATION(2)
+MIN_LEN_VALIDATION(16)
+MIN_LEN_VALIDATION(42)
+
+// double-expansion to expand _min to the actual value
+#define NLA_POLICY_BINARY_RANGE(_min, _max) _NLA_POLICY_BINARY_RANGE(_min, _max)
+#define _NLA_POLICY_BINARY_RANGE(_min, _max)		\
+{							\
+	.type = NLA_BINARY,				\
+	.len = _max,					\
+	.validation_type = NLA_VALIDATE_FUNCTION,	\
+	.validate = nla_validate_min_len_ ## _min,	\
+}
+#else
+#define NLA_POLICY_BINARY_RANGE(_min, _max) NLA_POLICY_RANGE(NLA_BINARY, _min, _max)
+#endif /* < 5.10 */
 
 #endif /* __BACKPORT_NET_NETLINK_H */
diff --git a/patches/0097-nla_policy_binary_range.cocci b/patches/0097-nla_policy_binary_range.cocci
new file mode 100644
index 000000000000..cb3b8be52b51
--- /dev/null
+++ b/patches/0097-nla_policy_binary_range.cocci
@@ -0,0 +1,5 @@
+@@
+expression MIN, MAX;
+@@
+-NLA_POLICY_RANGE(NLA_BINARY, MIN, MAX)
++NLA_POLICY_BINARY_RANGE(MIN, MAX)
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
