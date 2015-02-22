Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58769 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbbBVBmU (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 21 Feb 2015 20:42:20 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	Stefan Assmann <sassmann@kpanic.de>
Subject: [PATCH 3/6] patches: igb: remove access to programmable ptp pins
Date: Sun, 22 Feb 2015 02:42:05 +0100
Message-Id: <1424569328-12514-4-git-send-email-hauke@hauke-m.de> (sfid-20150222_024225_428182_FD12A5D1)
In-Reply-To: <1424569328-12514-1-git-send-email-hauke@hauke-m.de>
References: <1424569328-12514-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Programmable pins were introduced in the ptp subsystem in kernel 3.15
and igb makes use of them now. These patches are removing the code
accessing these new functions.

These patches are needed for every kernel which does not have this
commit:
commit 6092315dfdec5185881605d15a0e200d6e90eb66
Author: Richard Cochran <richardcochran@gmail.com>
Date:   Thu Mar 20 22:21:52 2014 +0100

    ptp: introduce programmable pins.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
CC: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0052-deactivate-ptp-pin/INFO           |  20 +++
 .../network/0052-deactivate-ptp-pin/igb.patch      | 136 +++++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0052-deactivate-ptp-pin/INFO
 create mode 100644 patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch

diff --git a/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/INFO b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/INFO
new file mode 100644
index 0000000..821794f
--- /dev/null
+++ b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/INFO
@@ -0,0 +1,20 @@
+Programmable pins were introduced in the ptp subsystem in kernel 3.15 
+and igb makes use of them now. These patches are removing the code 
+accessing these new functions.
+
+These patches are needed for every kernel which does not have this 
+commit:
+commit 6092315dfdec5185881605d15a0e200d6e90eb66
+Author: Richard Cochran <richardcochran@gmail.com>
+Date:   Thu Mar 20 22:21:52 2014 +0100
+
+    ptp: introduce programmable pins.
+    
+    This patch adds a pair of new ioctls to the PTP Hardware Clock device
+    interface. Using the ioctls, user space programs can query each pin to
+    find out its current function and also reprogram a different function
+    if desired.
+    
+    Signed-off-by: Richard Cochran <richardcochran@gmail.com>
+    Signed-off-by: David S. Miller <davem@davemloft.net>
+
diff --git a/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
new file mode 100644
index 0000000..de64be8
--- /dev/null
+++ b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
@@ -0,0 +1,136 @@
+--- a/drivers/net/ethernet/intel/igb/igb.h
++++ b/drivers/net/ethernet/intel/igb/igb.h
+@@ -442,7 +442,9 @@ struct igb_adapter {
+ 	u32 tx_hwtstamp_timeouts;
+ 	u32 rx_hwtstamp_cleared;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ 	struct ptp_pin_desc sdp_config[IGB_N_SDP];
++#endif
+ 	struct {
+ 		struct timespec start;
+ 		struct timespec period;
+--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
++++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
+@@ -115,6 +115,7 @@ static cycle_t igb_ptp_read_82580(const
+ 	return val;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ /* SYSTIM read access for I210/I211 */
+ static void igb_ptp_read_i210(struct igb_adapter *adapter, struct timespec *ts)
+ {
+@@ -132,6 +133,7 @@ static void igb_ptp_read_i210(struct igb
+ 	ts->tv_sec = sec;
+ 	ts->tv_nsec = nsec;
+ }
++#endif
+ 
+ static void igb_ptp_write_i210(struct igb_adapter *adapter,
+ 			       const struct timespec *ts)
+@@ -264,6 +266,7 @@ static int igb_ptp_adjtime_82576(struct
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ static int igb_ptp_adjtime_i210(struct ptp_clock_info *ptp, s64 delta)
+ {
+ 	struct igb_adapter *igb = container_of(ptp, struct igb_adapter,
+@@ -281,6 +284,7 @@ static int igb_ptp_adjtime_i210(struct p
+ 
+ 	return 0;
+ }
++#endif
+ 
+ static int igb_ptp_gettime_82576(struct ptp_clock_info *ptp,
+ 				 struct timespec *ts)
+@@ -303,6 +307,7 @@ static int igb_ptp_gettime_82576(struct
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ static int igb_ptp_gettime_i210(struct ptp_clock_info *ptp,
+ 				struct timespec *ts)
+ {
+@@ -318,6 +323,7 @@ static int igb_ptp_gettime_i210(struct p
+ 
+ 	return 0;
+ }
++#endif
+ 
+ static int igb_ptp_settime_82576(struct ptp_clock_info *ptp,
+ 				 const struct timespec *ts)
+@@ -339,6 +345,7 @@ static int igb_ptp_settime_82576(struct
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ static int igb_ptp_settime_i210(struct ptp_clock_info *ptp,
+ 				const struct timespec *ts)
+ {
+@@ -567,6 +574,7 @@ static int igb_ptp_feature_enable_i210(s
+ 
+ 	return -EOPNOTSUPP;
+ }
++#endif
+ 
+ static int igb_ptp_feature_enable(struct ptp_clock_info *ptp,
+ 				  struct ptp_clock_request *rq, int on)
+@@ -574,6 +582,7 @@ static int igb_ptp_feature_enable(struct
+ 	return -EOPNOTSUPP;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ static int igb_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
+ 			      enum ptp_pin_function func, unsigned int chan)
+ {
+@@ -587,6 +596,7 @@ static int igb_ptp_verify_pin(struct ptp
+ 	}
+ 	return 0;
+ }
++#endif
+ 
+ /**
+  * igb_ptp_tx_work
+@@ -978,7 +988,9 @@ void igb_ptp_init(struct igb_adapter *ad
+ {
+ 	struct e1000_hw *hw = &adapter->hw;
+ 	struct net_device *netdev = adapter->netdev;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ 	int i;
++#endif
+ 
+ 	switch (hw->mac.type) {
+ 	case e1000_82576:
+@@ -1019,6 +1031,7 @@ void igb_ptp_init(struct igb_adapter *ad
+ 		/* Enable the timer functions by clearing bit 31. */
+ 		wr32(E1000_TSAUXC, 0x0);
+ 		break;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ 	case e1000_i210:
+ 	case e1000_i211:
+ 		for (i = 0; i < IGB_N_SDP; i++) {
+@@ -1045,6 +1058,7 @@ void igb_ptp_init(struct igb_adapter *ad
+ 		/* Enable the timer functions by clearing bit 31. */
+ 		wr32(E1000_TSAUXC, 0x0);
+ 		break;
++#endif
+ 	default:
+ 		adapter->ptp_clock = NULL;
+ 		return;
+@@ -1056,11 +1070,14 @@ void igb_ptp_init(struct igb_adapter *ad
+ 	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
+ 
+ 	/* Initialize the clock and overflow work for devices that need it. */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
+ 	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211)) {
+ 		struct timespec ts = ktime_to_timespec(ktime_get_real());
+ 
+ 		igb_ptp_settime_i210(&adapter->ptp_caps, &ts);
+-	} else {
++	} else
++#endif
++	{
+ 		timecounter_init(&adapter->tc, &adapter->cc,
+ 				 ktime_to_ns(ktime_get_real()));
+ 
-- 
1.9.1

