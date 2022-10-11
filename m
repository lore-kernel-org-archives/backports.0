Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA692C4332F
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJKVE6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJKVE6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:04:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECC621247
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9IukzCWtuW8Ze6KFDWzMAH9zqxlQMPnEUQBeIiWgXtw=;
        t=1665522295; x=1666731895; b=lc/LgemNcwsi/iVR1iGY9WBHPw/Pd42CV69MNY+GxGzTWzs
        0c1WOz5rA20WjRZDfRJ8FkI14L4XXjmcObmJK4F2/D0q+lvqFfQ2vcHomAw1TzePHmN+3HH2Xwj7W
        YfV7cjuM5xEiczyBtUMDDHslJzzc9Dmqs0102IYIU7RphQlVe4sxcQyw3MvvfDlDsr2WHQ5HLMJlk
        mah680llEp1lyDb7kQ2kX1qHVuIpJDCZvUx2vbnsfKw04FIitg3GLHYHdsbcP0qx91uPc3EoT8OEW
        Ls7AxHLuEs19nyWPsH1z8T7xkL03a95TrPWIw6b5MDJrntuazOMrtIDYThLDRQ9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQk-0045LP-2P;
        Tue, 11 Oct 2022 23:04:50 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 08/38] backport: update iwl-debug patch
Date:   Tue, 11 Oct 2022 23:04:16 +0200
Message-Id: <20221011230356.782b54edee59.I6eec7e271e27203f0c7bc69672d5d375abd61f9e@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Some code had to be moved around a bit.  Update the patch.

type=maint
ticket=jira:WIFI-175745

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 ...ivers_net_wireless_iwlwifi_iwl-debug.patch | 26 +++----------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch b/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
index 870aa41f7745..e8f943f46395 100644
--- a/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
+++ b/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
@@ -1,6 +1,8 @@
+diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
+index ae4c2a3d63d5..339062da2917 100644
 --- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
 +++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
-@@ -69,13 +69,16 @@ void __iwl_ ##fn(struct device *dev, const char *fmt, ...)	\
+@@ -15,13 +15,16 @@ void __iwl_ ##fn(struct device *dev, const char *fmt, ...)	\
  	struct va_format vaf = {				\
  		.fmt = fmt,					\
  	};							\
@@ -21,27 +23,7 @@
  }
  
  __iwl_fn(warn)
-@@ -94,13 +97,18 @@ void __iwl_err(struct device *dev, bool rfkill_prefix, bool trace_only,
- 	va_list args;
- 
- 	va_start(args, fmt);
--	vaf.va = &args;
- 	if (!trace_only) {
-+		va_list args2;
-+
-+		va_copy(args2, args);
-+		vaf.va = &args2;
- 		if (rfkill_prefix)
- 			dev_err(dev, "(RFKILL) %pV", &vaf);
- 		else
- 			dev_err(dev, "%pV", &vaf);
-+		va_end(args2);
- 	}
-+	vaf.va = &args;
- 	trace_iwlwifi_err(&vaf);
- 	va_end(args);
- }
-@@ -117,12 +125,18 @@ void __iwl_dbg(struct device *dev,
+@@ -73,12 +76,18 @@ void __iwl_dbg(struct device *dev,
  	va_list args;
  
  	va_start(args, fmt);
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
