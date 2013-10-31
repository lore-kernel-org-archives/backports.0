Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49164 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743Ab3JaWDd (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 31 Oct 2013 18:03:33 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] backports: refresh on next-20131031
Date: Thu, 31 Oct 2013 23:03:18 +0100
Message-Id: <1383256998-32371-3-git-send-email-hauke@hauke-m.de> (sfid-20131031_230335_085304_E5F57A79)
In-Reply-To: <1383256998-32371-1-git-send-email-hauke@hauke-m.de>
References: <1383256998-32371-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.10.17             [  OK  ]
19  3.11.6              [  OK  ]
20  3.12-rc7            [  OK  ]
21  3.2.52              [  OK  ]
22  3.3.8               [  OK  ]
23  3.4.67              [  OK  ]
24  3.5.7               [  OK  ]
25  3.6.11              [  OK  ]
26  3.7.10              [  OK  ]
27  3.8.13              [  OK  ]
28  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch        |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
index a75e993..f0ca2a9 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
@@ -1,6 +1,6 @@
 --- a/drivers/usb/class/cdc-wdm.c
 +++ b/drivers/usb/class/cdc-wdm.c
-@@ -1065,7 +1065,9 @@ static struct usb_driver wdm_driver = {
+@@ -1099,7 +1099,9 @@ static struct usb_driver wdm_driver = {
  	.post_reset =	wdm_post_reset,
  	.id_table =	wdm_ids,
  	.supports_autosuspend = 1,
-- 
1.7.10.4

