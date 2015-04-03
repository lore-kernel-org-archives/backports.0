Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39195 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448AbbDCRY2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 13:24:28 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/11] patches: remove usage of wait_on_bit_timeout() in btusb.c
Date: Fri,  3 Apr 2015 19:15:35 +0200
Message-Id: <1428081342-5933-5-git-send-email-hauke@hauke-m.de> (sfid-20150403_192435_146243_4B5C4BD9)
In-Reply-To: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
References: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

wait_on_bit_timeout() is only supported with kernel >= 3.17 in
backports. On older kernel versions we go back to the old
implementation. The new implementation was introduced in commits:
a087a98, fad7097 and 129a769.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 110 +++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch

diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
new file mode 100644
index 0000000..e4b5b28
--- /dev/null
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -0,0 +1,110 @@
+--- a/drivers/bluetooth/btusb.c
++++ b/drivers/bluetooth/btusb.c
+@@ -1806,8 +1806,12 @@ static int btusb_recv_event_intel(struct
+ 			if (test_and_clear_bit(BTUSB_DOWNLOADING,
+ 					       &data->flags) &&
+ 			    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 				smp_mb__after_atomic();
+ 				wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
++#else
++				wake_up_interruptible(&hdev->req_wait_q);
++#endif
+ 			}
+ 		}
+ 
+@@ -1818,8 +1822,12 @@ static int btusb_recv_event_intel(struct
+ 		if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
+ 		    skb->data[2] == 0x02) {
+ 			if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 				smp_mb__after_atomic();
+ 				wake_up_bit(&data->flags, BTUSB_BOOTING);
++#else
++				wake_up_interruptible(&hdev->req_wait_q);
++#endif
+ 			}
+ 		}
+ 	}
+@@ -2187,6 +2195,7 @@ static int btusb_setup_intel_new(struct
+ 	 * and thus just timeout if that happens and fail the setup
+ 	 * of this device.
+ 	 */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
+ 				  TASK_INTERRUPTIBLE,
+ 				  msecs_to_jiffies(5000));
+@@ -2201,6 +2210,31 @@ static int btusb_setup_intel_new(struct
+ 		err = -ETIMEDOUT;
+ 		goto done;
+ 	}
++#else
++	if (test_bit(BTUSB_DOWNLOADING, &data->flags)) {
++		DECLARE_WAITQUEUE(wait, current);
++		signed long timeout;
++
++		add_wait_queue(&hdev->req_wait_q, &wait);
++		set_current_state(TASK_INTERRUPTIBLE);
++
++		timeout = schedule_timeout(msecs_to_jiffies(5000));
++
++		remove_wait_queue(&hdev->req_wait_q, &wait);
++
++		if (signal_pending(current)) {
++			BT_ERR("%s: Firmware loading interrupted", hdev->name);
++			err = -EINTR;
++			goto done;
++		}
++
++		if (!timeout) {
++			BT_ERR("%s: Firmware loading timeout", hdev->name);
++			err = -ETIMEDOUT;
++			goto done;
++		}
++	}
++#endif
+ 
+ 	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
+ 		BT_ERR("%s: Firmware loading failed", hdev->name);
+@@ -2240,6 +2274,7 @@ done:
+ 	 */
+ 	BT_INFO("%s: Waiting for device to boot", hdev->name);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
+ 				  TASK_INTERRUPTIBLE,
+ 				  msecs_to_jiffies(1000));
+@@ -2253,6 +2288,33 @@ done:
+ 		BT_ERR("%s: Device boot timeout", hdev->name);
+ 		return -ETIMEDOUT;
+ 	}
++#else
++	if (test_bit(BTUSB_BOOTING, &data->flags)) {
++		DECLARE_WAITQUEUE(wait, current);
++		signed long timeout;
++
++		add_wait_queue(&hdev->req_wait_q, &wait);
++		set_current_state(TASK_INTERRUPTIBLE);
++
++		/* Booting into operational firmware should not take
++		 * longer than 1 second. However if that happens, then
++		 * just fail the setup since something went wrong.
++		 */
++		timeout = schedule_timeout(msecs_to_jiffies(1000));
++
++		remove_wait_queue(&hdev->req_wait_q, &wait);
++
++		if (signal_pending(current)) {
++			BT_ERR("%s: Device boot interrupted", hdev->name);
++			return -EINTR;
++		}
++
++		if (!timeout) {
++			BT_ERR("%s: Device boot timeout", hdev->name);
++			return -ETIMEDOUT;
++		}
++	}
++#endif
+ 
+ 	rettime = ktime_get();
+ 	delta = ktime_sub(rettime, calltime);
-- 
1.9.1

