Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D075C4332F
	for <backports@archiver.kernel.org>; Fri, 28 Jan 2022 08:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347385AbiA1Iwr (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 28 Jan 2022 03:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347377AbiA1Iwk (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 28 Jan 2022 03:52:40 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728FBC061714
        for <backports@vger.kernel.org>; Fri, 28 Jan 2022 00:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=QB6upebxx8V7RU5BEFu6hU8k40dNmvJS3KS7Pdpivg8=; t=1643359959; x=1644569559; 
        b=XodM0zqvarjoAuNJ3B7lm9hjT38uLgZNxeQXGdTuRzH8RwNApXgOrNDtJ5N3U8Jh+dTcP75e6Kb
        l3xVuj7px0SoEotCm+k2AnqCj0NYYqliGtnnveX76/AU/7LH42vujrIDzcYoRq1yq61g3VBisAXi/
        gzk759GNeD6PjlODyxKFFsuKYv64D0CH5A8twBt+Mg6ZlD8PwazdHIMxyY8ZsSO3six7UB+X/FFnW
        Ud0wYe389puPRRqHNWk3Teoh82TfYJSFdjRdfZMsNtaZfCNI6IIeZqL6Vx3/o6lBaqDQVi+3bfO05
        BPNZqmkYmXU74jLEw9twy9l6Q9iI3HnUO/gQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nDMzj-00BMr8-4F;
        Fri, 28 Jan 2022 09:52:35 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] patches: add spatch to adjust to changed ethtool ringparam API
Date:   Fri, 28 Jan 2022 09:52:28 +0100
Message-Id: <20220128095230.da47bbe7d248.I29005f305b7808de21837d75e992b07444b4eaaa@changeid>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This changed in 5.17-rc1, so add the necessary ifdefs via a
new spatch.

ticket=none

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0106-ethtool-ringparam.cocci | 45 ++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 patches/0106-ethtool-ringparam.cocci

diff --git a/patches/0106-ethtool-ringparam.cocci b/patches/0106-ethtool-ringparam.cocci
new file mode 100644
index 000000000000..6f78668e37b6
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
++      , struct kernel_ethtool_ringparam *krp,
++      struct netlink_ext_ack *extack
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
++       , struct kernel_ethtool_ringparam *krp,
++       struct netlink_ext_ack *extack
++#endif
+       )
+{
+...
+}
-- 
2.34.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
