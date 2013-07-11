Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44177 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756812Ab3GKWMX (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:23 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 05/19] backports: BCMA and SSB MIPS drivers are depending on kernel >= 3.3
Date: Fri, 12 Jul 2013 00:11:28 +0200
Message-Id: <1373580702-24752-7-git-send-email-hauke@hauke-m.de> (sfid-20130712_001233_763477_7DB40242)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Upstream commit 1ea075ea8dd98a5cc21d3d79ff0204797bb78eb5

The bcma and ssb mips driver are depending on kernel 3.3.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index ab18807..ea75be8 100644
--- a/dependencies
+++ b/dependencies
@@ -175,6 +175,9 @@ BT 2.6.29
 # this is easier.
 BCMA_DRIVER_GPIO 3.0
 
+BCMA_DRIVER_MIPS 3.3
+SSB_DRIVER_MIPS 3.3
+
 # rfkill-regulator uses a kernel header file
 # (rfkill-regulator.h) that we don't backport
 # right now, so make it depend on 3.0
-- 
1.7.10.4

