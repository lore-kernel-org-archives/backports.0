Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:38444 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeIWXoB (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 19:44:01 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/10] copy: Add crc32poly.h
Date: Sun, 23 Sep 2018 19:45:28 +0200
Message-Id: <20180923174535.16198-4-hauke@hauke-m.de> (sfid-20180923_194550_412258_30EBA68F)
In-Reply-To: <20180923174535.16198-1-hauke@hauke-m.de>
References: <20180923174535.16198-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by the rtl8723bs driver. The implementation is completely
in this header file, so it is save to copy it

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index b2ec0972..9c522629 100644
--- a/copy-list
+++ b/copy-list
@@ -15,6 +15,7 @@ MAINTAINERS
 include/linux/unaligned/
 include/linux/hashtable.h
 include/linux/fixp-arith.h
+include/linux/crc32poly.h
 
 # This just defines some macros, simply take it
 include/linux/bitfield.h
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
