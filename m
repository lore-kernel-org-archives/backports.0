Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DB9C433EF
	for <backports@archiver.kernel.org>; Mon, 21 Feb 2022 11:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356468AbiBULQ6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:16:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355474AbiBULPO (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 21 Feb 2022 06:15:14 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A107E92
        for <backports@vger.kernel.org>; Mon, 21 Feb 2022 02:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=QeChGuqnOC4MvvLZCjUv4KK6oO6CP1u6F97inDYvyXM=; t=1645440768; x=1646650368; 
        b=skWQ44UxgulKp4tdiNUui6IU9LKwGWiKZcmEK9NcnwsxoKI59uoldETIoq0CKwqzr7QFv3Tjl+Z
        DpZaO+mpmeudgoKjwbWibZQyJXu7ERMGSC6B8yjClU1rftIsDFklE2WnCS59s50tGImqI3AErkCeE
        KkW1xwU65/bWauFt7BE/VS3H80/XzwH7+uS/SAAfYrb0+CxLJ5EwaJp4L4s9g5dj8SAw5R3Sq5D8G
        KMwwsTbTXAJHfGspPhS5++hPblU6fQ0M+iuS8u9PDlWQtEojoixvXmDM2i012KFj/S4QCoAl/zyPi
        NYKdiEF2Iu9i2w6ZVGfENU4yz0Kc8LYCRKvw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nM6JA-003nvB-DR;
        Mon, 21 Feb 2022 11:52:44 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] patches: add spatch to adjust to changed ethtool ringparam API
Date:   Mon, 21 Feb 2022 11:52:40 +0100
Message-Id: <20220221115240.82052e859f62.I18f41541a5b4c6f8285a78d32203e6dbc35a5105@changeid>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This changed in 5.17-rc1, so add the necessary ifdefs via a
new spatch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0106-ethtool-ringparam.cocci | 45 ++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 patches/0106-ethtool-ringparam.cocci

diff --git a/patches/0106-ethtool-ringparam.cocci b/patches/0106-ethtool-ringparam.cocci
new file mode 100644
index 000000000000..7b72f391b140
--- /dev/null
+++ b/patches/0106-ethtool-ringparam.cocci
@@ -0,0 +1,45 @@
+@set@
+identifier ops, fn;
+@@
+const struct ethtool_ops ops = {
+  .set_ringparam = fn,
+  ...
+};
+
+@@
+identifier set.fn;
+identifier dev, rp;
+@@
+int fn(struct net_device *dev,
+       struct ethtool_ringparam *rp
++#if LINUX_VERSION_IS_GEQ(5,17,0)
+       , struct kernel_ethtool_ringparam *krp,
+       struct netlink_ext_ack *extack
++#endif
+      )
+{
+...
+}
+
+@get@
+identifier ops, fn;
+@@
+const struct ethtool_ops ops = {
+  .get_ringparam = fn,
+  ...
+};
+
+@@
+identifier get.fn;
+identifier dev, rp;
+@@
+void fn(struct net_device *dev,
+        struct ethtool_ringparam *rp
++#if LINUX_VERSION_IS_GEQ(5,17,0)
+        , struct kernel_ethtool_ringparam *krp,
+        struct netlink_ext_ack *extack
++#endif
+       )
+{
+...
+}
-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
