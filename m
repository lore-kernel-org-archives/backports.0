Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:48823 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612Ab3EKA2D (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:28:03 -0400
Received: by mail-ie0-f180.google.com with SMTP id ar20so9085868iec.39
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:28:02 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	dh.herrmann@gmail.com
Subject: [PATCH 11/12] backports: backport new bluetooth hidp session-management
Date: Fri, 10 May 2013 17:27:02 -0700
Message-Id: <1368232023-23817-12-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022936_253658_F69B18D2)
In-Reply-To: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Commit b4f34d8d9 on next-20130419 added new bluetooth hidp
session-management helper, then commit 520518 also on
next-20130419 replaced the old management code with
the new one.

Someone really needs to run time test this for regressions.

commit b4f34d8d9d26b2428fa7cf7c8f97690a297978e6
Author: David Herrmann <dh.herrmann@gmail.com>
Date:   Sat Apr 6 20:28:46 2013 +0200

    Bluetooth: hidp: add new session-management helpers

    This is a rewrite of the HIDP session management. It implements HIDP as an
    l2cap_user sub-module so we get proper notification when the underlying
    connection goes away.

    The helpers are not yet used but only added in this commit. The old
    session management is still used and will be removed in a following patch.

    The old session-management was flawed. Hotplugging is horribly broken and
    we have no way of getting notified when the underlying connection goes
    down. The whole idea of removing the HID/input sub-devices from within the
    session itself is broken and suffers from major dead-locks. We never can
    guarantee that the session can unregister itself as long as we use
    synchronous shutdowns. This can only work with asynchronous shutdowns.
    However, in this case we _must_ be able to unregister the session from the
    outside as otherwise the l2cap_conn object might be unlinked before we
    are.

    The new session-management is based on l2cap_user. There is only one
    way how to add a session and how to delete a session: "probe" and "remove"
    callbacks from l2cap_user.
    This guarantees that the session can be registered and unregistered at
    _any_ time without any synchronous shutdown.
    On the other hand, much work has been put into proper session-refcounting.
    We can unregister/unlink the session only if we can guarantee that it will
    stay alive. But for asynchronous shutdowns we never know when the last
    user goes away so we must use proper ref-counting.

    The old ->conn field has been renamed to ->hconn so we can reuse ->conn in
    the new session management. No other existing HIDP code is modified.

    Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
    Acked-by: Marcel Holtmann <marcel@holtmann.org>
    Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

commit 5205185d461d5902325e457ca80bd421127b7308
Author: David Herrmann <dh.herrmann@gmail.com>
Date:   Sat Apr 6 20:28:47 2013 +0200

    Bluetooth: hidp: remove old session-management

    We have the full new session-management now available so lets switch over
    and remove all the old code. Few semantics changed, so we need to adjust
    the sock.c callers a bit. But this mostly simplifies the logic.

    Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
    Acked-by: Marcel Holtmann <marcel@holtmann.org>
    Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Cc: dh.herrmann@gmail.com
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |  109 +++++++++-----------
 1 file changed, 51 insertions(+), 58 deletions(-)

diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
index 60a97e6..01a859a 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hidp/core.c
 +++ b/net/bluetooth/hidp/core.c
-@@ -383,6 +383,7 @@ err:
+@@ -329,6 +329,7 @@ err:
  	return ret;
  }
  
@@ -8,7 +8,7 @@
  static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
  		unsigned char report_type)
  {
-@@ -441,6 +442,16 @@ err:
+@@ -386,6 +387,16 @@ err:
  	mutex_unlock(&session->report_mutex);
  	return ret;
  }
