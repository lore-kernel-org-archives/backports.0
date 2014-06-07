Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35217 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbaFGT3d (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Jun 2014 15:29:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 510517E73
	for <backports@vger.kernel.org>; Sat,  7 Jun 2014 21:29:31 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/7] backports: revert rename of __vlan_find_dev_deep()
Date: Sat,  7 Jun 2014 21:29:10 +0200
Message-Id: <1402169356-1267-2-git-send-email-hauke@hauke-m.de> (sfid-20140607_212937_339775_FF306E44)
In-Reply-To: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
References: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function was renamed in this commit in mainline linux:
commit f06c7f9f92295faf701a9628b383156c4efb6119
Author: dingtianhong <dingtianhong@huawei.com>
Date:   Fri May 9 14:58:05 2014 +0800

    vlan: rename __vlan_find_dev_deep() to __vlan_find_dev_deep_rcu()

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/if_vlan.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/if_vlan.h b/backport/backport-include/linux/if_vlan.h
index 6fae150..7d39d52 100644
--- a/backport/backport-include/linux/if_vlan.h
+++ b/backport/backport-include/linux/if_vlan.h
@@ -20,4 +20,8 @@
 #define VLAN_PRIO_SHIFT		13
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
+#define __vlan_find_dev_deep_rcu(real_dev, vlan_proto, vlan_id) __vlan_find_dev_deep(real_dev, vlan_proto, vlan_id)
+#endif
+
 #endif /* __BACKPORT_LINUX_IF_VLAN_H_ */
-- 
1.9.1

