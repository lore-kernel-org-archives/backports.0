Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:46325 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215AbbKAXpf (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 1 Nov 2015 18:45:35 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] patches: refresh patches on next-20150923
Date: Mon,  2 Nov 2015 00:45:21 +0100
Message-Id: <1446421522-27167-2-git-send-email-hauke@hauke-m.de> (sfid-20151102_004539_602129_11B1F5A7)
In-Reply-To: <1446421522-27167-1-git-send-email-hauke@hauke-m.de>
References: <1446421522-27167-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.72              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.110             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.92             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.49             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.56             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.23             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.9               [  OK  ]
22  4.1.12              [  OK  ]
23  4.2.5               [  OK  ]
24  4.3-rc7             [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0013-fix-makefile-includes/frame_vector.patch    |  2 +-
 .../network/0025-usb-sg/usbnet.patch                 | 12 ++++++------
 .../0053-remove_wait_on_bit_timeout/btusb.patch      | 12 ++++++------
 .../0053-remove_wait_on_bit_timeout/hci_intel.patch  | 14 +++++++-------
 .../network/0062-acpi-gpio-remove/hci_bcm.patch      | 20 ++++++++++----------
 .../network/0062-acpi-gpio-remove/hci_intel.patch    |  8 ++++----
 6 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/frame_vector.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/frame_vector.patch
index 1df2f6d..66d9eaf 100644
--- a/patches/collateral-evolutions/network/0013-fix-makefile-includes/frame_vector.patch
+++ b/patches/collateral-evolutions/network/0013-fix-makefile-includes/frame_vector.patch
@@ -6,5 +6,5 @@
  #include <linux/sched.h>
 +#include <linux/export.h>
  
- /*
+ /**
   * get_vaddr_frames() - map virtual addresses to pfns
diff --git a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
index 3618f9c..13e09ea 100644
--- a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1249,6 +1249,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1267,6 +1267,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1281,6 +1282,12 @@ static int build_dma_sg(const struct sk_
+@@ -1299,6 +1300,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1337,12 +1344,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1355,12 +1362,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1409,7 +1423,9 @@ not_drop:
+@@ -1427,7 +1441,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1462,7 +1478,9 @@ static void usbnet_bh (unsigned long par
+@@ -1480,7 +1496,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1818,7 +1836,9 @@ int usbnet_resume (struct usb_interface
+@@ -1836,7 +1854,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index 59a8694..7c65bcc 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1764,8 +1764,12 @@ static void btusb_intel_bootup(struct bt
+@@ -1778,8 +1778,12 @@ static void btusb_intel_bootup(struct bt
  		return;
  
  	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
@@ -13,7 +13,7 @@
  	}
  }
  
-@@ -1782,8 +1786,12 @@ static void btusb_intel_secure_send_resu
+@@ -1796,8 +1800,12 @@ static void btusb_intel_secure_send_resu
  
  	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
  	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
@@ -26,7 +26,7 @@
  	}
  }
  
-@@ -2138,6 +2146,7 @@ static int btusb_setup_intel_new(struct
+@@ -2152,6 +2160,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2152,6 +2161,31 @@ static int btusb_setup_intel_new(struct
+@@ -2166,6 +2175,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2191,6 +2225,7 @@ done:
+@@ -2205,6 +2239,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2204,6 +2239,33 @@ done:
+@@ -2218,6 +2253,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
index 89e42d1..1faf5ab 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
@@ -45,7 +45,7 @@
  
  	return err;
  }
-@@ -144,8 +172,9 @@ static int intel_wait_booting(struct hci
+@@ -145,8 +173,9 @@ static int intel_wait_booting(struct hci
  static int intel_wait_lpm_transaction(struct hci_uart *hu)
  {
  	struct intel_data *intel = hu->priv;
@@ -56,7 +56,7 @@
  	err = wait_on_bit_timeout(&intel->flags, STATE_LPM_TRANSACTION,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -159,6 +188,29 @@ static int intel_wait_lpm_transaction(st
+@@ -160,6 +189,29 @@ static int intel_wait_lpm_transaction(st
  		bt_dev_err(hu->hdev, "LPM transaction timeout");
  		return -ETIMEDOUT;
  	}
@@ -86,7 +86,7 @@
  
  	return err;
  }
-@@ -826,6 +878,7 @@ static int intel_setup(struct hci_uart *
+@@ -835,6 +887,7 @@ static int intel_setup(struct hci_uart *
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -94,7 +94,7 @@
  	err = wait_on_bit_timeout(&intel->flags, STATE_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -840,6 +893,33 @@ static int intel_setup(struct hci_uart *
+@@ -849,6 +902,33 @@ static int intel_setup(struct hci_uart *
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -128,7 +128,7 @@
  
  	if (test_bit(STATE_FIRMWARE_FAILED, &intel->flags)) {
  		bt_dev_err(hdev, "Firmware loading failed");
-@@ -968,8 +1048,12 @@ static int intel_recv_event(struct hci_d
+@@ -980,8 +1060,12 @@ static int intel_recv_event(struct hci_d
  
  		if (test_and_clear_bit(STATE_DOWNLOADING, &intel->flags) &&
  		    test_bit(STATE_FIRMWARE_LOADED, &intel->flags)) {
@@ -141,7 +141,7 @@
  		}
  
  	/* When switching to the operational firmware the device
-@@ -979,8 +1063,12 @@ static int intel_recv_event(struct hci_d
+@@ -991,8 +1075,12 @@ static int intel_recv_event(struct hci_d
  	} else if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
  		   skb->data[2] == 0x02) {
  		if (test_and_clear_bit(STATE_BOOTING, &intel->flags)) {
@@ -154,7 +154,7 @@
  		}
  	}
  recv:
-@@ -1019,15 +1107,23 @@ static int intel_recv_lpm(struct hci_dev
+@@ -1031,15 +1119,23 @@ static int intel_recv_lpm(struct hci_dev
  	case LPM_OP_SUSPEND_ACK:
  		set_bit(STATE_SUSPENDED, &intel->flags);
  		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
diff --git a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
index 76e90f0..9e77bb0 100644
--- a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
+++ b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
@@ -8,9 +8,9 @@
  #include <linux/gpio/consumer.h>
 +#endif
  #include <linux/tty.h>
+ #include <linux/interrupt.h>
  
- #include <net/bluetooth/bluetooth.h>
-@@ -138,8 +140,10 @@ static int bcm_gpio_set_power(struct bcm
+@@ -141,8 +143,10 @@ static int bcm_gpio_set_power(struct bcm
  	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
  		clk_enable(dev->clk);
  
@@ -21,7 +21,7 @@
  
  	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
  		clk_disable(dev->clk);
-@@ -352,7 +356,9 @@ static int bcm_suspend(struct device *de
+@@ -447,7 +451,9 @@ static int bcm_suspend(struct device *de
  
  	/* Suspend the device */
  	if (bdev->device_wakeup) {
@@ -31,8 +31,8 @@
  		bt_dev_dbg(bdev, "suspend, delaying 15 ms");
  		mdelay(15);
  	}
-@@ -376,7 +382,9 @@ static int bcm_resume(struct device *dev
- 		goto unlock;
+@@ -482,7 +488,9 @@ static int bcm_resume(struct device *dev
+ 	}
  
  	if (bdev->device_wakeup) {
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
@@ -41,15 +41,15 @@
  		bt_dev_dbg(bdev, "resume, delaying 15 ms");
  		mdelay(15);
  	}
-@@ -395,6 +403,7 @@ unlock:
+@@ -501,6 +509,7 @@ unlock:
  }
  #endif
  
 +#if defined(CONFIG_ACPI) && LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
  static const struct acpi_gpio_params device_wakeup_gpios = { 0, 0, false };
  static const struct acpi_gpio_params shutdown_gpios = { 1, 0, false };
- 
-@@ -404,7 +413,6 @@ static const struct acpi_gpio_mapping ac
+ static const struct acpi_gpio_params host_wakeup_gpios = { 2, 0, false };
+@@ -512,7 +521,6 @@ static const struct acpi_gpio_mapping ac
  	{ },
  };
  
