Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39994 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756333Ab2HWLhv (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 23 Aug 2012 07:37:51 -0400
Received: by mail-ey0-f174.google.com with SMTP id c11so190644eaa.19
        for <backports@vger.kernel.org>; Thu, 23 Aug 2012 04:37:51 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 2/2] compat: Backport eth_broadcast_addr()
Date: Thu, 23 Aug 2012 14:37:27 +0300
Message-Id: <1345721847-9279-2-git-send-email-ozancag@gmail.com>
In-Reply-To: <1345721847-9279-1-git-send-email-ozancag@gmail.com>
References: <1345721847-9279-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backports:

commit ad7eee98bef92481581060801bdfd1b25a6106c0
Author: Johannes Berg <johannes.berg@intel.com>
Commit: David S. Miller <davem@davemloft.net>

    etherdevice: introduce eth_broadcast_addr

    A lot of code has either the memset or an inefficient copy
    from a static array that contains the all-ones broadcast
    address. Introduce eth_broadcast_addr() to fill an address
    with all ones, making the code clearer and allowing us to
    get rid of some constant arrays.

    Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

$ git describe --contains ad7eee98bef92481581060801bdfd1b25a6106c0
v3.6-rc1~125^2~252

Trying kernel 3.5.0-030500-generic [OK]
Trying kernel 3.4.4-030404-generic [OK]
Trying kernel 3.3.7-030307-generic [OK]
Trying kernel 3.2.2-030202-generic [OK]
Trying kernel 3.1.10-030110-generic [OK]
Trying kernel 3.0.18-030018-generic [OK]
Trying kernel 2.6.39-02063904-generic [OK]
Trying kernel 2.6.38-02063808-generic [OK]
Trying kernel 2.6.37-02063706-generic [OK]
Trying kernel 2.6.36-02063604-generic [OK]
Trying kernel 2.6.35-02063512-generic [OK]
Trying kernel 2.6.34-02063410-generic [OK]
Trying kernel 2.6.33-02063305-generic [OK]
Trying kernel 2.6.32-02063255-generic [OK]
Trying kernel 2.6.31-02063113-generic [OK]
Trying kernel 2.6.30-02063010-generic [OK]
Trying kernel 2.6.29-02062906-generic [OK]
Trying kernel 2.6.28-02062810-generic [OK]
Trying kernel 2.6.27-020627-generic [OK]
Trying kernel 2.6.26-020626-generic [OK]
Trying kernel 2.6.25-020625-generic [OK]
Trying kernel 2.6.24-020624-generic [OK]

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 include/linux/compat-3.6.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/compat-3.6.h b/include/linux/compat-3.6.h
index 63753cd..97b5993 100644
--- a/include/linux/compat-3.6.h
+++ b/include/linux/compat-3.6.h
@@ -48,6 +48,17 @@
 #include <linux/etherdevice.h>
 
 /**
+ * eth_broadcast_addr - Assign broadcast address
+ * @addr: Pointer to a six-byte array containing the Ethernet address
+ *
+ * Assign the broadcast address to the given address array.
+ */
+static inline void eth_broadcast_addr(u8 *addr)
+{
+	memset(addr, 0xff, ETH_ALEN);
+}
+
+/**
  * eth_random_addr - Generate software assigned random Ethernet address
  * @addr: Pointer to a six-byte array containing the Ethernet address
  *
-- 
1.7.11.4

