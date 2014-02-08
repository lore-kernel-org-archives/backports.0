Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60058 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbaBHNoq (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 8 Feb 2014 08:44:46 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/6] backports: remove bluetooth HIDP transport-driver functions
Date: Sat,  8 Feb 2014 14:44:26 +0100
Message-Id: <1391867070-20031-3-git-send-email-hauke@hauke-m.de> (sfid-20140208_144447_597022_F148B1E2)
In-Reply-To: <1391867070-20031-1-git-send-email-hauke@hauke-m.de>
References: <1391867070-20031-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The function pointer raw_request and output_report in struct
hid_ll_driver will be added with kernel 3.15, remove useage on
older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../85-hid_ll_driver/net_bluetooth_hidp_core.patch |   55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch

diff --git a/patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch
new file mode 100644
index 0000000..81d742b
--- /dev/null
+++ b/patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch
@@ -0,0 +1,55 @@
+--- a/net/bluetooth/hidp/core.c
++++ b/net/bluetooth/hidp/core.c
+@@ -355,6 +355,7 @@ err:
+ }
+ #endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38)) */
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ static int hidp_set_raw_report(struct hid_device *hid, unsigned char reportnum,
+ 			       unsigned char *data, size_t count,
+ 			       unsigned char report_type)
+@@ -419,6 +420,7 @@ err:
+ 	mutex_unlock(&session->report_mutex);
+ 	return ret;
+ }
++#endif
+ 
+ #if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
+ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
+@@ -489,6 +491,7 @@ static int hidp_output_raw_report(struct
+ }
+ #endif
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ static int hidp_raw_request(struct hid_device *hid, unsigned char reportnum,
+ 			    __u8 *buf, size_t len, unsigned char rtype,
+ 			    int reqtype)
+@@ -502,7 +505,9 @@ static int hidp_raw_request(struct hid_d
+ 		return -EIO;
+ 	}
+ }
++#endif
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ static int hidp_output_report(struct hid_device *hid, __u8 *data, size_t count)
+ {
+ 	struct hidp_session *session = hid->driver_data;
+@@ -511,6 +516,7 @@ static int hidp_output_report(struct hid
+ 				      HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT,
+ 				      data, count);
+ }
++#endif
+ 
+ static void hidp_idle_timeout(unsigned long arg)
+ {
+@@ -909,8 +915,10 @@ static struct hid_ll_driver hidp_hid_dri
+ 	.stop = hidp_stop,
+ 	.open  = hidp_open,
+ 	.close = hidp_close,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ 	.raw_request = hidp_raw_request,
+ 	.output_report = hidp_output_report,
++#endif
+ 	.hidinput_input_event = hidp_hidinput_event,
+ };
+ 
-- 
1.7.10.4

