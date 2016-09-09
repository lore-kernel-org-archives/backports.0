Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:53454 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753313AbcIIUAW (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 9 Sep 2016 16:00:22 -0400
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] backport: bcma: restore old behaviour for kernels lacking of_dma_configure()
Date: Fri,  9 Sep 2016 20:59:51 +0100
Message-Id: <1473451191-22767-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20160909_220025_362975_B19EED40)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The function of_dma_configure() was recently added to bcma by
commit defb893fffef ("bcma: use of_dma_configure() to set initial dma
mask") which is available since v4.1 kernel. Providing a full backport
of that function is tricky so patching bcma to get behaviour as before
the mentioned commit.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../backport-adjustments/bcma_of_dma_configure.patch | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 patches/backport-adjustments/bcma_of_dma_configure.patch

diff --git a/patches/backport-adjustments/bcma_of_dma_configure.patch b/patches/backport-adjustments/bcma_of_dma_configure.patch
new file mode 100644
index 0000000..e1da42f
--- /dev/null
+++ b/patches/backport-adjustments/bcma_of_dma_configure.patch
@@ -0,0 +1,19 @@
+diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
+index 2c1798e..6060a57 100644
+--- a/drivers/bcma/main.c
++++ b/drivers/bcma/main.c
+@@ -209,8 +209,11 @@ static void bcma_of_fill_device(struct platform_device *parent,
+		core->dev.of_node = node;
+
+	core->irq = bcma_of_get_irq(parent, core, 0);
+-
++#if LINUX_VERSION_CODE > KERNEL_VERSION(4,0,0)
+	of_dma_configure(&core->dev, node);
++#else
++	core->dev.dma_mask = &core->dev.coherent_dma_mask;
++#endif
+ }
+
+ unsigned int bcma_core_irq(struct bcma_device *core, int num)
+--
+1.9.1
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
