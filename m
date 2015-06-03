Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41708 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbbFCL0S (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 3 Jun 2015 07:26:18 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 4/4] backports: replace igb pfmemalloc patch with semantic patch
Date: Wed,  3 Jun 2015 13:25:56 +0200
Message-Id: <1433330756-22733-5-git-send-email-sassmann@kpanic.de> (sfid-20150603_132619_896920_FCFC144F)
In-Reply-To: <1433330756-22733-1-git-send-email-sassmann@kpanic.de>
References: <1433330756-22733-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0049-no-pfmemalloc/igb.patch                   | 14 --------------
 .../network/0049-no-pfmemalloc/no-pfmemalloc.cocci         |  9 +++++++++
 2 files changed, 9 insertions(+), 14 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
 create mode 100644 patches/collateral-evolutions/network/0049-no-pfmemalloc/no-pfmemalloc.cocci

diff --git a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch b/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
deleted file mode 100644
index 53b319a..0000000
--- a/patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -6578,7 +6578,11 @@ static void igb_reuse_rx_page(struct igb
- 
- static inline bool igb_page_is_reserved(struct page *page)
- {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
- 	return (page_to_nid(page) != numa_mem_id()) || page->pfmemalloc;
-+#else
-+	return (page_to_nid(page) != numa_mem_id());
-+#endif
- }
- 
- static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer,
diff --git a/patches/collateral-evolutions/network/0049-no-pfmemalloc/no-pfmemalloc.cocci b/patches/collateral-evolutions/network/0049-no-pfmemalloc/no-pfmemalloc.cocci
new file mode 100644
index 0000000..bbc1201
--- /dev/null
+++ b/patches/collateral-evolutions/network/0049-no-pfmemalloc/no-pfmemalloc.cocci
@@ -0,0 +1,9 @@
+@r1@
+struct page *page;
+expression E1;
+@@
+ return E1
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ || page->pfmemalloc
++#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
+ ;
-- 
2.4.2

