Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:48806 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbdJKObx (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 11 Oct 2017 10:31:53 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/5] backports: fix some dev_coredumpm() problem
Date: Wed, 11 Oct 2017 16:31:43 +0200
Message-Id: <20171011143147.3337-1-johannes@sipsolutions.net> (sfid-20171011_163301_178875_C0E866DE)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Sometimes the argument is const, sometimes not, just cast
away that difference.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/backport-4.7.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/backport/compat/backport-4.7.c b/backport/compat/backport-4.7.c
index b064707767c6..372951b60382 100644
--- a/backport/compat/backport-4.7.c
+++ b/backport/compat/backport-4.7.c
@@ -176,7 +176,9 @@ void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 		    size_t datalen, gfp_t gfp)
 {
 	dev_coredumpm(dev, THIS_MODULE, table, datalen, gfp,
-		      devcd_read_from_sgtable, devcd_free_sgtable);
+		      /* cast away some const problems */
+		      (void *)devcd_read_from_sgtable,
+		      (void *)devcd_free_sgtable);
 }
 EXPORT_SYMBOL_GPL(dev_coredumpsg);
 #endif /* >= 3.18.0 */
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
