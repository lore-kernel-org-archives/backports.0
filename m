Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CB5C4332F
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJKVFP (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJKVFA (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC2320BDB
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=cKqpS/MhPr72hUmuZUfiH3UwLZbW8irQyKWeMiRSCz8=;
        t=1665522295; x=1666731895; b=SdhW05CNHMsSrns57cQcorMIBBncuI5v6t8TVIxa7IDcyev
        CCqYXM4XFyID9fB14n4U83cFag3vbTRo/e332F3SRXLeLI5qNzGOTFUhJLhxYge+4G2z+Er+Kh/mJ
        TTp6GH9L03GkZ2hBIBEswGhbC/s+dUz4RqaVHX0bxdjSg40hkNq/MtypaQxmoMqULf5F4VknFdfxh
        OB941AAvKfvid/SWv/E/n7LPsDL+IZRwg5qmuneRKjgGLUzTl5Mc1lN7C/Gvfz63ksnSn2TK0O1rr
        v3pVSslxasB2B7+szBDYsORLhGIywsUHgl5k8lgYWXRn40T/J1G4AjrtYYAEr2VA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQi-0045LP-2P;
        Tue, 11 Oct 2022 23:04:48 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 01/38] backport: update pv trace fixes patch
Date:   Tue, 11 Oct 2022 23:04:09 +0200
Message-Id: <20221011230356.adb82cf94151.Iad456095473d72f9fa005814c81b0b45be8e49a5@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

One argument was removed from a trace, so the old patch was not
applying anymore.  Update it.

type=maint
ticket=jira:WIFI-85592

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/135575
---
 ...ivers_net_wireless_iwlwifi_iwl-debug.patch | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch

diff --git a/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch b/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
new file mode 100644
index 000000000000..870aa41f7745
--- /dev/null
+++ b/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
@@ -0,0 +1,64 @@
+--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
++++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
+@@ -69,13 +69,16 @@ void __iwl_ ##fn(struct device *dev, const char *fmt, ...)	\
+ 	struct va_format vaf = {				\
+ 		.fmt = fmt,					\
+ 	};							\
+-	va_list args;						\
++	va_list args1, args2;					\
+ 								\
+-	va_start(args, fmt);					\
+-	vaf.va = &args;						\
++	va_start(args1, fmt);					\
++	va_copy(args2, args1);					\
++	vaf.va = &args2;					\
+ 	dev_ ##fn(dev, "%pV", &vaf);				\
++	va_end(args2);						\
++	vaf.va = &args1;					\
+ 	trace_iwlwifi_ ##fn(&vaf);				\
+-	va_end(args);						\
++	va_end(args1);						\
+ }
+ 
+ __iwl_fn(warn)
+@@ -94,13 +97,18 @@ void __iwl_err(struct device *dev, bool rfkill_prefix, bool trace_only,
+ 	va_list args;
+ 
+ 	va_start(args, fmt);
+-	vaf.va = &args;
+ 	if (!trace_only) {
++		va_list args2;
++
++		va_copy(args2, args);
++		vaf.va = &args2;
+ 		if (rfkill_prefix)
+ 			dev_err(dev, "(RFKILL) %pV", &vaf);
+ 		else
+ 			dev_err(dev, "%pV", &vaf);
++		va_end(args2);
+ 	}
++	vaf.va = &args;
+ 	trace_iwlwifi_err(&vaf);
+ 	va_end(args);
+ }
+@@ -117,12 +125,18 @@ void __iwl_dbg(struct device *dev,
+ 	va_list args;
+ 
+ 	va_start(args, fmt);
+-	vaf.va = &args;
+ #ifdef CONFIG_IWLWIFI_DEBUG
+ 	if (iwl_have_debug_level(level) &&
+-	    (!limit || net_ratelimit()))
++	    (!limit || net_ratelimit())) {
++		va_list args2;
++
++		va_copy(args2, args);
++		vaf.va = &args2;
+ 		dev_printk(KERN_DEBUG, dev, "%s %pV", function, &vaf);
++		va_end(args2);
++	}
+ #endif
++	vaf.va = &args;
+ 	trace_iwlwifi_dbg(level, function, &vaf);
+ 	va_end(args);
+ }
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
