Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:45460
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753066Ab3HWBGp (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 22 Aug 2013 21:06:45 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: backports@vger.kernel.org
Cc: Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH] backports:  Actually export the 2.6.34 sdio compat symbols
Date: Thu, 22 Aug 2013 21:06:33 -0400
Message-Id: <1377219993-3517-1-git-send-email-pizza@shaftnet.org> (sfid-20130823_030647_313762_3E663354)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

sdio_get_host_pm_caps() and sdio_set_host_pm_flags() were defined
in compat-2.6.34 but not actually exported for other modules to use.

The cw1200 driver needs sdio_set_host_pm_flags() properly exported.

Signed-off-by: Solomon Peachy <pizza@shaftnet.org>
---
 backport/compat/compat-2.6.34.c | 2 ++
 dependencies                    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/backport/compat/compat-2.6.34.c b/backport/compat/compat-2.6.34.c
index b257df1..4ae7f9a 100644
--- a/backport/compat/compat-2.6.34.c
+++ b/backport/compat/compat-2.6.34.c
@@ -23,11 +23,13 @@ mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func)
 {
 	return backport_mmc_pm_flags;
 }
+EXPORT_SYMBOL_GPL(sdio_get_host_pm_caps);
 
 int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
 {
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
 
 /**
  * seq_hlist_start - start an iteration of a hlist
diff --git a/dependencies b/dependencies
index 9bd5763..043a2d5 100644
--- a/dependencies
+++ b/dependencies
@@ -36,7 +36,7 @@ P54_SPI 2.6.25
 WL1251_SDIO 2.6.37
 WLCORE_SDIO 2.6.38
 
-CW1200_WLAN_SDIO 2.6.34
+CW1200_WLAN_SDIO 2.6.32
 CW1200_WLAN_SPI 2.6.35
 
 BRCMFMAC 2.6.29
-- 
1.8.3.1

