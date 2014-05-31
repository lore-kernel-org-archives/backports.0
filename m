Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55990 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbaEaRQk (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:16:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 9ED947E32
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:16:38 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/13] backports: fix build if CPTCFG_IEEE802154_6LOWPAN=m
Date: Sat, 31 May 2014 19:15:59 +0200
Message-Id: <1401556570-3363-3-git-send-email-hauke@hauke-m.de> (sfid-20140531_191641_278025_ED4EFC6D)
In-Reply-To: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
References: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

CPTCFG_IEEE802154_6LOWPAN is only defined when it is set to be build
into the kernel, which is not possible in backprots, when it is build
as a module CPTCFG_IEEE802154_6LOWPAN_MODULE is set and this should be
checked with IS_ENABLED().

This fixes commit:
commit 66fffbc48eeb256d7a3147cffd491a60a655b136
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Mon May 5 14:46:11 2014 +0200

    backports: provide net_ieee802154_lowpan only when needed

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/net_namespace.h | 2 +-
 backport/compat/backport-3.15.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index ad0f030..17c9d55 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -3,7 +3,7 @@
 
 #include_next <net/net_namespace.h>
 
-#ifdef CPTCFG_IEEE802154_6LOWPAN
+#if IS_ENABLED(CPTCFG_IEEE802154_6LOWPAN)
 #include <linux/version.h>
 #include <net/netns/ieee802154_6lowpan.h>
 
diff --git a/backport/compat/backport-3.15.c b/backport/compat/backport-3.15.c
index 3492260..5732fa9 100644
--- a/backport/compat/backport-3.15.c
+++ b/backport/compat/backport-3.15.c
@@ -15,7 +15,7 @@
 #include <linux/string.h>
 #include <net/net_namespace.h>
 
-#ifdef CPTCFG_IEEE802154_6LOWPAN
+#if IS_ENABLED(CPTCFG_IEEE802154_6LOWPAN)
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
 /* the above kernel dependency is set to match the dependencies file */
 struct netns_ieee802154_lowpan ieee802154_lowpan;
-- 
1.9.1