@@ -25,22 +25,7 @@
  
  static void hidp_idle_timeout(unsigned long arg)
  {
-@@ -743,8 +754,14 @@ static int hidp_session(void *arg)
- 	}
- 
- 	if (session->hid) {
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27))
- 		hid_destroy_device(session->hid);
- 		session->hid = NULL;
-+#else
-+		if (session->hid->claimed & HID_CLAIMED_INPUT)
-+			hidinput_disconnect(session->hid);
-+		hid_free_device(session->hid);
-+#endif
- 	}
- 
- 	/* Wakeup user-space polling for socket errors */
-@@ -855,6 +872,70 @@ static void hidp_close(struct hid_device
+@@ -674,6 +685,70 @@ static void hidp_close(struct hid_device
  {
  }
  
@@ -111,8 +96,8 @@
  static int hidp_parse(struct hid_device *hid)
  {
  	struct hidp_session *session = hid->driver_data;
-@@ -946,7 +1027,9 @@ static int hidp_setup_hid(struct hidp_se
- 	hid->dev.parent = &session->conn->dev;
+@@ -764,13 +839,21 @@ static int hidp_setup_hid(struct hidp_se
+ 	hid->dev.parent = &session->conn->hcon->dev;
  	hid->ll_driver = &hidp_hid_driver;
  
 +#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38))
@@ -121,17 +106,46 @@
  	hid->hid_output_raw_report = hidp_output_raw_report;
  
  	/* True if device is blacklisted in drivers/hid/hid-core.c */
-@@ -964,6 +1047,7 @@ fault:
+ 	if (hid_ignore(hid)) {
++#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27))
+ 		hid_destroy_device(session->hid);
+ 		session->hid = NULL;
++#else
++		if (session->hid->claimed & HID_CLAIMED_INPUT)
++			hidinput_disconnect(session->hid);
++		hid_free_device(session->hid);
++#endif
+ 		return -ENODEV;
+ 	}
+ 
+@@ -782,6 +865,7 @@ fault:
  
  	return err;
  }
 +#endif
  
- int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock)
+ /* initialize session devices */
+ static int hidp_session_dev_init(struct hidp_session *session,
+@@ -844,8 +928,15 @@ static int hidp_session_dev_add(struct h
+ /* remove HID/input devices from their bus systems */
+ static void hidp_session_dev_del(struct hidp_session *session)
  {
-@@ -981,6 +1065,39 @@ int hidp_add_connection(struct hidp_conn
- 
- 	BT_DBG("rd_data %p rd_size %d", req->rd_data, req->rd_size);
+-	if (session->hid)
++	if (session->hid) {
++#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27))
+ 		hid_destroy_device(session->hid);
++#else
++		if (session->hid->claimed & HID_CLAIMED_INPUT)
++			hidinput_disconnect(session->hid);
++		hid_free_device(session->hid);
++#endif
++	}
+ 	else if (session->input)
+ 		input_unregister_device(session->input);
+ }
+@@ -1049,6 +1140,39 @@ static int hidp_session_probe(struct l2c
+ 	struct hidp_session *s;
+ 	int ret;
  
 +#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,27))
 +	if (req->rd_size > 0) {
@@ -168,20 +182,12 @@
 +#endif
  	down_write(&hidp_session_sem);
  
- 	s = __hidp_get_session(&bt_sk(ctrl_sock->sk)->dst);
-@@ -1028,6 +1145,7 @@ int hidp_add_connection(struct hidp_conn
- 
- 	__hidp_link_session(session);
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27))
- 	if (req->rd_size > 0) {
- 		err = hidp_setup_hid(session, req);
- 		if (err && err != -ENODEV)
-@@ -1039,6 +1157,16 @@ int hidp_add_connection(struct hidp_conn
- 		if (err < 0)
- 			goto purge;
+ 	/* check that no other session for this device exists */
+@@ -1057,6 +1181,16 @@ static int hidp_session_probe(struct l2c
+ 		ret = -EEXIST;
+ 		goto out_unlock;
  	}
-+#else
++#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,27))
 +	if (session->input) {
 +		err = hidp_setup_input(session, req);
 +		if (err < 0)
@@ -192,29 +198,16 @@
 +		hidp_setup_hid(session, req);
 +#endif
  
- 	hidp_set_timer(session);
- 
-@@ -1097,6 +1225,7 @@ unlink:
- 		session->input = NULL;
- 	}
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27))
- 	if (session->hid) {
- 		hid_destroy_device(session->hid);
- 		session->hid = NULL;
-@@ -1110,10 +1239,15 @@ purge:
- 
- 	skb_queue_purge(&session->ctrl_transmit);
- 	skb_queue_purge(&session->intr_transmit);
-+#endif
- 
- failed:
+ 	ret = hidp_session_start_sync(session);
+ 	if (ret)
+@@ -1075,6 +1209,10 @@ out_stop:
+ 	hidp_session_terminate(session);
+ out_unlock:
  	up_write(&hidp_session_sem);
- 
 +#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,27))
 +	if (session->hid)
 +		hid_free_device(session->hid);
 +#endif
- 	kfree(session);
- 	return err;
+ 	return ret;
  }
+ 
-- 
1.7.10.4

