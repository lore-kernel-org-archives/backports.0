Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:48218 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbeIFLbw (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 6 Sep 2018 07:31:52 -0400
From: Felix Fietkau <nbd@nbd.name>
To: backports@vger.kernel.org
Cc: john@phrozen.org
Subject: [PATCH 1/6] backports: copy linux/overflow.h
Date: Thu,  6 Sep 2018 08:57:45 +0200
Message-Id: <20180906065750.89673-1-nbd@nbd.name> (sfid-20180906_085757_427105_86B6969A)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Overflow macros are useful for further backports

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 5c64b6d4..21ca8070 100644
--- a/copy-list
+++ b/copy-list
@@ -19,6 +19,7 @@ include/linux/fixp-arith.h
 # This just defines some macros, simply take it
 include/linux/bitfield.h
 include/linux/average.h
+include/linux/overflow.h
 
 # crypto_memneq
 crypto/memneq.c -> compat/memneq.c
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
