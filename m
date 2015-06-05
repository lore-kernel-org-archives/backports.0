Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34099 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbbFENGh (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Jun 2015 09:06:37 -0400
Received: by payr10 with SMTP id r10so50674827pay.1
        for <backports@vger.kernel.org>; Fri, 05 Jun 2015 06:06:37 -0700 (PDT)
From: Jonathan Liu <net147@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Jonathan Liu <net147@gmail.com>
Subject: [PATCH] backports: add missing include for vfree
Date: Fri,  5 Jun 2015 23:06:53 +1000
Message-Id: <1433509613-3272-1-git-send-email-net147@gmail.com> (sfid-20150605_150640_723586_8FFA431D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 backport/compat/backport-3.15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/compat/backport-3.15.c b/backport/compat/backport-3.15.c
index c6f9d43..381fe65 100644
--- a/backport/compat/backport-3.15.c
+++ b/backport/compat/backport-3.15.c
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <net/net_namespace.h>
 
 #if IS_ENABLED(CPTCFG_IEEE802154_6LOWPAN)
-- 
2.4.1

