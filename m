Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:50980 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727986AbeITRLz (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:11:55 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:34 +0300
Message-Id: <20180920112842.27198-7-luca@coelho.fi> (sfid-20180920_132855_311484_9098BA05)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 06/14] backport: add rhashtable-types.h
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

This was introduced in 4.18 and is needed by rhashtable.h, that we
copy.  So copy it as well.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/compat/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index ed3a58725d69..be07a1898f38 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -130,6 +130,7 @@ config BPAUTO_RHASHTABLE
 	# not very nice - but better than always having it
 	default y if BACKPORTED_MAC80211
 	#h-file linux/rhashtable.h
+	#h-file linux/rhashtable-types.h
 	#c-file lib/rhashtable.c
 
 config BPAUTO_BUCKET_LOCKS
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
