Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35230 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407AbaFGT3h (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Jun 2014 15:29:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id EFDD47E57
	for <backports@vger.kernel.org>; Sat,  7 Jun 2014 21:29:35 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/7] backports: rename irq_get_trigger_type()
Date: Sat,  7 Jun 2014 21:29:12 +0200
Message-Id: <1402169356-1267-4-git-send-email-hauke@hauke-m.de> (sfid-20140607_212938_661252_EBE4D38B)
In-Reply-To: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
References: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This should avoid possible name conflicts.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/irq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/linux/irq.h b/backport/backport-include/linux/irq.h
index 8b2804d..1738e9b 100644
--- a/backport/backport-include/linux/irq.h
+++ b/backport/backport-include/linux/irq.h
@@ -3,6 +3,7 @@
 #include_next <linux/irq.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+#define irq_get_trigger_type LINUX_BACKPORT(irq_get_trigger_type)
 static inline u32 irq_get_trigger_type(unsigned int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
-- 
1.9.1

