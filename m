Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B1DC4332F
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJKVFM (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJKVFA (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE442315A
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=q91omgqyKRyzZ0rOac/AkunD6L+U3ok8mBQTmaNpjGM=;
        t=1665522295; x=1666731895; b=XqPiTuAEBj+P5rfJqOeff3khDhMQ4IknYfmCIe4sAWBVFGR
        /h5ccQj6dAKEeIgDcqaLuEVeacuEoxCp50X/y5bEV2bVnkeKmaN1W/P+46qwm3EMmlcveLQ+M5K79
        A1fFt6qtLcqA8BShUwadsKTVBbb0t0y5SsR87hClTawXjzhhKIttRMXP7TLpQX9RMZm4T6TfSGHPx
        xz9C6rTbnXmjyphsXzbiqRX+V/6KxZ4fwLOyjZ18B9imPW4qaR1Phybh/jh4dMEZLkA06RUByoVSa
        Bh74gYPUEmvGAvPi20JrkW0JHrpZBVUcl95cw39l2GlCl3s+6Dx5S8POD2EuRqOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQn-0045LP-0c;
        Tue, 11 Oct 2022 23:04:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/38] backports: add DMI_OEM_STRING for older kernels
Date:   Tue, 11 Oct 2022 23:04:24 +0200
Message-Id: <20221011230356.4447b8084079.I56742f3d6a096fd6c246fdf341af68b0962bdb90@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

type=maint
ticket=none

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 backport/backport-include/linux/mod_devicetable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/mod_devicetable.h b/backport/backport-include/linux/mod_devicetable.h
index fc9beedb2d8d..07d66a6ba6ae 100644
--- a/backport/backport-include/linux/mod_devicetable.h
+++ b/backport/backport-include/linux/mod_devicetable.h
@@ -29,4 +29,8 @@ struct mhi_device_id {
 };
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,17,0)
+#define DMI_OEM_STRING (DMI_STRING_MAX + 1)
+#endif /* < 4.17.0 */
+
 #endif /* __BACKPORT_MOD_DEVICETABLE_H */
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
