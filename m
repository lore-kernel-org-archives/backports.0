Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44209 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab3DMXyJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:54:09 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 01/42] backports: average: backport efficiency improvements
Date: Sun, 14 Apr 2013 01:53:21 +0200
Message-Id: <1365897243-31214-2-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015413_141247_6ACF37F7)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This is what we get for not copying it directly :-)
For now, backport af556884359 manually.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/average.c        | 20 ++++++++++++--------
 backport/include/linux/average.h |  2 +-
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/backport/compat/average.c b/backport/compat/average.c
index 37cbfd6..b7a51a1 100644
--- a/backport/compat/average.c
+++ b/backport/compat/average.c
@@ -11,23 +11,27 @@
 #include <linux/average.h>
 #include <linux/module.h>
 #include <linux/bug.h>
+#include <linux/log2.h>
 
 /**
  * ewma_init() - Initialize EWMA parameters
  * @avg: Average structure
  * @factor: Factor to use for the scaled up internal value. The maximum value
- *	of averages can be ULONG_MAX/(factor*weight).
+ *	of averages can be ULONG_MAX/(factor*weight). For performance reasons
+ *	factor has to be a power of 2.
  * @weight: Exponential weight, or decay rate. This defines how fast the
- *	influence of older values decreases. Has to be bigger than 1.
+ *	influence of older values decreases. For performance reasons weight has
+ *	to be a power of 2.
  *
  * Initialize the EWMA parameters for a given struct ewma @avg.
  */
 void ewma_init(struct ewma *avg, unsigned long factor, unsigned long weight)
 {
-	WARN_ON(weight <= 1 || factor == 0);
+	WARN_ON(!is_power_of_2(weight) || !is_power_of_2(factor));
+
+	avg->weight = ilog2(weight);
+	avg->factor = ilog2(factor);
 	avg->internal = 0;
-	avg->weight = weight;
-	avg->factor = factor;
 }
 EXPORT_SYMBOL_GPL(ewma_init);
 
@@ -41,9 +45,9 @@ EXPORT_SYMBOL_GPL(ewma_init);
 struct ewma *ewma_add(struct ewma *avg, unsigned long val)
 {
 	avg->internal = avg->internal  ?
-		(((avg->internal * (avg->weight - 1)) +
-			(val * avg->factor)) / avg->weight) :
-		(val * avg->factor);
+		(((avg->internal << avg->weight) - avg->internal) +
+			(val << avg->factor)) >> avg->weight :
+		(val << avg->factor);
 	return avg;
 }
 EXPORT_SYMBOL_GPL(ewma_add);
diff --git a/backport/include/linux/average.h b/backport/include/linux/average.h
index 16eff0d..2d6210e 100644
--- a/backport/include/linux/average.h
+++ b/backport/include/linux/average.h
@@ -29,6 +29,6 @@ extern struct ewma *ewma_add(struct ewma *avg, unsigned long val);
  */
 static inline unsigned long ewma_read(const struct ewma *avg)
 {
-	return DIV_ROUND_CLOSEST(avg->internal, avg->factor);
+	return avg->internal >> avg->factor;
 }
 #endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,37)) */
-- 
1.8.0

