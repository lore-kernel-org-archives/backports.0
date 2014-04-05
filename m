Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:34328 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMli (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:41:38 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so4660535pbc.4
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:41:37 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 06/27] backports: bump kernel reqs for WL1251_SDIO and WLCORE_SDIO
Date: Sat,  5 Apr 2014 05:40:40 -0700
Message-Id: <1396701662-15165-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144140_272529_4B47EF11)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

There has been quite a bit of updates to the gpio driver library,
and while we can backport some of this it doesn't make much sense
as folks using this driver are expected to be carrying over the
required architecture changes. In particular the GPIO_DEVRES has
been tucked under GPIO_LIB and later removed from depending on it
(see b69ac5244 and 6a89a314a)

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains 6a89a314a
v3.9-rc1~76^2~12^2~13

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains b69ac5244
v3.13-rc1~120^2~7

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dependencies b/dependencies
index 13e8a75..91bf503 100644
--- a/dependencies
+++ b/dependencies
@@ -33,8 +33,8 @@ CARL9170 2.6.29
 # depends on -EPROBE_DEFER and others now
 WL1251_SPI 3.5
 
-WL1251_SDIO 2.6.37
-WLCORE_SDIO 2.6.38
+WL1251_SDIO 3.15
+WLCORE_SDIO 3.15
 
 CW1200_WLAN_SDIO 2.6.32
 CW1200_WLAN_SPI 2.6.35
-- 
1.8.5.3

