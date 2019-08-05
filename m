Return-Path: <SRS0=hnMY=WB=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE4AC433FF
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9041C2086D
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfHEMIT (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:08:19 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:19338 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEMIT (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Aug 2019 08:08:19 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id D2870A1538;
        Mon,  5 Aug 2019 14:08:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id 8GazmMGDOFqm; Mon,  5 Aug 2019 14:08:04 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/12] patches: Add include in cfg80211.h
Date:   Mon,  5 Aug 2019 14:07:01 +0200
Message-Id: <20190805120704.13128-10-hauke@hauke-m.de>
In-Reply-To: <20190805120704.13128-1-hauke@hauke-m.de>
References: <20190805120704.13128-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

cfg80211.h uses struct nla_policy in two places, but does not include
net/netlink.h directly. Because of this missing include the rename to
struct nla_backport_policy is not applied and this results in type
mismatch errors when compiling backports. With this additional include
the type is renamed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0013-fix-makefile-includes/cfg80211.patch    | 16 ++++++++++++++++
 patches/0053-possible_net_t.patch                |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 patches/0013-fix-makefile-includes/cfg80211.patch

diff --git a/patches/0013-fix-makefile-includes/cfg80211.patch b/patches/0013-fix-makefile-includes/cfg80211.patch
new file mode 100644
index 00000000..ba4f0825
--- /dev/null
+++ b/patches/0013-fix-makefile-includes/cfg80211.patch
@@ -0,0 +1,16 @@
+cfg80211.h uses struct nla_policy in two places, but does not include 
+net/netlink.h directly. Because of this missing include the rename to 
+struct nla_backport_policy is not applied and this results in type 
+mismatch errors when compiling backports. With this additional include 
+the type is renamed.
+
+--- a/include/net/cfg80211.h
++++ b/include/net/cfg80211.h
+@@ -21,6 +21,7 @@
+ #include <linux/ieee80211.h>
+ #include <linux/net.h>
+ #include <net/regulatory.h>
++#include <net/netlink.h>
+ 
+ /**
+  * DOC: Introduction
diff --git a/patches/0053-possible_net_t.patch b/patches/0053-possible_net_t.patch
index 4d9f0cfd..06873e3b 100644
--- a/patches/0053-possible_net_t.patch
+++ b/patches/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -4581,12 +4581,12 @@ struct wiphy {
+@@ -4582,12 +4582,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
