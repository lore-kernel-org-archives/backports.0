Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51940 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753345AbbIUWHb (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Sep 2015 18:07:31 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/10] patches: fix patch for wait_on_bit_timeout()
Date: Tue, 22 Sep 2015 00:07:16 +0200
Message-Id: <1442873243-15490-4-git-send-email-hauke@hauke-m.de> (sfid-20150922_000735_828838_E8533AC9)
In-Reply-To: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
References: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

wake_up_interruptible() is missing in this patch, otherwise it will not
be woken up again. In addition this patch adds the missing
STATE_LPM_TRANSACTION state now and follows the moving of some parts in
the code of the driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../hci_intel.patch                                | 154 ++++++++++++++++-----
 1 file changed, 123 insertions(+), 31 deletions(-)

diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
index b8d1e7e..89e42d1 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
@@ -1,63 +1,105 @@
-diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
-index 21dfa89..f246352 100644
 --- a/drivers/bluetooth/hci_intel.c
 +++ b/drivers/bluetooth/hci_intel.c
-@@ -383,6 +383,7 @@ static int intel_setup(struct hci_uart *
- 	 * and thus just timeout if that happens and fail the setup
- 	 * of this device.
- 	 */
+@@ -122,8 +122,9 @@ static u8 intel_convert_speed(unsigned i
+ static int intel_wait_booting(struct hci_uart *hu)
+ {
+ 	struct intel_data *intel = hu->priv;
+-	int err;
++	int err = 0;
+ 
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
- 	err = wait_on_bit_timeout(&intel->flags, STATE_DOWNLOADING,
+ 	err = wait_on_bit_timeout(&intel->flags, STATE_BOOTING,
  				  TASK_INTERRUPTIBLE,
- 				  msecs_to_jiffies(5000));
-@@ -403,6 +404,33 @@ static int intel_setup(struct hci_uart *
- 		err = -ENOEXEC;
- 		goto done;
+ 				  msecs_to_jiffies(1000));
+@@ -137,6 +138,33 @@ static int intel_wait_booting(struct hci
+ 		bt_dev_err(hu->hdev, "Device boot timeout");
+ 		return -ETIMEDOUT;
  	}
 +#else
-+	if (test_bit(STATE_DOWNLOADING, &intel->flags)) {
++	if (test_bit(STATE_BOOTING, &intel->flags)) {
 +		DECLARE_WAITQUEUE(wait, current);
 +		signed long timeout;
 +
-+		add_wait_queue(&hdev->req_wait_q, &wait);
++		add_wait_queue(&hu->hdev->req_wait_q, &wait);
 +		set_current_state(TASK_INTERRUPTIBLE);
 +
 +		/* Booting into operational firmware should not take
 +		 * longer than 1 second. However if that happens, then
 +		 * just fail the setup since something went wrong.
 +		 */
-+		timeout = schedule_timeout(msecs_to_jiffies(5000));
++		timeout = schedule_timeout(msecs_to_jiffies(1000));
 +
-+		remove_wait_queue(&hdev->req_wait_q, &wait);
++		remove_wait_queue(&hu->hdev->req_wait_q, &wait);
 +
 +		if (signal_pending(current)) {
-+			BT_ERR("%s: Firmware loading interrupted", hdev->name);
++			BT_ERR("%s: Device boot interrupted", hu->hdev->name);
 +			return -EINTR;
 +		}
 +
 +		if (!timeout) {
-+			BT_ERR("%s: Firmware loading timeout", hdev->name);
++			BT_ERR("%s: Device boot timeout", hu->hdev->name);
 +			return -ETIMEDOUT;
 +		}
 +	}
 +#endif
  
- 	rettime = ktime_get();
- 	delta = ktime_sub(rettime, calltime);
-@@ -436,6 +464,7 @@ done:
- 	 */
- 	BT_INFO("%s: Waiting for device to boot", hdev->name);
+ 	return err;
+ }
+@@ -144,8 +172,9 @@ static int intel_wait_booting(struct hci
+ static int intel_wait_lpm_transaction(struct hci_uart *hu)
+ {
+ 	struct intel_data *intel = hu->priv;
+-	int err;
++	int err = 0;
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
- 	err = wait_on_bit_timeout(&intel->flags, STATE_BOOTING,
+ 	err = wait_on_bit_timeout(&intel->flags, STATE_LPM_TRANSACTION,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -449,6 +478,33 @@ done:
- 		BT_ERR("%s: Device boot timeout", hdev->name);
+@@ -159,6 +188,29 @@ static int intel_wait_lpm_transaction(st
+ 		bt_dev_err(hu->hdev, "LPM transaction timeout");
  		return -ETIMEDOUT;
  	}
 +#else
-+	if (test_bit(STATE_BOOTING, &intel->flags)) {
++	if (test_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
++		DECLARE_WAITQUEUE(wait, current);
++		signed long timeout;
++
++		add_wait_queue(&hu->hdev->req_wait_q, &wait);
++		set_current_state(TASK_INTERRUPTIBLE);
++
++		timeout = schedule_timeout(msecs_to_jiffies(1000));
++
++		remove_wait_queue(&hu->hdev->req_wait_q, &wait);
++
++		if (signal_pending(current)) {
++			BT_ERR("%s: LPM transaction interrupted", hu->hdev->name);
++			return -EINTR;
++		}
++
++		if (!timeout) {
++			BT_ERR("%s: LPM transaction timeout", hu->hdev->name);
++			return -ETIMEDOUT;
++		}
++	}
++#endif
+ 
+ 	return err;
+ }
+@@ -826,6 +878,7 @@ static int intel_setup(struct hci_uart *
+ 	 * and thus just timeout if that happens and fail the setup
+ 	 * of this device.
+ 	 */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 	err = wait_on_bit_timeout(&intel->flags, STATE_DOWNLOADING,
+ 				  TASK_INTERRUPTIBLE,
+ 				  msecs_to_jiffies(5000));
+@@ -840,6 +893,33 @@ static int intel_setup(struct hci_uart *
+ 		err = -ETIMEDOUT;
+ 		goto done;
+ 	}
++#else
++	if (test_bit(STATE_DOWNLOADING, &intel->flags)) {
 +		DECLARE_WAITQUEUE(wait, current);
 +		signed long timeout;
 +
@@ -68,21 +110,71 @@ index 21dfa89..f246352 100644
 +		 * longer than 1 second. However if that happens, then
 +		 * just fail the setup since something went wrong.
 +		 */
-+		timeout = schedule_timeout(msecs_to_jiffies(1000));
++		timeout = schedule_timeout(msecs_to_jiffies(5000));
 +
 +		remove_wait_queue(&hdev->req_wait_q, &wait);
 +
 +		if (signal_pending(current)) {
-+			BT_ERR("%s: Device boot interrupted", hdev->name);
++			BT_ERR("%s: Firmware loading interrupted", hdev->name);
 +			return -EINTR;
 +		}
 +
 +		if (!timeout) {
-+			BT_ERR("%s: Device boot timeout", hdev->name);
++			BT_ERR("%s: Firmware loading timeout", hdev->name);
 +			return -ETIMEDOUT;
 +		}
 +	}
 +#endif
  
- 	rettime = ktime_get();
- 	delta = ktime_sub(rettime, calltime);
+ 	if (test_bit(STATE_FIRMWARE_FAILED, &intel->flags)) {
+ 		bt_dev_err(hdev, "Firmware loading failed");
+@@ -968,8 +1048,12 @@ static int intel_recv_event(struct hci_d
+ 
+ 		if (test_and_clear_bit(STATE_DOWNLOADING, &intel->flags) &&
+ 		    test_bit(STATE_FIRMWARE_LOADED, &intel->flags)) {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 			smp_mb__after_atomic();
+ 			wake_up_bit(&intel->flags, STATE_DOWNLOADING);
++#else
++			wake_up_interruptible(&hu->hdev->req_wait_q);
++#endif
+ 		}
+ 
+ 	/* When switching to the operational firmware the device
+@@ -979,8 +1063,12 @@ static int intel_recv_event(struct hci_d
+ 	} else if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
+ 		   skb->data[2] == 0x02) {
+ 		if (test_and_clear_bit(STATE_BOOTING, &intel->flags)) {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 			smp_mb__after_atomic();
+ 			wake_up_bit(&intel->flags, STATE_BOOTING);
++#else
++			wake_up_interruptible(&hu->hdev->req_wait_q);
++#endif
+ 		}
+ 	}
+ recv:
+@@ -1019,15 +1107,23 @@ static int intel_recv_lpm(struct hci_dev
+ 	case LPM_OP_SUSPEND_ACK:
+ 		set_bit(STATE_SUSPENDED, &intel->flags);
+ 		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 			smp_mb__after_atomic();
+ 			wake_up_bit(&intel->flags, STATE_LPM_TRANSACTION);
++#else
++			wake_up_interruptible(&hu->hdev->req_wait_q);
++#endif
+ 		}
+ 		break;
+ 	case LPM_OP_RESUME_ACK:
+ 		clear_bit(STATE_SUSPENDED, &intel->flags);
+ 		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 			smp_mb__after_atomic();
+ 			wake_up_bit(&intel->flags, STATE_LPM_TRANSACTION);
++#else
++			wake_up_interruptible(&hu->hdev->req_wait_q);
++#endif
+ 		}
+ 		break;
+ 	default:
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
