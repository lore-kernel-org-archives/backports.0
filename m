Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30205C83013
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3622085B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="nqAxHxuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgLAWF4 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgLAWFz (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:55 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632E3C061A4D
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:41 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Clx3D0MlmzQlSD;
        Tue,  1 Dec 2020 23:04:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvY7nU0zyP7ROxadf1H3CVxxA7NhhFCaDFyfqxfLcS0=;
        b=nqAxHxuICKbK8dtAfgQUBqhUNkRHLvYqGSsqJvZ+IfT9OazYB4Gl+qhdf/eeb8Hc71eJlO
        kzdbU0cP/IzcuHjY3YTJTBm61MaIeOGx/56xhdehgKyUw9q+cp14KkTWpZiQrgPYZOQoqR
        493c5MSEeO9oK3QbiyWLMvLA0RSv3gzVSQy5O+hdRmK0I+O01KKrujN1LDeVVigmkCjjW0
        Y5mNGAGkv04qM6nmjQMoiZt48Lfo/xSVV484bxY9LHZljMpaCcrB4/rBU/8CqxXzxOAYlv
        Qw2g8UMXyAbOpyr8hvNI7J2WAqzQow3wifvtR1tSJ6ikLNqJA1EHGpgHUTglXw==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id b-kUJ5XWPf3V; Tue,  1 Dec 2020 23:04:37 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 19/30] patches: handle netdev_walk_all_lower_dev()
Date:   Tue,  1 Dec 2020 23:04:04 +0100
Message-Id: <20201201220415.30582-20-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: 380501853
X-Rspamd-UID: 4e62ad
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The signature of netdev_walk_all_lower_dev() takes a pointer to struct
netdev_nested_priv starting with kernel 5.9. Add a patch to handle both
cases now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0098-netdev_nested_priv/qtnfmac.patch | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 patches/0098-netdev_nested_priv/qtnfmac.patch

diff --git a/patches/0098-netdev_nested_priv/qtnfmac.patch b/patches/0098-netdev_nested_priv/qtnfmac.patch
new file mode 100644
index 00000000..77d07f61
--- /dev/null
+++ b/patches/0098-netdev_nested_priv/qtnfmac.patch
@@ -0,0 +1,43 @@
+--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
++++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
+@@ -671,10 +671,16 @@ bool qtnf_netdev_is_qtn(const struct net
+ 	return ndev->netdev_ops == &qtnf_netdev_ops;
+ }
+ 
++#if LINUX_VERSION_IS_GEQ(5,9,0)
+ static int qtnf_check_br_ports(struct net_device *dev,
+ 			       struct netdev_nested_priv *priv)
+ {
+ 	struct net_device *ndev = (struct net_device *)priv->data;
++#else
++static int qtnf_check_br_ports(struct net_device *dev, void *data)
++{
++	struct net_device *ndev = data;
++#endif
+ 
+ 	if (dev != ndev && netdev_port_same_parent_id(dev, ndev))
+ 		return -ENOTSUPP;
+@@ -687,9 +693,11 @@ static int qtnf_core_netdevice_event(str
+ {
+ 	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+ 	const struct netdev_notifier_changeupper_info *info;
++#if LINUX_VERSION_IS_GEQ(5,9,0)
+ 	struct netdev_nested_priv priv = {
+ 		.data = (void *)ndev,
+ 	};
++#endif
+ 	struct net_device *brdev;
+ 	struct qtnf_vif *vif;
+ 	struct qtnf_bus *bus;
+@@ -729,7 +737,11 @@ static int qtnf_core_netdevice_event(str
+ 		} else {
+ 			ret = netdev_walk_all_lower_dev(brdev,
+ 							qtnf_check_br_ports,
++#if LINUX_VERSION_IS_GEQ(5,9,0)
+ 							&priv);
++#else
++							ndev);
++#endif
+ 		}
+ 
+ 		break;
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
