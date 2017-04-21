Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41784 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971323AbdDUKr1 (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 21 Apr 2017 06:47:27 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] backports: extend magic to 6 possible arguments
Date: Fri, 21 Apr 2017 12:47:21 +0200
Message-Id: <20170421104722.21538-1-johannes@sipsolutions.net> (sfid-20170421_124729_890268_BA7A8760)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/backport/magic.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/backport/magic.h b/backport/backport-include/backport/magic.h
index 222e02513ef2..d7e7cc961bbf 100644
--- a/backport/backport-include/backport/magic.h
+++ b/backport/backport-include/backport/magic.h
@@ -5,8 +5,8 @@
  * http://efesx.com/2010/08/31/overloading-macros/
  */
 
-#define VA_NUM_ARGS(...) VA_NUM_ARGS_IMPL(__VA_ARGS__, 5,4,3,2,1)
-#define VA_NUM_ARGS_IMPL(_1,_2,_3,_4,_5,N,...) N
+#define VA_NUM_ARGS(...) VA_NUM_ARGS_IMPL(__VA_ARGS__, 6,5,4,3,2,1)
+#define VA_NUM_ARGS_IMPL(_1,_2,_3,_4,_5,_6,N,...) N
 
 #define macro_dispatcher(func, ...) \
 	macro_dispatcher_(func, VA_NUM_ARGS(__VA_ARGS__))
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
