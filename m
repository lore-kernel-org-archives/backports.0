Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56147 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbbGKVfe (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 11 Jul 2015 17:35:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] patches: remove usage of wait_on_bit_timeout() on older kernels
Date: Sat, 11 Jul 2015 23:35:27 +0200
Message-Id: <1436650528-2805-2-git-send-email-hauke@hauke-m.de> (sfid-20150711_233536_749285_4FAD4408)
In-Reply-To: <1436650528-2805-1-git-send-email-hauke@hauke-m.de>
References: <1436650528-2805-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was intoduced in this commit:
commit 431a9e1713c512bb96d570dc84e518384d1ac62b
Author: Loic Poulain <loic.poulain@intel.com>
Date:   Wed Jul 1 12:20:26 2015 +0200

    Bluetooth: hci_uart: Add basic support for Intel Lightning Peak devices

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../hci_intel.patch                                | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch

diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
new file mode 100644
index 0000000..b8d1e7e
--- /dev/null
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
@@ -0,0 +1,88 @@
+diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
+index 21dfa89..f246352 100644
+--- a/drivers/bluetooth/hci_intel.c
++++ b/drivers/bluetooth/hci_intel.c
+@@ -383,6 +383,7 @@ static int intel_setup(struct hci_uart *
+ 	 * and thus just timeout if that happens and fail the setup
+ 	 * of this device.
+ 	 */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 	err = wait_on_bit_timeout(&intel->flags, STATE_DOWNLOADING,
+ 				  TASK_INTERRUPTIBLE,
+ 				  msecs_to_jiffies(5000));
+@@ -403,6 +404,33 @@ static int intel_setup(struct hci_uart *
+ 		err = -ENOEXEC;
+ 		goto done;
+ 	}
++#else
++	if (test_bit(STATE_DOWNLOADING, &intel->flags)) {
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
++		timeout = schedule_timeout(msecs_to_jiffies(5000));
++
++		remove_wait_queue(&hdev->req_wait_q, &wait);
++
++		if (signal_pending(current)) {
++			BT_ERR("%s: Firmware loading interrupted", hdev->name);
++			return -EINTR;
++		}
++
++		if (!timeout) {
++			BT_ERR("%s: Firmware loading timeout", hdev->name);
++			return -ETIMEDOUT;
++		}
++	}
++#endif
+ 
+ 	rettime = ktime_get();
+ 	delta = ktime_sub(rettime, calltime);
+@@ -436,6 +464,7 @@ done:
+ 	 */
+ 	BT_INFO("%s: Waiting for device to boot", hdev->name);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 	err = wait_on_bit_timeout(&intel->flags, STATE_BOOTING,
+ 				  TASK_INTERRUPTIBLE,
+ 				  msecs_to_jiffies(1000));
+@@ -449,6 +478,33 @@ done:
+ 		BT_ERR("%s: Device boot timeout", hdev->name);
+ 		return -ETIMEDOUT;
+ 	}
++#else
++	if (test_bit(STATE_BOOTING, &intel->flags)) {
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
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
