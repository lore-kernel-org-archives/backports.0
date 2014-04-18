Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:37952 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbaDRBXP (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Apr 2014 21:23:15 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: alex.bluesman.smirnov@gmail.com, dbaryshkov@gmail.com,
	linux-zigbee-devel@lists.sourceforge.net, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	backports@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH 2/3] 6lowpan: make lowpan_cb static
Date: Thu, 17 Apr 2014 18:22:55 -0700
Message-Id: <1397784176-15809-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20140418_032412_777054_2F089268)
In-Reply-To: <1397784176-15809-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397784176-15809-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

CC: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 net/ieee802154/reassembly.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/reassembly.c b/net/ieee802154/reassembly.c
index 132b65b..6f1428c 100644
--- a/net/ieee802154/reassembly.c
+++ b/net/ieee802154/reassembly.c
@@ -36,7 +36,7 @@ struct lowpan_frag_info {
 	u8 d_offset;
 };
 
-struct lowpan_frag_info *lowpan_cb(struct sk_buff *skb)
+static struct lowpan_frag_info *lowpan_cb(struct sk_buff *skb)
 {
 	return (struct lowpan_frag_info *)skb->cb;
 }
-- 
1.9.1

