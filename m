Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:36850 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbbFZSOX (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 26 Jun 2015 14:14:23 -0400
Received: by lacny3 with SMTP id ny3so68270230lac.3
        for <backports@vger.kernel.org>; Fri, 26 Jun 2015 11:14:21 -0700 (PDT)
From: Florian Grandel <fgrandel@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Florian Grandel <fgrandel@gmail.com>
Subject: [PATCH] headers: add missing include statement
Date: Fri, 26 Jun 2015 20:14:13 +0200
Message-Id: <1435342454-21239-1-git-send-email-fgrandel@gmail.com> (sfid-20150626_201425_250285_231B1AE4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The net/route.h header is missing when compiling against the android msm
kernel. Explicitly add it here to make the kernel compile.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 backport/backport-include/net/ip6_fib.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/net/ip6_fib.h b/backport/backport-include/net/ip6_fib.h
index 96b6759..ebdc94c 100644
--- a/backport/backport-include/net/ip6_fib.h
+++ b/backport/backport-include/net/ip6_fib.h
@@ -2,6 +2,7 @@
 #define __BACKPORT_NET_IP6_ROUTE_H
 #include_next <net/ip6_fib.h>
 #include <net/ip6_route.h>
+#include <linux/route.h>
 #include <linux/version.h>
 
 /*
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
