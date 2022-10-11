Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C062CC433FE
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJKVFJ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJKVFA (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB2E22B2E
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HBSiixcTod87tQzCN7L3quPYniLfoVK2OqfaLrXCpXw=;
        t=1665522295; x=1666731895; b=ohw59v5EP3exRUusu8P/pYkGAjVq6w90V0siat146mh6Tuq
        Az4pn5yNejPmver53GA9JNu7ojTNZ6im2LhryBtyw6No7x8jSiEZ6s0p5wGz+r+r6PfCESVuDebKo
        QORrdVudMnOmOOjzMGiOfCVMTOCu44g69jbgNp44cXsFP+m+jcQE9e1E/imVbSSyGzXgGKA7DNYoe
        pyyoI2CjIRK67TcaCO2Pgydn0pfOTWDVP3anLt8MxF9qoZijG4dUciKGfTeC1B5L1AsMwphG/AuUG
        FCfIWukjup0nQxaxwNjwcWs+cfzPW6jqcVeClRSRFoHpGWB0hB7TP5Mu93o6H/Pg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQk-0045LP-1Y;
        Tue, 11 Oct 2022 23:04:50 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 07/38] backport: remove aql_disable debugfs for < v4.10
Date:   Tue, 11 Oct 2022 23:04:15 +0200
Message-Id: <20221011210446.144768-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The static_key implementation has changed considerably in v4.10 and is
only used in a new debugfs entry in mac80211.  It's very hard to
backport the new static_key implementation, and not worth the trouble
for a functionality that will probably never be used.

type=maint
ticket=jira:WIFI-116062

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 patches/0101-remove_aql_disable.cocci | 39 +++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 patches/0101-remove_aql_disable.cocci

diff --git a/patches/0101-remove_aql_disable.cocci b/patches/0101-remove_aql_disable.cocci
new file mode 100644
index 000000000000..838d9d49e84a
--- /dev/null
+++ b/patches/0101-remove_aql_disable.cocci
@@ -0,0 +1,39 @@
+@aql_ops@
+identifier aql_disable_write, aql_disable_read;
+identifier simple_open, default_llseek;
+@@
++#if LINUX_VERSION_IS_GEQ(4,10,0)
+static const struct file_operations aql_enable_ops = {
+	.write = aql_disable_write,
+	.read = aql_disable_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
++#endif
+
+@@
+identifier aql_ops.aql_disable_write;
+@@
++#if LINUX_VERSION_IS_GEQ(4,10,0)
+aql_disable_write(...)
+{
+...
+}
++#endif
+
+@@
+identifier aql_ops.aql_disable_read;
+@@
++#if LINUX_VERSION_IS_GEQ(4,10,0)
+aql_disable_read(...);
+{
+...
+}
++#endif
+
+@@
+expression e;
+@@
++#if LINUX_VERSION_IS_GEQ(4,10,0)
+DEBUGFS_ADD_MODE(aql_enable, e);
++#endif
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
