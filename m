Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41772 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505AbcEaNtG (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 31 May 2016 09:49:06 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: update devcoredump patch
Date: Tue, 31 May 2016 15:49:01 +0200
Message-Id: <1464702541-20621-1-git-send-email-johannes@sipsolutions.net> (sfid-20160531_154909_169715_B72CDD75)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Changed upstream by commit 522566376a3f ("devcoredump:
add scatterlist support").

Change-Id: I9a8e933ed70ac85ebc0c241a3faa78217fbb6f30
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/backport-adjustments/devcoredump.patch | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/patches/backport-adjustments/devcoredump.patch b/patches/backport-adjustments/devcoredump.patch
index b438f32e115b..efa5d9f9ab48 100644
--- a/patches/backport-adjustments/devcoredump.patch
+++ b/patches/backport-adjustments/devcoredump.patch
@@ -103,12 +103,12 @@
  
 -#ifdef CONFIG_DEV_COREDUMP
 +#ifdef CPTCFG_BPAUTO_WANT_DEV_COREDUMP
- void dev_coredumpv(struct device *dev, const void *data, size_t datalen,
+ void dev_coredumpv(struct device *dev, void *data, size_t datalen,
  		   gfp_t gfp);
  
 @@ -30,6 +30,6 @@ dev_coredumpm(struct device *dev, struct
  {
- 	free(data);
+ 	_devcd_free_sgtable(table);
  }
 -#endif /* CONFIG_DEV_COREDUMP */
 +#endif /* CPTCFG_BPAUTO_WANT_DEV_COREDUMP */
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
