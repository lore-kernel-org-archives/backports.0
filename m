Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5839BC83014
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1611320709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="rI9C0oW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgLAWF4 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgLAWFz (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:55 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FE3C061A4E
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:41 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Clx3D3kwfzQlM3;
        Tue,  1 Dec 2020 23:04:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lh3Du0G5XwRcSJ9EYIURtDypBjeeEsx5ovTyY480AYQ=;
        b=rI9C0oW0MQXSCQBbSNcGNwaZVk5Wm9paDPY9B68xkvRQtTj1xzZGTatxDVix4/cgX/2j8v
        ZUy9bYFj50LWrRvvSXdCniuBrwMVOWfZcl4P4vIVOEUHxOTUZ/8TTog/czH/BPLt0P87Ya
        IN61ev09HsCDj2Owa2yUZUZ260bieHPn1rv0Js6vpe3MM7azecZa4rqcUSxXxG2ylmDPsC
        N6/MYM+EOLVTgvlHIu85O/8lpYCUm5QJREgtPGxU7LT9tu/H+gggd5ObaA2yq9EZk1kys/
        UltkOU8uHLbBs0OvVgfuFFcqyzvdEYtN7UFot96+PRACrN3abHlfmbfYmpW2/w==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id K8czIsLuzmIC; Tue,  1 Dec 2020 23:04:37 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 20/30] patches: Remove unneeded 0018-pv-trace-fixes patch
Date:   Tue,  1 Dec 2020 23:04:05 +0100
Message-Id: <20201201220415.30582-21-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.12 / 15.00 / 15.00
X-Rspamd-Queue-Id: A34EB17BD
X-Rspamd-UID: bc58e7
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This patch is not applying any more and is only needed for kernel < 3.1
which is unsupported for some time by now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0018-pv-trace-fixes/INFO              |  7 --
 ...ivers_net_wireless_iwlwifi_iwl-debug.patch | 65 ---------------
 .../net_mac80211_trace.patch                  | 79 -------------------
 3 files changed, 151 deletions(-)
 delete mode 100644 patches/0018-pv-trace-fixes/INFO
 delete mode 100644 patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
 delete mode 100644 patches/0018-pv-trace-fixes/net_mac80211_trace.patch

diff --git a/patches/0018-pv-trace-fixes/INFO b/patches/0018-pv-trace-fixes/INFO
deleted file mode 100644
index a2c89e92..00000000
--- a/patches/0018-pv-trace-fixes/INFO
+++ /dev/null
@@ -1,7 +0,0 @@
-In recent kernels, %pV will copy the va_list before using it.
-This isn't true for all kernels, so copy the va_list for use
-by the dev_*() functions, otherwise the kernel will crash if
-the message is printed and traced.
-
-This is required for kernels <= 3.1, as otherwise it would
-those kernels would crash.
diff --git a/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch b/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
deleted file mode 100644
index d323f7ad..00000000
--- a/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
+++ /dev/null
@@ -1,65 +0,0 @@
---- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
-+++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
-@@ -69,13 +69,16 @@ void __iwl_ ##fn(struct device *dev, con
- 	struct va_format vaf = {				\
- 		.fmt = fmt,					\
- 	};							\
--	va_list args;						\
-+	va_list args1, args2;					\
- 								\
--	va_start(args, fmt);					\
--	vaf.va = &args;						\
-+	va_start(args1, fmt);					\
-+	va_copy(args2, args1);					\
-+	vaf.va = &args2;					\
- 	dev_ ##fn(dev, "%pV", &vaf);				\
-+	va_end(args2);						\
-+	vaf.va = &args1;					\
- 	trace_iwlwifi_ ##fn(&vaf);				\
--	va_end(args);						\
-+	va_end(args1);						\
- }
- 
- __iwl_fn(warn)
-@@ -94,13 +97,18 @@ void __iwl_err(struct device *dev, bool
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
-@@ -117,13 +125,19 @@ void __iwl_dbg(struct device *dev,
- 	va_list args;
- 
- 	va_start(args, fmt);
--	vaf.va = &args;
- #ifdef CONFIG_IWLWIFI_DEBUG
- 	if (iwl_have_debug_level(level) &&
--	    (!limit || net_ratelimit()))
-+	    (!limit || net_ratelimit())) {
-+		va_list args2;
-+
-+		va_copy(args2, args);
-+		vaf.va = &args2;
- 		dev_printk(KERN_DEBUG, dev, "%c %s %pV",
- 			   in_interrupt() ? 'I' : 'U', function, &vaf);
-+		va_end(args2);
-+	}
- #endif
-+	vaf.va = &args;
- 	trace_iwlwifi_dbg(level, in_interrupt(), function, &vaf);
- 	va_end(args);
- }
diff --git a/patches/0018-pv-trace-fixes/net_mac80211_trace.patch b/patches/0018-pv-trace-fixes/net_mac80211_trace.patch
deleted file mode 100644
index 8b3f7afd..00000000
--- a/patches/0018-pv-trace-fixes/net_mac80211_trace.patch
+++ /dev/null
@@ -1,79 +0,0 @@
---- a/net/mac80211/trace.c
-+++ b/net/mac80211/trace.c
-@@ -17,12 +17,16 @@ void __sdata_info(const char *fmt, ...)
- 	struct va_format vaf = {
- 		.fmt = fmt,
- 	};
--	va_list args;
-+	va_list args, args2;
- 
- 	va_start(args, fmt);
--	vaf.va = &args;
- 
-+	va_copy(args2, args);
-+	vaf.va = &args2;
- 	pr_info("%pV", &vaf);
-+	va_end(args2);
-+
-+	vaf.va = &args;
- 	trace_mac80211_info(&vaf);
- 	va_end(args);
- }
-@@ -35,10 +39,16 @@ void __sdata_dbg(bool print, const char
- 	va_list args;
- 
- 	va_start(args, fmt);
--	vaf.va = &args;
- 
--	if (print)
-+	if (print) {
-+		va_list args2;
-+
-+		va_copy(args2, args);
-+		vaf.va = &args2;
- 		pr_debug("%pV", &vaf);
-+		va_end(args2);
-+	}
-+	vaf.va = &args;
- 	trace_mac80211_dbg(&vaf);
- 	va_end(args);
- }
-@@ -48,12 +58,16 @@ void __sdata_err(const char *fmt, ...)
- 	struct va_format vaf = {
- 		.fmt = fmt,
- 	};
--	va_list args;
-+	va_list args, args2;
- 
- 	va_start(args, fmt);
--	vaf.va = &args;
- 
-+	va_copy(args2, args);
-+	vaf.va = &args2;
- 	pr_err("%pV", &vaf);
-+	va_end(args2);
-+
-+	vaf.va = &args;
- 	trace_mac80211_err(&vaf);
- 	va_end(args);
- }
-@@ -66,10 +80,16 @@ void __wiphy_dbg(struct wiphy *wiphy, bo
- 	va_list args;
- 
- 	va_start(args, fmt);
--	vaf.va = &args;
- 
--	if (print)
--		wiphy_dbg(wiphy, "%pV", &vaf);
-+	if (print) {
-+		va_list args2;
-+
-+		va_copy(args2, args);
-+		vaf.va = &args2;
-+		pr_debug("%pV", &vaf);
-+		va_end(args2);
-+	}
-+	vaf.va = &args;
- 	trace_mac80211_dbg(&vaf);
- 	va_end(args);
- }
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
