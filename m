Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E995C43219
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJKVFO (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJKVFB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92C91F616
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Q+AQGgOcVsix3qIYjxcO2OgBd1qGCanSFDyW6du5MX8=;
        t=1665522297; x=1666731897; b=Ar+oNlyvy/v4WLxHHK6iMe7v4h4RFGPbmnKAc1EfO+5Fa5R
        SH27uc374BfEU9h8ro1u//0caHKtaTNRwhFLCOxVBB/XLAviK1b5dB32YC4zqtizL1TkGmcXKoXjm
        cG3sP4X8CNyMrGAIzdzK/hMchuGjlBSR5KisQ9OsbkpkuvKu/UTof6r4iuAgaeswCKaNf8uM3f1F7
        G/PfzTGyx+b0DcSnQptJWvCNsTBvUEsGbeo7htahb8hQ+3P0ibfUvJtschUT+m3vr30mdq250PvUT
        rO3RmpZd7tOx1hEUGZRHj2qiKiDlGsy/UOEsUo14nrdWsIQjCP03kBvYidvOYdEQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQo-0045LP-1I;
        Tue, 11 Oct 2022 23:04:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 20/38] backports: add linux/efi.h
Date:   Tue, 11 Oct 2022 23:04:28 +0200
Message-Id: <20221011230356.a2efbf35f5db.Ib2c8a1b389e6a5b212332e9cda7b0adb369738a5@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We need efi_rt_services_supported() on older kernels now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/efi.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/linux/efi.h

diff --git a/backport/backport-include/linux/efi.h b/backport/backport-include/linux/efi.h
new file mode 100644
index 000000000000..c2ac9dd97947
--- /dev/null
+++ b/backport/backport-include/linux/efi.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Intel Corporation
+ */
+#ifndef __BACKPORT_LINUX_EFI_H
+#define __BACKPORT_LINUX_EFI_H
+#include_next <linux/efi.h>
+
+#ifndef EFI_RT_SUPPORTED_GET_VARIABLE
+#define efi_rt_services_supported(...) efi_enabled(EFI_RUNTIME_SERVICES)
+#endif
+
+#endif /* __BACKPORT_LINUX_EFI_H */
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
