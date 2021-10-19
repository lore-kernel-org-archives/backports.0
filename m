Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D9FC18E19
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8ED61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhJSVqM (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhJSVqI (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:08 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CAAC061746
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:55 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLd2J4wzQkBc;
        Tue, 19 Oct 2021 23:43:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X05Z4B4R6lund+S/vynuPLzs0AFdZjqZ6hPOIASlRl8=;
        b=PhyRBm6TsU7hwBRsLlriRUDhubMIu87rtUASmedG3LNQEqVe84CpMgo42utGFtEDiUFc2Y
        ZcfH5RXwWu+9gby+RvwCnYJWMb1Xoou9Q+vJ67gga8irNcj++kuCmQKXost3HKnkAOLN6r
        EMUx0j7SDf3wpzGAsmWuti9Nh8OA0QZXVfFt8q3dxl/OK8FZY0C72AvfVOMuW/SaVSW4kq
        vgEEKAxcjGF18NkxrkigkYVYLg2m2yt3BBSLeMjEUFhyctvAhBV8X2R2qjFiiTPZLNF/vH
        hIWff/ndjsISGe8K+A3f4jaisSC8tlPTWJCXqFLNHG68CSGfYp6KsbymuLmd7g==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 39/47] patches: Adapt signature of bus_type->remove callback
Date:   Tue, 19 Oct 2021 23:43:12 +0200
Message-Id: <20211019214320.2035704-40-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 92A99130B
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

With kernel 5.15 the return type of the bus_type->remove callback was
changed from int to void.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0102-remove-callback.patch | 63 ++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 patches/0102-remove-callback.patch

diff --git a/patches/0102-remove-callback.patch b/patches/0102-remove-callback.patch
new file mode 100644
index 00000000..9f5a54f1
--- /dev/null
+++ b/patches/0102-remove-callback.patch
@@ -0,0 +1,63 @@
+--- a/drivers/bcma/main.c
++++ b/drivers/bcma/main.c
+@@ -28,6 +28,7 @@ static DEFINE_MUTEX(bcma_buses_mutex);
+ static int bcma_bus_match(struct device *dev, struct device_driver *drv);
+ static int bcma_device_probe(struct device *dev);
+ static void bcma_device_remove(struct device *dev);
++static int bcma_device_remove_bp(struct device *dev);
+ static int bcma_device_uevent(struct device *dev, struct kobj_uevent_env *env);
+ 
+ static ssize_t manuf_show(struct device *dev, struct device_attribute *attr, char *buf)
+@@ -71,7 +72,11 @@ static struct bus_type bcma_bus_type = {
+ 	.name		= "bcma",
+ 	.match		= bcma_bus_match,
+ 	.probe		= bcma_device_probe,
++#if LINUX_VERSION_IS_GEQ(5,15,0)
+ 	.remove		= bcma_device_remove,
++#else
++	.remove		= bcma_device_remove_bp,
++#endif
+ 	.uevent		= bcma_device_uevent,
+ 	.dev_groups	= bcma_device_groups,
+ };
+@@ -625,6 +630,12 @@ static void bcma_device_remove(struct de
+ 	put_device(dev);
+ }
+ 
++static int bcma_device_remove_bp(struct device *dev)
++{
++	bcma_device_remove(dev);
++	return 0;
++}
++
+ static int bcma_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+ {
+ 	struct bcma_device *core = container_of(dev, struct bcma_device, dev);
+--- a/drivers/ssb/main.c
++++ b/drivers/ssb/main.c
+@@ -293,6 +293,13 @@ static void ssb_device_remove(struct dev
+ 	ssb_device_put(ssb_dev);
+ }
+ 
++static int ssb_device_remove_bp(struct device *dev)
++{
++	ssb_device_remove(dev);
++
++	return 0;
++}
++
+ static int ssb_device_probe(struct device *dev)
+ {
+ 	struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
+@@ -388,7 +395,11 @@ static struct bus_type ssb_bustype = {
+ 	.name		= "ssb",
+ 	.match		= ssb_bus_match,
+ 	.probe		= ssb_device_probe,
++#if LINUX_VERSION_IS_GEQ(5,15,0)
+ 	.remove		= ssb_device_remove,
++#else
++	.remove		= ssb_device_remove_bp,
++#endif
+ 	.shutdown	= ssb_device_shutdown,
+ 	.suspend	= ssb_device_suspend,
+ 	.resume		= ssb_device_resume,
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
