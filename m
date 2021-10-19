Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54E7C43219
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9940161052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhJSVqM (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhJSVqI (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:08 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79EEC06161C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:55 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HYnLd6bgjzQk1x;
        Tue, 19 Oct 2021 23:43:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yzgSTNxx009WCjQLr0wMQdd6HG08XZQKoqI2f0/vhE=;
        b=GlT4iTtWtOt24FY9xOPyS0ooM1oikVasjzsa0z9NnpeQ9KwpWvLvBgvnok10UWuN2mTsBM
        xj/llbXJm7QB3WgWtDcIXLr8nl5pJR74i8YfaV7EYc4lA16/0yhMFLJweyO7MIRGmqkamq
        yrkWAblergaH6D29F7qUKTqbmLmcs80ZKP2ymaZHn260RhCKq7bR45LBCZGcKUIVNiTu1t
        T2GyxjdpAc1KiF3iW7tzVOpZwm+0skkbz10EFs1JvyBexl8p4b7qJdqz99omzaEumrYDU6
        GEyxAsCTm+fcnE+A1J0nnTiznbhXuIAFZ3oeDeL/K6xeFMjM0MTmS1bIUJ5oCw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 41/47] patches: Do not set mhi_controller->reg_len on older kernel versions
Date:   Tue, 19 Oct 2021 23:43:14 +0200
Message-Id: <20211019214320.2035704-42-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3947D569
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

With kernel 5.15 struct mhi_controller got a new attribute reg_len to
check that the register length is correct. Do not set it on older kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0104-mhi-reg-len.patch | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/0104-mhi-reg-len.patch

diff --git a/patches/0104-mhi-reg-len.patch b/patches/0104-mhi-reg-len.patch
new file mode 100644
index 00000000..32d1e55a
--- /dev/null
+++ b/patches/0104-mhi-reg-len.patch
@@ -0,0 +1,12 @@
+--- a/drivers/net/wireless/ath/ath11k/mhi.c
++++ b/drivers/net/wireless/ath/ath11k/mhi.c
+@@ -330,7 +330,9 @@ int ath11k_mhi_register(struct ath11k_pc
+ 	mhi_ctrl->cntrl_dev = ab->dev;
+ 	mhi_ctrl->fw_image = ab_pci->amss_path;
+ 	mhi_ctrl->regs = ab->mem;
++#if LINUX_VERSION_IS_GEQ(5,15,0)
+ 	mhi_ctrl->reg_len = ab->mem_len;
++#endif
+ 
+ 	ret = ath11k_mhi_get_msi(ab_pci);
+ 	if (ret) {
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