@@ -57,7 +57,7 @@
  static int bcm_resource(struct acpi_resource *ares, void *data)
  {
  	struct bcm_device *dev = data;
-@@ -543,7 +551,7 @@ static const struct hci_uart_proto bcm_p
+@@ -683,7 +691,7 @@ static const struct hci_uart_proto bcm_p
  	.dequeue	= bcm_dequeue,
  };
  
@@ -66,7 +66,7 @@
  static const struct acpi_device_id bcm_acpi_match[] = {
  	{ "BCM2E39", 0 },
  	{ "BCM2E67", 0 },
-@@ -560,7 +568,9 @@ static struct platform_driver bcm_driver
+@@ -700,7 +708,9 @@ static struct platform_driver bcm_driver
  	.remove = bcm_remove,
  	.driver = {
  		.name = "hci_bcm",
diff --git a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
index a6a7d0f..971bffb 100644
--- a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
+++ b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
@@ -10,7 +10,7 @@
  #include <linux/acpi.h>
  #include <linux/interrupt.h>
  #include <linux/pm_runtime.h>
-@@ -374,7 +376,9 @@ static int intel_set_power(struct hci_ua
+@@ -379,7 +381,9 @@ static int intel_set_power(struct hci_ua
  		BT_INFO("hu %p, Switching compatible pm device (%s) to %u",
  			hu, dev_name(&idev->pdev->dev), powered);
  
@@ -20,7 +20,7 @@
  
  		/* Provide to idev a hu reference which is used to run LPM
  		 * transactions (lpm suspend/resume) from PM callbacks.
-@@ -1322,14 +1326,17 @@ static int intel_probe(struct platform_d
+@@ -1352,14 +1356,17 @@ static int intel_probe(struct platform_d
  		return -ENODEV;
  	}
  
@@ -38,7 +38,7 @@
  	if (idev->irq < 0) {
  		struct gpio_desc *host_wake;
  
-@@ -1348,12 +1355,15 @@ static int intel_probe(struct platform_d
+@@ -1378,12 +1385,15 @@ static int intel_probe(struct platform_d
  			goto no_irq;
  		}
  	}
@@ -54,7 +54,7 @@
  	platform_set_drvdata(pdev, idev);
  
  	/* Place this instance on the device list */
-@@ -1361,8 +1371,10 @@ no_irq:
+@@ -1391,8 +1401,10 @@ no_irq:
  	list_add_tail(&idev->list, &intel_device_list);
  	mutex_unlock(&intel_device_list_lock);
  
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
