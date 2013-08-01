Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:49728 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756482Ab3HAP7H (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 1 Aug 2013 11:59:07 -0400
Message-ID: <51FA85C4.4060400@fh-kl.de> (sfid-20130801_175908_911184_4BC86E41)
Date: Thu, 1 Aug 2013 17:59:00 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [RFC v3 1/9] backports: fix build errors for old kernel versions
 without PCI support
References: <cover.1375372668.git.patrick.ziegler@fh-kl.de>
In-Reply-To: <cover.1375372668.git.patrick.ziegler@fh-kl.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/compat/compat-2.6.25.c | 4 ++++
 backport/compat/compat-2.6.28.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/backport/compat/compat-2.6.25.c b/backport/compat/compat-2.6.25.c
index b3597ea..169a555 100644
--- a/backport/compat/compat-2.6.25.c
+++ b/backport/compat/compat-2.6.25.c
@@ -212,9 +212,13 @@ EXPORT_SYMBOL_GPL(sg_alloc_table);
  */
 int pci_enable_device_mem(struct pci_dev *dev)
 {
+#ifdef CONFIG_PCI
 	int bars = pci_select_bars(dev, IORESOURCE_MEM);
 
 	return pci_enable_device_bars(dev, bars);
+#else
+	return 0;
+#endif
 }
 EXPORT_SYMBOL_GPL(pci_enable_device_mem);
 
diff --git a/backport/compat/compat-2.6.28.c b/backport/compat/compat-2.6.28.c
index e47626b..2ff6b1e 100644
--- a/backport/compat/compat-2.6.28.c
+++ b/backport/compat/compat-2.6.28.c
@@ -12,6 +12,7 @@
 #include <linux/usb.h>
 #include <linux/tty.h>
 #include <linux/skbuff.h>
+#include <linux/pci.h>
 #include <asm/poll.h>
 
 /* 2.6.28 compat code goes here */
-- 
1.8.1.2



-- 
Dipl.-Inf. (FH) Patrick Ziegler

University Of Applied Sciences
Kaiserslautern

Amerikastrasse 1
D-66482 Zweibruecken
Germany

Phone:  +49 631 3724 5526
Mail:   patrick.ziegler@fh-kl.de
PGP KeyID 0xB4796B8C

http://www.fh-kl.de
http://www.fh-kl.de/fachbereiche/imst/iuk-knowhow.html
