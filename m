Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:55790 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759447Ab3HNIRs (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 14 Aug 2013 04:17:48 -0400
Message-ID: <520B3D25.7050600@fh-kl.de> (sfid-20130814_101750_380647_4D57E564)
Date: Wed, 14 Aug 2013 10:17:41 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [PATCH v2 1/9] backports: fix build errors for old kernel versions
 without PCI support
References: <cover.1376467862.git.patrick.ziegler@fh-kl.de>
In-Reply-To: <cover.1376467862.git.patrick.ziegler@fh-kl.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/compat/compat-2.6.25.c | 2 ++
 backport/compat/compat-2.6.28.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/backport/compat/compat-2.6.25.c b/backport/compat/compat-2.6.25.c
index b3597ea..37407a4 100644
--- a/backport/compat/compat-2.6.25.c
+++ b/backport/compat/compat-2.6.25.c
@@ -210,6 +210,7 @@ EXPORT_SYMBOL_GPL(sg_alloc_table);
  * to it. We implement a sloppy work around for backporting
  * this.
  */
+#ifdef CONFIG_PCI
 int pci_enable_device_mem(struct pci_dev *dev)
 {
 	int bars = pci_select_bars(dev, IORESOURCE_MEM);
@@ -217,6 +218,7 @@ int pci_enable_device_mem(struct pci_dev *dev)
 	return pci_enable_device_bars(dev, bars);
 }
 EXPORT_SYMBOL_GPL(pci_enable_device_mem);
+#endif
 
 /**
  * The following things are out of ./lib/vsprintf.c
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
