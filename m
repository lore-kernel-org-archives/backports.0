Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:40452 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab3EMKEj (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 06:04:39 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so4505356pad.11
        for <backports@vger.kernel.org>; Mon, 13 May 2013 03:04:39 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v2] backports: backport new bluetooth hidp session-management
Date: Mon, 13 May 2013 03:04:33 -0700
Message-Id: <1368439473-21595-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130513_120448_148697_40AA23B5)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Commit b4f34d8d9 on next-20130419 added new bluetooth hidp
session-management helper, then commit 520518 also on
next-20130419 replaced the old management code with
the new one. Thanks to David Herrmann for his review and
his changes for this backport.

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

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |  157 ++++++--------------
 1 file changed, 45 insertions(+), 112 deletions(-)

diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
index 60a97e6..7333764 100644
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
+@@ -674,6 +685,87 @@ static void hidp_close(struct hid_device
  {
  }
  
@@ -65,12 +50,27 @@
 +			hid->quirks = hidp_blacklist[n].quirks;
 +}
 +
-+static void hidp_setup_hid(struct hidp_session *session,
-+				struct hidp_connadd_req *req)
++static int hidp_setup_hid(struct hidp_session *session,
++			  struct hidp_connadd_req *req)
 +{
-+	struct hid_device *hid = session->hid;
++	struct hid_device *hid;
 +	struct hid_report *report;
 +	bdaddr_t src, dst;
++	unsigned char *buf;
++
++	buf = kmalloc(req->rd_size, GFP_KERNEL);
++	if (!buf)
++		return -ENOMEM;
++
++	if (copy_from_user(buf, req->rd_data, req->rd_size)) {
++		kfree(buf);
++		return -EFAULT;
++	}
++
++	hid = hid_parse_report(buf, req->rd_size);
++	kfree(buf);
++	if (!session->hid)
++		return -EINVAL;
 +
 +	session->hid = hid;
 +
@@ -85,9 +85,9 @@
 +	hid->version = req->version;
 +	hid->country = req->country;
 +
-+	strncpy(hid->name, req->name, 128);
-+	strncpy(hid->phys, batostr(&src), 64);
-+	strncpy(hid->uniq, batostr(&dst), 64);
++	strlcpy(hid->name, req->name, 128);
++	strlcpy(hid->phys, batostr(&src), 64);
++	strlcpy(hid->uniq, batostr(&dst), 64);
 +
 +	hid->dev = hidp_get_device(session);
 +	hid->hid_open  = hidp_open;
@@ -105,14 +105,16 @@
 +
 +	if (hidinput_connect(hid) == 0)
 +		hid->claimed |= HID_CLAIMED_INPUT;
++
++	return 0;
 +}
 +#else
 +
  static int hidp_parse(struct hid_device *hid)
  {
  	struct hidp_session *session = hid->driver_data;
-@@ -946,7 +1027,9 @@ static int hidp_setup_hid(struct hidp_se
- 	hid->dev.parent = &session->conn->dev;
+@@ -764,7 +856,9 @@ static int hidp_setup_hid(struct hidp_se
+ 	hid->dev.parent = &session->conn->hcon->dev;
  	hid->ll_driver = &hidp_hid_driver;
  
 +#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38))
@@ -121,100 +123,31 @@
  	hid->hid_output_raw_report = hidp_output_raw_report;
  
  	/* True if device is blacklisted in drivers/hid/hid-core.c */
-@@ -964,6 +1047,7 @@ fault:
+@@ -782,6 +876,7 @@ fault:
  
  	return err;
  }
 +#endif
  
- int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock)
+ /* initialize session devices */
+ static int hidp_session_dev_init(struct hidp_session *session,
+@@ -844,10 +939,17 @@ static int hidp_session_dev_add(struct h
+ /* remove HID/input devices from their bus systems */
+ static void hidp_session_dev_del(struct hidp_session *session)
  {
-@@ -981,6 +1065,39 @@ int hidp_add_connection(struct hidp_conn
- 
- 	BT_DBG("rd_data %p rd_size %d", req->rd_data, req->rd_size);
- 
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,27))
-+	if (req->rd_size > 0) {
-+		unsigned char *buf = kmalloc(req->rd_size, GFP_KERNEL);
-+
-+		if (!buf) {
-+			kfree(session);
-+			return -ENOMEM;
-+		}
-+
-+		if (copy_from_user(buf, req->rd_data, req->rd_size)) {
-+			kfree(buf);
-+			kfree(session);
-+			return -EFAULT;
-+		}
-+
-+		session->hid = hid_parse_report(buf, req->rd_size);
-+
-+		kfree(buf);
-+
-+		if (!session->hid) {
-+			kfree(session);
-+			return -EINVAL;
-+		}
-+	}
-+
-+	if (!session->hid) {
-+		session->input = input_allocate_device();
-+		if (!session->input) {
-+			kfree(session);
-+			return -ENOMEM;
-+		}
-+	}
-+#endif
- 	down_write(&hidp_session_sem);
- 
- 	s = __hidp_get_session(&bt_sk(ctrl_sock->sk)->dst);
-@@ -1028,6 +1145,7 @@ int hidp_add_connection(struct hidp_conn
- 
- 	__hidp_link_session(session);
- 
+-	if (session->hid)
++	if (session->hid) {
 +#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27))
- 	if (req->rd_size > 0) {
- 		err = hidp_setup_hid(session, req);
- 		if (err && err != -ENODEV)
-@@ -1039,6 +1157,16 @@ int hidp_add_connection(struct hidp_conn
- 		if (err < 0)
- 			goto purge;
- 	}
-+#else
-+	if (session->input) {
-+		err = hidp_setup_input(session, req);
-+		if (err < 0)
-+			goto failed;
-+	}
-+
-+	if (session->hid)
-+		hidp_setup_hid(session, req);
-+#endif
- 
- 	hidp_set_timer(session);
- 
-@@ -1097,6 +1225,7 @@ unlink:
- 		session->input = NULL;
- 	}
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27))
- 	if (session->hid) {
  		hid_destroy_device(session->hid);
- 		session->hid = NULL;
-@@ -1110,10 +1239,15 @@ purge:
- 
- 	skb_queue_purge(&session->ctrl_transmit);
- 	skb_queue_purge(&session->intr_transmit);
-+#endif
- 
- failed:
- 	up_write(&hidp_session_sem);
- 
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,27))
-+	if (session->hid)
+-	else if (session->input)
++#else
++		if (session->hid->claimed & HID_CLAIMED_INPUT)
++			hidinput_disconnect(session->hid);
 +		hid_free_device(session->hid);
 +#endif
- 	kfree(session);
- 	return err;
++	} else if (session->input) {
+ 		input_unregister_device(session->input);
++	}
  }
+ 
+ /*
-- 
1.7.10.4

