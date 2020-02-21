Return-Path: <SRS0=6Pme=4J=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13CEC35647
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9B42067D
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbgBUI4f (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:56:35 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54722 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbgBUI4f (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Feb 2020 03:56:35 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j546q-00EncU-Tn; Fri, 21 Feb 2020 09:56:33 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/15] patches: make nl80211.c include if_vlan.h
Date:   Fri, 21 Feb 2020 09:56:16 +0100
Message-Id: <20200221095437.e96fb1098bd4.Id24cee4c680b685966d9cb78c08671ac18b75983@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221085624.6213-1-johannes@sipsolutions.net>
References: <20200221085624.6213-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On upstream it gets it through some include maze, until that's
fixed, just patch it in.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0093-nl80211-vlan.patch | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/0093-nl80211-vlan.patch

diff --git a/patches/0093-nl80211-vlan.patch b/patches/0093-nl80211-vlan.patch
new file mode 100644
index 000000000000..c1f8dac13125
--- /dev/null
+++ b/patches/0093-nl80211-vlan.patch
@@ -0,0 +1,12 @@
+diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
+index ae8e3d9575d3..15c0e3c5c979 100644
+--- a/net/wireless/nl80211.c
++++ b/net/wireless/nl80211.c
+@@ -20,6 +20,7 @@
+ #include <linux/netlink.h>
+ #include <linux/nospec.h>
+ #include <linux/etherdevice.h>
++#include <linux/if_vlan.h>
+ #include <net/net_namespace.h>
+ #include <net/genetlink.h>
+ #include <net/cfg80211.h>
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
