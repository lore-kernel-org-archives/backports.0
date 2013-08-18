Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60826 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755719Ab3HRXiW (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:38:22 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Patrick Ziegler <patrick.ziegler@fh-kl.de>
Subject: [PATCH v2 03/19] backports: add missing include for is_valid_ether_addr()
Date: Mon, 19 Aug 2013 01:37:48 +0200
Message-Id: <1376869084-16513-4-git-send-email-hauke@hauke-m.de> (sfid-20130819_013823_443116_F53D93EA)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

is_valid_ether_addr() is used, but the header here it is declared was
not included.

This fixes a problem introduced in commit:
commit 521acfd92f168fc9b8b6a1cefe9a165243f3d872
Author: Patrick Ziegler <patrick.ziegler@fh-kl.de>
Date:   Thu Aug 15 14:40:09 2013 +0200

    backports: add eth_prepare_mac_addr_change() and eth_commit_mac_addr_change()

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/compat/compat-3.9.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/compat/compat-3.9.c b/backport/compat/compat-3.9.c
index ba8e3cf..d85a79f 100644
--- a/backport/compat/compat-3.9.c
+++ b/backport/compat/compat-3.9.c
@@ -15,6 +15,7 @@
 #include <linux/netdevice.h>
 #include <linux/if.h>
 #include <linux/if_ether.h>
+#include <linux/etherdevice.h>
 
 #ifdef __sg_page_iter_next
 
-- 
1.7.10.4

