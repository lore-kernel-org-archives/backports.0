Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58360 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbaASQs1 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:27 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/16] backports: add prefix infront of ether_addr_equal_{unaligned, 64bits}()
Date: Sun, 19 Jan 2014 17:47:31 +0100
Message-Id: <1390150057-11652-11-git-send-email-hauke@hauke-m.de> (sfid-20140119_174828_283351_48F204E2)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

RedHat 6.5 already contains ether_addr_equal_64bits() which will
conflict with our declaration.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/etherdevice.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index cf1e31f..5560c0c 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -172,7 +172,7 @@ static inline void eth_hw_addr_inherit(struct net_device *dst,
  *
  * Please note that alignment of addr1 & addr2 are only guaranteed to be 16 bits.
  */
-
+#define ether_addr_equal_64bits LINUX_BACKPORT(ether_addr_equal_64bits)
 static inline bool ether_addr_equal_64bits(const u8 addr1[6+2],
 					   const u8 addr2[6+2])
 {
@@ -200,6 +200,7 @@ static inline bool ether_addr_equal_64bits(const u8 addr1[6+2],
  *
  * Please note: Use only when any Ethernet address may not be u16 aligned.
  */
+#define ether_addr_equal_unaligned LINUX_BACKPORT(ether_addr_equal_unaligned)
 static inline bool ether_addr_equal_unaligned(const u8 *addr1, const u8 *addr2)
 {
 #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
-- 
1.7.10.4

