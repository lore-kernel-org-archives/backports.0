Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:53379 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbcFEJaO (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 5 Jun 2016 05:30:14 -0400
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 2/2] backports: patches: update devcoredump patch
Date: Sun,  5 Jun 2016 11:30:05 +0200
Message-Id: <1465119005-4161-2-git-send-email-arend.vanspriel@broadcom.com> (sfid-20160605_113018_707595_A6BA1018)
In-Reply-To: <1465119005-4161-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1465119005-4161-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Due to changes in include/linux/devcoredump.h the patch needs to
be updated.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
This patch is another shot at devcoredump patch. It just fixes
applying the patch. However, the resulting file now uses the
scatterlist function sg_pcopy_to_buffer() so that will need a
backport for kernels before v3.11.

Regards,
Arend
---
 patches/backport-adjustments/devcoredump.patch | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/patches/backport-adjustments/devcoredump.patch b/patches/backport-adjustments/devcoredump.patch
index b438f32..397b317 100644
--- a/patches/backport-adjustments/devcoredump.patch
+++ b/patches/backport-adjustments/devcoredump.patch
@@ -97,18 +97,18 @@
 -__exitcall(devcoredump_exit);
 --- a/include/linux/backport-devcoredump.h
 +++ b/include/linux/backport-devcoredump.h
-@@ -5,7 +5,7 @@
- #include <linux/module.h>
- #include <linux/vmalloc.h>
+@@ -66,7 +66,7 @@ static inline void _devcd_free_sgtable(struct scatterlist *tab
+ }
+ 
  
 -#ifdef CONFIG_DEV_COREDUMP
 +#ifdef CPTCFG_BPAUTO_WANT_DEV_COREDUMP
- void dev_coredumpv(struct device *dev, const void *data, size_t datalen,
- 		   gfp_t gfp);
+ void dev_coredumpv(struct device *dev, void *data, size_t datalen,
+                   gfp_t gfp);
  
-@@ -30,6 +30,6 @@ dev_coredumpm(struct device *dev, struct
+@@ -100,6 +100,6 @@ static inline void dev_coredumpsg(struct device *dev, struct
  {
- 	free(data);
+        _devcd_free_sgtable(table);
  }
 -#endif /* CONFIG_DEV_COREDUMP */
 +#endif /* CPTCFG_BPAUTO_WANT_DEV_COREDUMP */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
