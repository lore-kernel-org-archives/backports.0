Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEE1C4167E
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85524610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhJSVqL (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJSVqI (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:08 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FD3C06161C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:54 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLd3KXGzQjbF;
        Tue, 19 Oct 2021 23:43:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7SHiegKJj4pwWW9bvvv97xF4t+WTpd3yRY+jFttiGHM=;
        b=SwfHFiJIADv71TGkTQWB1YnujDjs1ANcSyfMkpZy7EggP7ziEMpLhSxTLfYxYzJqhwyxVO
        07ti8ulSIc3+njgddFlBOFbn1UCwMEM8Dok/3/OZ8OXn3L7XltjDnJtQvktp1gYjqOR+LK
        /5VaHkYoqwq4unz4uV4gp/29PjO/VSCu/eb6e2edCjSlwStNYebR00ltdU/FXG4QC0JN9j
        JSqu9Mtam83HW3/9csPrDGF63dayuHiPQVRQEzGYYX0ZgNMcBsOnVa6FeqwT4jsY2Udnb8
        Gh1Om9huSXS3L/eKC1wXb4lXrK0fZdcGOWcMIfFBIt05BNav25yGFNNgwAMNsw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 40/47] patches: Adapt signature of ethtool_ops->set_coalesce callback
Date:   Tue, 19 Oct 2021 23:43:13 +0200
Message-Id: <20211019214320.2035704-41-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BEB481313
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

With kernel 5.15 ethtool_ops->set_coalesce and ethtool_ops->get_coalesce
callback function got extra parameters. Add a patch to handle this.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0103-ethtool-coalesce.patch | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 patches/0103-ethtool-coalesce.patch

diff --git a/patches/0103-ethtool-coalesce.patch b/patches/0103-ethtool-coalesce.patch
new file mode 100644
index 00000000..a41b9c4b
--- /dev/null
+++ b/patches/0103-ethtool-coalesce.patch
@@ -0,0 +1,36 @@
+--- a/drivers/net/wireless/ath/wil6210/ethtool.c
++++ b/drivers/net/wireless/ath/wil6210/ethtool.c
+@@ -11,11 +11,16 @@
+ 
+ #include "wil6210.h"
+ 
++#if LINUX_VERSION_IS_GEQ(5,15,0)
+ static int
+ wil_ethtoolops_get_coalesce(struct net_device *ndev,
+ 			    struct ethtool_coalesce *cp,
+ 			    struct kernel_ethtool_coalesce *kernel_coal,
+ 			    struct netlink_ext_ack *extack)
++#else
++static int wil_ethtoolops_get_coalesce(struct net_device *ndev,
++				       struct ethtool_coalesce *cp)
++#endif
+ {
+ 	struct wil6210_priv *wil = ndev_to_wil(ndev);
+ 	u32 tx_itr_en, tx_itr_val = 0;
+@@ -48,11 +53,16 @@ out:
+ 	return ret;
+ }
+ 
++#if LINUX_VERSION_IS_GEQ(5,15,0)
+ static int
+ wil_ethtoolops_set_coalesce(struct net_device *ndev,
+ 			    struct ethtool_coalesce *cp,
+ 			    struct kernel_ethtool_coalesce *kernel_coal,
+ 			    struct netlink_ext_ack *extack)
++#else
++static int wil_ethtoolops_set_coalesce(struct net_device *ndev,
++				       struct ethtool_coalesce *cp)
++#endif
+ {
+ 	struct wil6210_priv *wil = ndev_to_wil(ndev);
+ 	struct wireless_dev *wdev = ndev->ieee80211_ptr;
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
