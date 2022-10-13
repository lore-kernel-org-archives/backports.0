Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63010C4167E
	for <backports@archiver.kernel.org>; Thu, 13 Oct 2022 08:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJMIx7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJMIx4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 13 Oct 2022 04:53:56 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D77216EB52
        for <backports@vger.kernel.org>; Thu, 13 Oct 2022 01:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3WGQuQk78TaSsloBVJavkw4wDC8zsf8vp0TXUpvZQI4=; b=NySazZ98Rz9bp0+9Ec4oi7q/dY
        cipDSBvXLxVFNgYDkk/FaW0YCLs3EcnMElJXjFnWDPAD/OTrucNhraqkBmq09rzIIEEJrnYr/QSxT
        bxb2lCRe+MqWHVkv8eb9Ngk4i22JUb8diAanuWrMw7goCDsgQP7jhDFk8OpBq8s4fD5E=;
Received: from p200300daa7301d0028e1e1004b08c350.dip0.t-ipconnect.de ([2003:da:a730:1d00:28e1:e100:4b08:c350] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oityS-00CO7a-V9
        for backports@vger.kernel.org; Thu, 13 Oct 2022 10:53:53 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     backports@vger.kernel.org
Subject: [PATCH 5/8] headers: backport mmc_sw_reset and mmc_hw_reset API changes
Date:   Thu, 13 Oct 2022 10:53:48 +0200
Message-Id: <20221013085351.14516-5-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221013085351.14516-1-nbd@nbd.name>
References: <20221013085351.14516-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/mmc/core.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 backport/backport-include/linux/mmc/core.h

diff --git a/backport/backport-include/linux/mmc/core.h b/backport/backport-include/linux/mmc/core.h
new file mode 100644
index 000000000000..525994c27e06
--- /dev/null
+++ b/backport/backport-include/linux/mmc/core.h
@@ -0,0 +1,22 @@
+#ifndef __BACKPORT_LINUX_MMC_CORE_H
+#define __BACKPORT_LINUX_MMC_CORE_H
+
+#include_next <linux/mmc/card.h>
+#include_next <linux/mmc/core.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(5,19,0)
+static inline int backport_mmc_sw_reset(struct mmc_card *card)
+{
+	return mmc_sw_reset(card->host);
+}
+#define mmc_sw_reset LINUX_BACKPORT(mmc_sw_reset)
+
+static inline int backport_mmc_hw_reset(struct mmc_card *card)
+{
+	return mmc_hw_reset(card->host);
+}
+#define mmc_hw_reset LINUX_BACKPORT(mmc_hw_reset)
+#endif /* <5.19 */
+
+#endif
-- 
2.36.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
