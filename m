Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56147 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757274AbcGJVPA (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:15:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/19] patches: do not call of_irq_* functions on kernel < 3.13 in bcma
Date: Sun, 10 Jul 2016 23:14:37 +0200
Message-Id: <1468185285-28265-12-git-send-email-hauke@hauke-m.de> (sfid-20160710_231506_400416_C99F0FBF)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These functions where added in kernel renamed in kernel 3.13 and the
signature changed. I am not aware of any user of these functions in
such old kernel versions, just remove the part.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0069-remove-of_irq/bcma.patch          | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0069-remove-of_irq/bcma.patch

diff --git a/patches/collateral-evolutions/network/0069-remove-of_irq/bcma.patch b/patches/collateral-evolutions/network/0069-remove-of_irq/bcma.patch
new file mode 100644
index 0000000..351c0fd
--- /dev/null
+++ b/patches/collateral-evolutions/network/0069-remove-of_irq/bcma.patch
@@ -0,0 +1,26 @@
+diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
+index 1f63547..14bae02 100644
+--- a/drivers/bcma/main.c
++++ b/drivers/bcma/main.c
+@@ -156,6 +156,7 @@ static struct device_node *bcma_of_find_
+ 	return NULL;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+ static int bcma_of_irq_parse(struct platform_device *parent,
+ 			     struct bcma_device *core,
+ 			     struct of_phandle_args *out_irq, int num)
+@@ -195,6 +196,13 @@ static unsigned int bcma_of_get_irq(stru
+ 
+ 	return irq_create_of_mapping(&out_irq);
+ }
++#else
++static unsigned int bcma_of_get_irq(struct platform_device *parent,
++				    struct bcma_device *core, int num)
++{
++	return 0;
++}
++#endif
+ 
+ static void bcma_of_fill_device(struct platform_device *parent,
+ 				struct bcma_device *core)
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
