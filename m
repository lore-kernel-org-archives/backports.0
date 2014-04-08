Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35949 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbaDHDdR (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 23:33:17 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so384962pdj.34
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 20:33:16 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH 10/12] backports: make IEEE802154_AT86RF230 depend require 3.3.
Date: Mon,  7 Apr 2014 20:32:21 -0700
Message-Id: <1396927943-25589-11-git-send-email-mcgrof@do-not-panic.com> (sfid-20140408_053318_566010_4D122C93)
In-Reply-To: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

IEEE802154_AT86RF230 has gotten some gpio changes lately
and since we are not backporting all those gpio changes in
practice this driver only compiles down to 3.3 so add that
requirement.

Cc: Alexander Aring <alex.aring@gmail.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 352a1af..3729d30 100644
--- a/dependencies
+++ b/dependencies
@@ -253,3 +253,4 @@ NFC_MEI_PHY 3.10
 IEEE802154_MRF24J40 3.5
 IEEE802154 3.1
 IEEE802154_6LOWPAN 3.5
+IEEE802154_AT86RF230 3.3
-- 
1.8.5.3

