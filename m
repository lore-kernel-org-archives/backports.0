Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:39806 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbdBFMkA (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 6 Feb 2017 07:40:00 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] backports: devcoredump: make patch apply
Date: Mon,  6 Feb 2017 13:39:54 +0100
Message-Id: <20170206123956.20082-1-johannes@sipsolutions.net> (sfid-20170206_134001_952751_EBB6AF9E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Just make the patch apply again - the next commits
will auto-generate the necessary backport code.

Change-Id: I2b25ccbaadf1d49b9fdd229b3eaf1ecb7a9cf9ce
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/backport-adjustments/devcoredump.patch | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patches/backport-adjustments/devcoredump.patch b/patches/backport-adjustments/devcoredump.patch
index b840adc145f7..315ffd57e3bf 100644
--- a/patches/backport-adjustments/devcoredump.patch
+++ b/patches/backport-adjustments/devcoredump.patch
@@ -62,7 +62,7 @@
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
  	.dev_groups	= devcd_dev_groups,
 +#endif
- 	.class_attrs	= devcd_class_attrs,
+ 	.class_groups	= devcd_class_groups,
  };
  
 @@ -270,6 +281,11 @@ void dev_coredumpm(struct device *dev, s
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
