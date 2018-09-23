Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:38462 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbeIWXoC (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 19:44:02 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/10] dependencies: make hostap and atmel depend on kernel >= 4.18
Date: Sun, 23 Sep 2018 19:45:31 +0200
Message-Id: <20180923174535.16198-7-hauke@hauke-m.de> (sfid-20180923_194552_062144_6F12F664)
In-Reply-To: <20180923174535.16198-1-hauke@hauke-m.de>
References: <20180923174535.16198-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The hostap and atmel wireless driver now make use of the
proc_create_single_data() function which can not easily be backported.
As these drivers are not used too often just deactivate them on older
kernel versions for now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dependencies b/dependencies
index 42ed0e2f..cd644df7 100644
--- a/dependencies
+++ b/dependencies
@@ -13,8 +13,9 @@ WLCORE 3.2
 WL12XX 3.2
 WL18XX 3.2
 
-# hostapd uses proc_remove()
-HOSTAP 3.10
+# hostapd uses proc_create_single_data()
+HOSTAP 4.18
+ATMEL 4.18
 
 # This driver uses the remove_proc_subtree() function.
 AIRO 3.9
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
