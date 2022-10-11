Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F8CC43217
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJKVF1 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiJKVFF (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CBD3F330
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ep7gDLXKh+lNi8c/tFIW7bawV7AZxzFWRUYoHvj/QgU=;
        t=1665522302; x=1666731902; b=S85jJ0pmpHfucY32ntdPgP++e/VybwF5DSQX3/JKHBSadOU
        LTQ15azvPEXyE33ZofPZzqmI0RilIibKNzOThMLXCuI8PkmZPwNcm7uf7tnrxAEkXCiOR0G7R2Oe/
        oreXANZ28+kq68ikWtaZLkzDd3DomtpVOF/OG4px35s9wrjn/OFr+M0FgE1m0tQMpz2iUw5/RBtUy
        +I40g7owp48C+F3SA9KyzVKrnVQwTJ0gcKubHuK/lqK2mUBTb7FlkQu3FbPKRg+DhoHmDOAyNSn2+
        c35LzQagnKLgJjKjBK0bkDdfk7LfzRTtPmPNErW6SQs9mqvimXhgu4G9S1B06Qbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQt-0045LP-2k;
        Tue, 11 Oct 2022 23:04:59 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 37/38] backports: add thermal_zone_device_enable()
Date:   Tue, 11 Oct 2022 23:04:45 +0200
Message-Id: <20221011230356.89f59316624f.I356df6f58af39de37026dd4df86c21daa9f735b9@changeid>
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
 backport/backport-include/linux/thermal.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index 8210facf3697..f0be1199c5e7 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -3,6 +3,18 @@
 #include_next <linux/thermal.h>
 #include <linux/version.h>
 
+#ifdef CONFIG_THERMAL
+#if LINUX_VERSION_IS_LESS(5,9,0)
+static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
+{ return 0; }
+#endif /* < 5.9.0 */
+#else /* CONFIG_THERMAL */
+#if LINUX_VERSION_IS_LESS(5,9,0)
+static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
+{ return -ENODEV; }
+#endif /* < 5.9.0 */
+#endif /* CONFIG_THERMAL */
+
 #if LINUX_VERSION_IS_LESS(5,9,0)
 #define thermal_zone_device_enable LINUX_BACKPORT(thermal_zone_device_enable)
 static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
