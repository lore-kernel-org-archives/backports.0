Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:32773 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab3HBL3h (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 2 Aug 2013 07:29:37 -0400
Message-ID: <51FB981B.6010502@fh-kl.de> (sfid-20130802_132938_321298_FA893670)
Date: Fri, 2 Aug 2013 13:29:31 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [PATCH 1/9] backports: fix build errors for old kernel versions without
 PCI support
References: <cover.1375442885.git.patrick.ziegler@fh-kl.de>
In-Reply-To: <cover.1375442885.git.patrick.ziegler@fh-kl.de>
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
