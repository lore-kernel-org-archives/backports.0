Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:42595 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757856Ab3GLXAm (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 12 Jul 2013 19:00:42 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so9025286pdj.26
        for <backports@vger.kernel.org>; Fri, 12 Jul 2013 16:00:42 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/2] backports: Fix and document EXPORT_SYMBOL_GPL() preference
Date: Fri, 12 Jul 2013 16:00:35 -0700
Message-Id: <1373670037-28011-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130713_010045_215299_723F4737)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

In terms of project naming the backports project has evolved
as follows:

compat-wireless --> compat-drivers --> backports

All along the design and intent behind the initial project
has been to provide a framework for delivery of *upstream*
drivers using a backported infrastructure. I've made it
clear that in no way shape or form did I ever want any
proprietary driver to make use of the framework. As the
project has grown I'm not alone with this sentiment so
lets document that and also fix a few symbols that have
slipped along the way.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 README                          |   13 +++++++++++++
 backport/compat/backport-3.11.c |    4 ++--
 backport/compat/compat-2.6.25.c |    8 ++++----
 backport/compat/compat-2.6.26.c |    2 +-
 backport/compat/compat-2.6.37.c |    2 +-
 backport/compat/compat-3.6.c    |    2 +-
 backport/compat/compat-3.8.c    |    2 +-
 7 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/README b/README
index 2f03852..99718b1 100644
--- a/README
+++ b/README
@@ -30,3 +30,16 @@ This work is a subset of the Linux kernel as such we keep the kernel's
 Copyright practice. Some files have their own copyright and in those
 cases the license is mentioned in the file. All additional work made
 to building this package is licensed under the GPLv2.
+
+# Backporting preference for EXPORT_SYMBOL_GPL() and proprietary drivers
+
+This framework was designed by intent since its inception *only* for upstream
+Linux kernel drivers to avoid excuses about the difficulty to support upstream
+Linux kernel development while also supporting users on older kernels. To
+ensure the intent is respected currently all symbols that we do work on to
+backport are exported via EXPORT_SYMBOL_GPL() as we do work to backport them
+for the supported kernels. By using EXPORT_SYMBOL_GPL() we make it *clear* that
+if you use the backported symbols your software *is* considered derivative
+works of the Linux kernel.
+
+Comprendes, Mendes?
diff --git a/backport/compat/backport-3.11.c b/backport/compat/backport-3.11.c
index 332db4a..c6d5a02 100644
--- a/backport/compat/backport-3.11.c
+++ b/backport/compat/backport-3.11.c
@@ -49,7 +49,7 @@ int arch_phys_wc_add(unsigned long base, unsigned long size)
 	}
 	return ret + MTRR_TO_PHYS_WC_OFFSET;
 }
-EXPORT_SYMBOL(arch_phys_wc_add);
+EXPORT_SYMBOL_GPL(arch_phys_wc_add);
 
 /*
  * arch_phys_wc_del - undoes arch_phys_wc_add
@@ -67,7 +67,7 @@ void arch_phys_wc_del(int handle)
 		mtrr_del(handle - MTRR_TO_PHYS_WC_OFFSET, 0, 0);
 	}
 }
-EXPORT_SYMBOL(arch_phys_wc_del);
+EXPORT_SYMBOL_GPL(arch_phys_wc_del);
 
 /*
  * phys_wc_to_mtrr_index - translates arch_phys_wc_add's return value
diff --git a/backport/compat/compat-2.6.25.c b/backport/compat/compat-2.6.25.c
index b1459f1..b3597ea 100644
--- a/backport/compat/compat-2.6.25.c
+++ b/backport/compat/compat-2.6.25.c
@@ -79,7 +79,7 @@ void __sg_free_table(struct sg_table *table, unsigned int max_ents,
 
 	table->sgl = NULL;
 }
-EXPORT_SYMBOL(__sg_free_table);
+EXPORT_SYMBOL_GPL(__sg_free_table);
 
 /**
  * sg_free_table - Free a previously allocated sg table
@@ -90,7 +90,7 @@ void sg_free_table(struct sg_table *table)
 {
 	__sg_free_table(table, SG_MAX_SINGLE_ALLOC, sg_kfree);
 }
-EXPORT_SYMBOL(sg_free_table);
+EXPORT_SYMBOL_GPL(sg_free_table);
 
 /**
  * __sg_alloc_table - Allocate and initialize an sg table with given allocator
@@ -175,7 +175,7 @@ int __sg_alloc_table(struct sg_table *table, unsigned int nents,
 
 	return 0;
 }
-EXPORT_SYMBOL(__sg_alloc_table);
+EXPORT_SYMBOL_GPL(__sg_alloc_table);
 
 /**
  * sg_alloc_table - Allocate and initialize an sg table
@@ -199,7 +199,7 @@ int sg_alloc_table(struct sg_table *table, unsigned int nents, gfp_t gfp_mask)
 
 	return ret;
 }
-EXPORT_SYMBOL(sg_alloc_table);
+EXPORT_SYMBOL_GPL(sg_alloc_table);
 
 
 /*
diff --git a/backport/compat/compat-2.6.26.c b/backport/compat/compat-2.6.26.c
index f80058a..c7c457f 100644
--- a/backport/compat/compat-2.6.26.c
+++ b/backport/compat/compat-2.6.26.c
@@ -18,7 +18,7 @@
 #include <net/compat.h>
 
 const char hex_asc[] = "0123456789abcdef";
-EXPORT_SYMBOL(hex_asc);
+EXPORT_SYMBOL_GPL(hex_asc);
 
 /* 2.6.24 does not have the struct kobject with a name */
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,25))
diff --git a/backport/compat/compat-2.6.37.c b/backport/compat/compat-2.6.37.c
index cc85b15..ab5423c 100644
--- a/backport/compat/compat-2.6.37.c
+++ b/backport/compat/compat-2.6.37.c
@@ -381,6 +381,6 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 	dev->num_rx_queues = rxq;
 	return 0;
 }
-EXPORT_SYMBOL(netif_set_real_num_rx_queues);
+EXPORT_SYMBOL_GPL(netif_set_real_num_rx_queues);
 #endif
 #endif
diff --git a/backport/compat/compat-3.6.c b/backport/compat/compat-3.6.c
index 05954d4..53991ee 100644
--- a/backport/compat/compat-3.6.c
+++ b/backport/compat/compat-3.6.c
@@ -45,7 +45,7 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 	return ret;
 }
-EXPORT_SYMBOL(__i2c_transfer);
+EXPORT_SYMBOL_GPL(__i2c_transfer);
 #endif
 
 /**
diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
index 2884323..b63382d 100644
--- a/backport/compat/compat-3.8.c
+++ b/backport/compat/compat-3.8.c
@@ -417,4 +417,4 @@ int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long
 	/* Ok, let it rip */
 	return io_remap_pfn_range(vma, vma->vm_start, pfn, vm_len, vma->vm_page_prot);
 }
-EXPORT_SYMBOL(vm_iomap_memory);
+EXPORT_SYMBOL_GPL(vm_iomap_memory);
-- 
1.7.10.4

