Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51945 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757043AbbIUWHc (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Sep 2015 18:07:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/10] dependencies: make DVB_TDA10071 depend on kernel 3.4
Date: Tue, 22 Sep 2015 00:07:21 +0200
Message-Id: <1442873243-15490-9-git-send-email-hauke@hauke-m.de> (sfid-20150922_000737_631330_3F9C5C00)
In-Reply-To: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
References: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

DVB_TDA10071 now uses regmap_bulk_write() which was added in kernel 3.4.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index edafdaf..96f1d0a 100644
--- a/dependencies
+++ b/dependencies
@@ -108,6 +108,7 @@ MEDIA_TUNER_TUA9001 3.3
 DVB_USB_AF9035 3.4
 DVB_USB_ANYSEE 3.4
 DVB_USB_DVBSKY 3.4
+DVB_TDA10071 3.4
 DVB_SMIPCIE 3.4
 MEDIA_TUNER_E4000 3.4
 MEDIA_TUNER_M88TS2022 3.4
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
