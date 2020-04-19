Return-Path: <SRS0=xZrn=6D=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ECFC54FCC
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF85A21927
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgDSRLF (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:11:05 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:15402 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgDSRLF (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 19 Apr 2020 13:11:05 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 494xDk25yVzQlGt;
        Sun, 19 Apr 2020 19:11:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id jgMEkX5Q9Va2; Sun, 19 Apr 2020 19:10:59 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/8] patches: patches: Restrict MTU changes to struct net_device
Date:   Sun, 19 Apr 2020 19:10:39 +0200
Message-Id: <20200419171039.17268-9-hauke@hauke-m.de>
In-Reply-To: <20200419171039.17268-1-hauke@hauke-m.de>
References: <20200419171039.17268-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5EC5E175E
X-Rspamd-Score: -5.43 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The struct ieee80211_hw got a max_mtu element, but no min_mtu element.
This spatch was also applied to this structure accidentally.

This adds the type to make sure this spatch is only applied to mtu_min
and mtu_max attributes on the net_device structure.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0073-netdevice-mtu-range.cocci        | 6 +++---
 patches/0074-netdevice-mtu-range-ifdefs.cocci | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/patches/0073-netdevice-mtu-range.cocci b/patches/0073-netdevice-mtu-range.cocci
index 7a4b6532..7afe900e 100644
--- a/patches/0073-netdevice-mtu-range.cocci
+++ b/patches/0073-netdevice-mtu-range.cocci
@@ -4,7 +4,7 @@
 first_ops = 0
 
 @both@
-expression ndevexp;
+struct net_device *ndevexp;
 constant e1, e2;
 identifier func;
 position p;
@@ -17,7 +17,7 @@ func(...) {
 }
 
 @@
-expression ndevexp;
+struct net_device *ndevexp;
 constant MAX;
 identifier func;
 position p != both.p;
@@ -58,7 +58,7 @@ if not(first_ops == ln):
   cocci.include_match(False)
 
 @r1 exists@
-expression ndevexp;
+struct net_device *ndevexp;
 constant e1, e2;
 identifier func;
 @@
diff --git a/patches/0074-netdevice-mtu-range-ifdefs.cocci b/patches/0074-netdevice-mtu-range-ifdefs.cocci
index 5689f438..bb1ca95c 100644
--- a/patches/0074-netdevice-mtu-range-ifdefs.cocci
+++ b/patches/0074-netdevice-mtu-range-ifdefs.cocci
@@ -1,5 +1,5 @@
 @@
-expression ndevexp;
+struct net_device *ndevexp;
 expression E;
 identifier func;
 @@
@@ -12,7 +12,7 @@ func(...) {
 }
 
 @@
-expression ndevexp;
+struct net_device *ndevexp;
 expression E;
 identifier func;
 @@
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
