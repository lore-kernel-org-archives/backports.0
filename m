Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70002C4332F
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJKVFU (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJKVFC (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADE9356CA
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=umEFBdqdnJzsRgQYyjlVTNMtvITfREgUQGjkqojkPc8=;
        t=1665522299; x=1666731899; b=cyXRm/etshNYL2sKTN6mNJUTXTfvz/4/8kvtkaZovvNMZAH
        YVJ8lVxpHWskxCAQm7Jvebrcw4HmxuFM392CRHcBBhxfK7fGgzq71Ge1ySC/LEaoKokRBnRrMXzH9
        6zmX9csXxp5M44wSmb3/SaUaInM2/n8wxGP5WLpwaRkzZzP+So7pemTAceG9TrgXpMztqLtzNuhRk
        PJP5HdyV9k7vw2yhkqe9HA7nBHlQQVgDGRqgGtcBFTG9bDfvcJFqC46us2rHdTjfXjhxigaeNL84w
        hkXivFtbYh83laGwx6MAdIm0WG1kqYyr6wP3QHT4G6ZYzJlSS9U5PSTNWMXEULJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQr-0045LP-0i;
        Tue, 11 Oct 2022 23:04:57 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 29/38] backports: add DECLARE_FLEX_ARRAY()
Date:   Tue, 11 Oct 2022 23:04:37 +0200
Message-Id: <20221011230356.1a1a6ae0dace.I5042a985a702b7a8b4dcb4116997b2a53749f6ca@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/stddef.h | 31 ++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/backport/backport-include/linux/stddef.h b/backport/backport-include/linux/stddef.h
index a6cdc67d2727..54afbd556467 100644
--- a/backport/backport-include/linux/stddef.h
+++ b/backport/backport-include/linux/stddef.h
@@ -23,4 +23,35 @@
 	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
 #endif
 
+#ifndef DECLARE_FLEX_ARRAY
+/**
+ * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
+ *
+ * @TYPE: The type of each flexible array element
+ * @NAME: The name of the flexible array member
+ *
+ * In order to have a flexible array member in a union or alone in a
+ * struct, it needs to be wrapped in an anonymous struct with at least 1
+ * named member, but that member can be empty.
++ */
+#define __DECLARE_FLEX_ARRAY(TYPE, NAME)       \
+	struct {			       \
+		struct { } __empty_ ## NAME;   \
+		TYPE NAME[];		       \
+	}
+
+/**
+ * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
+ *
+ * @TYPE: The type of each flexible array element
+ * @NAME: The name of the flexible array member
+ *
+ * In order to have a flexible array member in a union or alone in a
+ * struct, it needs to be wrapped in an anonymous struct with at least 1
+ * named member, but that member can be empty.
+ */
+#define DECLARE_FLEX_ARRAY(TYPE, NAME) \
+	__DECLARE_FLEX_ARRAY(TYPE, NAME)
+#endif
+
 #endif /* __BACKPORT_LINUX_STDDEF_H */
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
