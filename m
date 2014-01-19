Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58385 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbaASQsm (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:42 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/16] backports: fix unused hidp_get_raw_report() warning
Date: Sun, 19 Jan 2014 17:47:36 +0100
Message-Id: <1390150057-11652-16-git-send-email-hauke@hauke-m.de> (sfid-20140119_174921_903557_675A60E1)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes the following warning:

/net/bluetooth/hidp/core.c:271:12: warning: ‘hidp_get_raw_report’ defined but not used [-Wunused-function]
 static int hidp_get_raw_report(struct hid_device *hid,
            ^

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |   22 ++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
index 4e861f9..29dca32 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
@@ -1,14 +1,24 @@
 --- a/net/bluetooth/hidp/core.c
 +++ b/net/bluetooth/hidp/core.c
-@@ -353,6 +353,7 @@ err:
+@@ -268,6 +268,7 @@ static int hidp_hidinput_event(struct in
+ 	return hidp_send_report(session, field->report);
+ }
+ 
++#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38))
+ static int hidp_get_raw_report(struct hid_device *hid,
+ 		unsigned char report_number,
+ 		unsigned char *data, size_t count,
+@@ -352,7 +353,9 @@ err:
+ 	mutex_unlock(&session->report_mutex);
  	return ret;
  }
++#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38)) */
  
 +#if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
  static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
  		unsigned char report_type)
  {
-@@ -410,6 +411,16 @@ err:
+@@ -410,6 +413,16 @@ err:
  	mutex_unlock(&session->report_mutex);
  	return ret;
  }
@@ -25,7 +35,7 @@
  
  static void hidp_idle_timeout(unsigned long arg)
  {
-@@ -698,6 +709,87 @@ static void hidp_close(struct hid_device
+@@ -698,6 +711,87 @@ static void hidp_close(struct hid_device
  {
  }
  
@@ -113,7 +123,7 @@
  static int hidp_parse(struct hid_device *hid)
  {
  	struct hidp_session *session = hid->driver_data;
-@@ -775,7 +867,9 @@ static int hidp_setup_hid(struct hidp_se
+@@ -775,7 +869,9 @@ static int hidp_setup_hid(struct hidp_se
  	hid->dev.parent = &session->conn->hcon->dev;
  	hid->ll_driver = &hidp_hid_driver;
  
@@ -123,7 +133,7 @@
  	hid->hid_output_raw_report = hidp_output_raw_report;
  
  	/* True if device is blacklisted in drivers/hid/hid-core.c */
-@@ -793,6 +887,7 @@ fault:
+@@ -793,6 +889,7 @@ fault:
  
  	return err;
  }
@@ -131,7 +141,7 @@
  
  /* initialize session devices */
  static int hidp_session_dev_init(struct hidp_session *session,
-@@ -855,10 +950,17 @@ static int hidp_session_dev_add(struct h
+@@ -855,10 +952,17 @@ static int hidp_session_dev_add(struct h
  /* remove HID/input devices from their bus systems */
  static void hidp_session_dev_del(struct hidp_session *session)
  {
-- 
1.7.10.4

