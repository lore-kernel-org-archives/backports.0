Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:48208 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbeIFLbv (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 6 Sep 2018 07:31:51 -0400
From: Felix Fietkau <nbd@nbd.name>
To: backports@vger.kernel.org
Cc: john@phrozen.org
Subject: [PATCH 5/6] backport: copy net/rsi_91x.h
Date: Thu,  6 Sep 2018 08:57:49 +0200
Message-Id: <20180906065750.89673-5-nbd@nbd.name> (sfid-20180906_085755_924822_7FABED75)
In-Reply-To: <20180906065750.89673-1-nbd@nbd.name>
References: <20180906065750.89673-1-nbd@nbd.name>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 21ca8070..f9f9396c 100644
--- a/copy-list
+++ b/copy-list
@@ -49,6 +49,7 @@ include/linux/spi/libertas_spi.h
 include/linux/platform_data/brcmfmac.h
 include/linux/platform_data/net-cw1200.h
 include/uapi/linux/nl80211.h
+include/net/rsi_91x.h
 
 include/net/cfg80211.h
 include/net/cfg80211-wext.h
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
