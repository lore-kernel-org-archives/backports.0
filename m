Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:45959 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbdIJWKr (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 10 Sep 2017 18:10:47 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/8] backport: add ethtool_convert_legacy_u32_to_link_mode()
Date: Mon, 11 Sep 2017 00:10:15 +0200
Message-Id: <20170910221020.13067-4-hauke@hauke-m.de> (sfid-20170911_001050_209089_78D99287)
In-Reply-To: <20170910221020.13067-1-hauke@hauke-m.de>
References: <20170910221020.13067-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function was added in kernel 4.7 in commit 6d62b4d5fac62 ("net:
ethtool: export conversion function between u32 and link mode") and is
used by mii_ethtool_get_link_ksettings() in the backport-4.10.c file.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/backport-4.10.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/compat/backport-4.10.c b/backport/compat/backport-4.10.c
index 4c8125fb..44e02dd7 100644
--- a/backport/compat/backport-4.10.c
+++ b/backport/compat/backport-4.10.c
@@ -36,6 +36,13 @@ static bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
 	*legacy_u32 = src[0];
 	return retval;
 }
+
+static void ethtool_convert_legacy_u32_to_link_mode(unsigned long *dst,
+						    u32 legacy_u32)
+{
+	bitmap_zero(dst, __ETHTOOL_LINK_MODE_MASK_NBITS);
+	dst[0] = legacy_u32;
+}
 #endif
 
 static u32 mii_get_an(struct mii_if_info *mii, u16 addr)
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
