Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56023 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbaEaRQ4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:16:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id EB6CB7E5E
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:16:55 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/13] backports: remove unused functions from bluetooth
Date: Sat, 31 May 2014 19:16:08 +0200
Message-Id: <1401556570-3363-12-git-send-email-hauke@hauke-m.de> (sfid-20140531_192147_655415_3BF2FBF3)
In-Reply-To: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
References: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

hidp_set_raw_report() and hidp_output_report() are not used with kernel
< 3.15.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../net_bluetooth_hidp_core.patch                    | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
index 4d452bd..af487b3 100644
--- a/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
+++ b/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
@@ -8,23 +8,7 @@
  static int hidp_get_raw_report(struct hid_device *hid,
  		unsigned char report_number,
  		unsigned char *data, size_t count,
-@@ -307,6 +308,7 @@ err:
- 	mutex_unlock(&session->report_mutex);
- 	return ret;
- }
-+#endif
- 
- static int hidp_set_raw_report(struct hid_device *hid, unsigned char reportnum,
- 			       unsigned char *data, size_t count,
-@@ -382,6 +384,7 @@ static int hidp_output_report(struct hid
- 				      data, count);
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
- static int hidp_raw_request(struct hid_device *hid, unsigned char reportnum,
- 			    __u8 *buf, size_t len, unsigned char rtype,
- 			    int reqtype)
-@@ -395,6 +398,7 @@ static int hidp_raw_request(struct hid_d
+@@ -395,6 +396,7 @@ static int hidp_raw_request(struct hid_d
  		return -EIO;
  	}
  }
@@ -32,7 +16,7 @@
  
  static void hidp_idle_timeout(unsigned long arg)
  {
-@@ -724,8 +728,10 @@ static struct hid_ll_driver hidp_hid_dri
+@@ -724,8 +726,10 @@ static struct hid_ll_driver hidp_hid_dri
  	.stop = hidp_stop,
  	.open  = hidp_open,
  	.close = hidp_close,
-- 
1.9.1

