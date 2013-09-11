Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40714 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab3IKMMX (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 Sep 2013 08:12:23 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/11] backports: replace new portid usage
Date: Wed, 11 Sep 2013 14:11:50 +0200
Message-Id: <1378901515-14206-7-git-send-email-hauke@hauke-m.de> (sfid-20130911_141225_111234_29772160)
In-Reply-To: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
References: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In this upstream commit a new usage of portid was introduced:
commit ac22ac466a659f1b2e02a2e2ee23fc5c42da2c95
Author: Samuel Ortiz <sameo@linux.intel.com>
Date:   Wed Jul 24 18:10:50 2013 +0200

    NFC: Add a GET_SE netlink API

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../nfc/01-netlink-portid/net_nfc_netlink.patch             |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch b/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
index 16cbf8e..f73352c 100644
--- a/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
+++ b/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
@@ -54,7 +54,16 @@
  
  exit:
  	device_unlock(&dev->dev);
-@@ -1315,12 +1315,12 @@ static int nfc_genl_rcv_nl_event(struct
+@@ -1253,7 +1253,7 @@ static int nfc_genl_dump_ses(struct sk_b
+ 	while (dev) {
+ 		int rc;
+ 
+-		rc = nfc_genl_send_se(skb, dev, NETLINK_CB(cb->skb).portid,
++		rc = nfc_genl_send_se(skb, dev, NETLINK_CB_PORTID(cb->skb),
+ 					  cb->nlh->nlmsg_seq, cb, NLM_F_MULTI);
+ 		if (rc < 0)
+ 			break;
+@@ -1408,12 +1408,12 @@ static int nfc_genl_rcv_nl_event(struct
  	if (event != NETLINK_URELEASE || n->protocol != NETLINK_GENERIC)
  		goto out;
  
-- 
1.7.10.4

