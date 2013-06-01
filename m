Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:33265 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593Ab3FAQAv (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 1 Jun 2013 12:00:51 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/11] backports: protect irq_set_irq_type()
Date: Sat,  1 Jun 2013 18:00:15 +0200
Message-Id: <1370102417-6711-10-git-send-email-hauke@hauke-m.de> (sfid-20130601_181042_543614_4939B988)
In-Reply-To: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
References: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

irq_set_irq_type is defined to set_irq_type in RHEL 6.4.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/irq.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/irq.h b/backport/backport-include/linux/irq.h
index 357d688..5d7326f 100644
--- a/backport/backport-include/linux/irq.h
+++ b/backport/backport-include/linux/irq.h
@@ -16,10 +16,12 @@ static inline int irq_set_chip_data(unsigned int irq, void *data)
 {
 	return set_irq_chip_data(irq, data);
 }
+#ifndef irq_set_irq_type
 static inline int irq_set_irq_type(unsigned int irq, unsigned int type)
 {
 	return set_irq_type(irq, type);
 }
+#endif
 static inline int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry)
 {
 	return set_irq_msi(irq, entry);
-- 
1.7.10.4

