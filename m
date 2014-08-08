Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64426 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756008AbaHHMBW (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 8 Aug 2014 08:01:22 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH] backports: irq_get_trigger_type requires CONFIG_HAVE_GENERIC_HARDIRQS=y
Date: Fri,  8 Aug 2014 14:00:26 +0200
Message-Id: <1407499226-24011-1-git-send-email-sassmann@kpanic.de> (sfid-20140808_140125_548190_F1D8047A)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Only backport irq_get_trigger_type on architectures that have
CONFIG_HAVE_GENERIC_HARDIRQS=y. Otherwise we end up with:

In file included from drivers/pci/msi.c:11:0:
backport/backport-include/linux/irq.h: In function 'irq_get_trigger_type':
backport/backport-include/linux/irq.h:9:9: error: implicit declaration
of function 'irq_get_irq_data' [-Werror=implicit-function-declaration]
  struct irq_data *d = irq_get_irq_data(irq);

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/irq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/irq.h b/backport/backport-include/linux/irq.h
index 1738e9b..29b543b 100644
--- a/backport/backport-include/linux/irq.h
+++ b/backport/backport-include/linux/irq.h
@@ -2,6 +2,7 @@
 #define __BACKPORT_LINUX_IRQ_H
 #include_next <linux/irq.h>
 
+#ifdef CONFIG_HAVE_GENERIC_HARDIRQS
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
 #define irq_get_trigger_type LINUX_BACKPORT(irq_get_trigger_type)
 static inline u32 irq_get_trigger_type(unsigned int irq)
@@ -10,5 +11,6 @@ static inline u32 irq_get_trigger_type(unsigned int irq)
 	return d ? irqd_get_trigger_type(d) : 0;
 }
 #endif
+#endif /* CONFIG_HAVE_GENERIC_HARDIRQS */
 
 #endif /* __BACKPORT_LINUX_IRQ_H */
-- 
1.9.3

