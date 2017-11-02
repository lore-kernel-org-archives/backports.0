Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:43550 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755125AbdKBJ7q (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 2 Nov 2017 05:59:46 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, hauke@hauke-m.de,
        Luca Coelho <luciano.coelho@intel.com>
Date: Thu,  2 Nov 2017 11:59:35 +0200
Message-Id: <20171102095935.31299-1-luca@coelho.fi> (sfid-20171102_105948_029974_DEDCEC4D)
Subject: [PATCH] patches: pre-declare stats64_fn_wrap() to avoid sparse warnings
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The stats64_fn_wrap() function was changed to be not-static so it can
be used by usbnet.  This causes problems in files that don't export
it.  Work around that byt just pre-declaring it before the actual
definition.

Fixes: 5a00d8489c7 ("patches: adapt the stat64 usage for usbnet")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 patches/0075-ndo-stats-64.cocci | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/patches/0075-ndo-stats-64.cocci b/patches/0075-ndo-stats-64.cocci
index 8613182403e2..8971a97c7209 100644
--- a/patches/0075-ndo-stats-64.cocci
+++ b/patches/0075-ndo-stats-64.cocci
@@ -18,6 +18,10 @@ identifier r.stats64_fn;
 @@
 void stats64_fn(...) {...}
 +#if LINUX_VERSION_IS_LESS(4,11,0)
++/* Just declare it here to keep sparse happy */
++struct rtnl_link_stats64 *
++stats64_fn_wrap(struct net_device *dev,
++		 struct rtnl_link_stats64 *stats);
 +struct rtnl_link_stats64 *
 +stats64_fn_wrap(struct net_device *dev,
 +		 struct rtnl_link_stats64 *stats)
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
