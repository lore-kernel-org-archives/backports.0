Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:59244 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbaDRBXU (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Apr 2014 21:23:20 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: alex.bluesman.smirnov@gmail.com, dbaryshkov@gmail.com,
	linux-zigbee-devel@lists.sourceforge.net, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	backports@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH 3/3] 6lowpan: include net/net_namespace.h on 6lowpan namepsace header
Date: Thu, 17 Apr 2014 18:22:56 -0700
Message-Id: <1397784176-15809-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20140418_032426_779711_850B085E)
In-Reply-To: <1397784176-15809-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397784176-15809-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Don't rely on driver files or other headers having this file included.

CC: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 include/net/6lowpan.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index f7d372b..79b530f 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -54,6 +54,7 @@
 #define __6LOWPAN_H__
 
 #include <net/ipv6.h>
+#include <net/net_namespace.h>
 
 #define UIP_802154_SHORTADDR_LEN	2  /* compressed ipv6 address length */
 #define UIP_IPH_LEN			40 /* ipv6 fixed header size */
-- 
1.9.1

