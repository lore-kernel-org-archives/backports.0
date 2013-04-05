Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26339 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161045Ab3DECEt (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 4 Apr 2013 22:04:49 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r3524nle011031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <backports@vger.kernel.org>; Thu, 4 Apr 2013 22:04:49 -0400
Received: from localhost.localdomain.com (vpn-55-210.rdu2.redhat.com [10.10.55.210])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r3524mcQ013017
	for <backports@vger.kernel.org>; Thu, 4 Apr 2013 22:04:48 -0400
From: Andy Gospodarek <andy@greyhouse.net>
To: backports@vger.kernel.org
Subject: [PATCH 2/2] more symbol fixup needed for latest RHEL6.3 kernels
Date: Thu,  4 Apr 2013 22:04:47 -0400
Message-Id: <1365127487-30058-2-git-send-email-andy@greyhouse.net> (sfid-20130405_040454_049649_AF48F750)
In-Reply-To: <1365127487-30058-1-git-send-email-andy@greyhouse.net>
References: <1365127487-30058-1-git-send-email-andy@greyhouse.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These changes will allow compat.ko to load properly on the latest released
RHEL6.3 errata kernels.

Reported here: https://bugzilla.kernel.org/show_bug.cgi?id=55971

Signed-off-by: Andy Gospodarek <andy@greyhouse.net>
---
 include/linux/compat-2.6.34.h |  2 ++
 include/linux/compat-2.6.35.h |  3 +++
 include/linux/compat-2.6.39.h |  2 ++
 include/linux/compat-3.0.h    |  3 ++-
 include/linux/compat-3.3.h    | 18 ++++++++++++++++++
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/compat-2.6.34.h b/include/linux/compat-2.6.34.h
index 09d5922..d444853 100644
--- a/include/linux/compat-2.6.34.h
+++ b/include/linux/compat-2.6.34.h
@@ -290,7 +290,9 @@ static inline int usb_enable_autosuspend(struct usb_device *udev)
 static inline int usb_disable_autosuspend(struct usb_device *udev)
 { return 0; }
 
+#if !defined(rcu_dereference_protected)
 #define rcu_dereference_protected(p, c) (p)
+#endif
 #define rcu_access_pointer(p)   ACCESS_ONCE(p)
 
 #define rcu_dereference_raw(p)	rcu_dereference(p)
diff --git a/include/linux/compat-2.6.35.h b/include/linux/compat-2.6.35.h
index 99968bf..cb43472 100644
--- a/include/linux/compat-2.6.35.h
+++ b/include/linux/compat-2.6.35.h
@@ -25,6 +25,9 @@
 #define netdev_hw_addr dev_mc_list
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
+
+#define qdisc_reset_all_tx_gt LINUX_BACKPORT(qdisc_reset_all_tx_gt)
+
 /* Reset all TX qdiscs greater then index of a device.  */
 static inline void qdisc_reset_all_tx_gt(struct net_device *dev, unsigned int i)
 {
diff --git a/include/linux/compat-2.6.39.h b/include/linux/compat-2.6.39.h
index e9a2eba..863afa4 100644
--- a/include/linux/compat-2.6.39.h
+++ b/include/linux/compat-2.6.39.h
@@ -18,7 +18,9 @@ static inline int __must_check PTR_RET(const void *ptr)
 		return 0;
 }
 
+#if !defined(NETIF_F_RXCSUM)
 #define NETIF_F_RXCSUM 0
+#endif
 
 #define tiocmget(tty) tiocmget(tty, NULL)
 #define tiocmset(tty, set, clear) tiocmset(tty, NULL, set, clear)
diff --git a/include/linux/compat-3.0.h b/include/linux/compat-3.0.h
index 7fcd763..0bf179d 100644
--- a/include/linux/compat-3.0.h
+++ b/include/linux/compat-3.0.h
@@ -119,6 +119,7 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
  * The rcu callback could happen every time also after the module was
  *  unloaded and this will cause problems.
  */
+#if !defined(kfree_rcu)
 #define kfree_rcu(data, rcuhead)		do {			\
 		void __kfree_rcu_fn(struct rcu_head *rcu_head)		\
 		{							\
@@ -128,7 +129,7 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
 		}							\
 		call_rcu(&(data)->rcuhead, __kfree_rcu_fn);		\
 	} while (0)
-
+#endif
 #ifdef MODULE
 
 /*
diff --git a/include/linux/compat-3.3.h b/include/linux/compat-3.3.h
index ee4b7ce..2af4a52 100644
--- a/include/linux/compat-3.3.h
+++ b/include/linux/compat-3.3.h
@@ -56,6 +56,9 @@ static inline void netdev_reset_queue(struct net_device *dev_queue)
 }
 #endif /* CONFIG_BQL */
 
+
+#define ethtool_adv_to_mii_adv_t LINUX_BACKPORT(ethtool_adv_to_mii_adv_t)
+
 /**
  * ethtool_adv_to_mii_adv_t
  * @ethadv: the ethtool advertisement settings
@@ -84,6 +87,8 @@ static inline u32 ethtool_adv_to_mii_adv_t(u32 ethadv)
 	return result;
 }
 
+#define mii_adv_to_ethtool_adv_t LINUX_BACKPORT(mii_adv_to_ethtool_adv_t)
+
 /**
  * mii_adv_to_ethtool_adv_t
  * @adv: value of the MII_ADVERTISE register
@@ -111,6 +116,8 @@ static inline u32 mii_adv_to_ethtool_adv_t(u32 adv)
 	return result;
 }
 
+#define ethtool_adv_to_mii_ctrl1000_t LINUX_BACKPORT(ethtool_adv_to_mii_ctrl1000_t)
+
 /**
  * ethtool_adv_to_mii_ctrl1000_t
  * @ethadv: the ethtool advertisement settings
@@ -131,6 +138,8 @@ static inline u32 ethtool_adv_to_mii_ctrl1000_t(u32 ethadv)
 	return result;
 }
 
+#define mii_ctrl1000_to_ethtool_adv_t LINUX_BACKPORT(mii_ctrl1000_to_ethtool_adv_t)
+
 /**
  * mii_ctrl1000_to_ethtool_adv_t
  * @adv: value of the MII_CTRL1000 register
@@ -151,6 +160,8 @@ static inline u32 mii_ctrl1000_to_ethtool_adv_t(u32 adv)
 	return result;
 }
 
+#define mii_lpa_to_ethtool_lpa_t LINUX_BACKPORT(mii_lpa_to_ethtool_lpa_t)
+
 /**
  * mii_lpa_to_ethtool_lpa_t
  * @adv: value of the MII_LPA register
@@ -169,6 +180,8 @@ static inline u32 mii_lpa_to_ethtool_lpa_t(u32 lpa)
 	return result | mii_adv_to_ethtool_adv_t(lpa);
 }
 
+#define mii_stat1000_to_ethtool_lpa_t LINUX_BACKPORT(mii_stat1000_to_ethtool_lpa_t)
+
 /**
  * mii_stat1000_to_ethtool_lpa_t
  * @adv: value of the MII_STAT1000 register
@@ -189,6 +202,7 @@ static inline u32 mii_stat1000_to_ethtool_lpa_t(u32 lpa)
 	return result;
 }
 
+#define ethtool_adv_to_mii_adv_x LINUX_BACKPORT(ethtool_adv_to_mii_adv_x)
 /**
  * ethtool_adv_to_mii_adv_x
  * @ethadv: the ethtool advertisement settings
@@ -213,6 +227,8 @@ static inline u32 ethtool_adv_to_mii_adv_x(u32 ethadv)
 	return result;
 }
 
+#define mii_adv_to_ethtool_adv_x LINUX_BACKPORT(mii_adv_to_ethtool_adv_x)
+
 /**
  * mii_adv_to_ethtool_adv_x
  * @adv: value of the MII_CTRL1000 register
@@ -237,6 +253,8 @@ static inline u32 mii_adv_to_ethtool_adv_x(u32 adv)
 	return result;
 }
 
+#define mii_lpa_to_ethtool_lpa_x LINUX_BACKPORT(mii_lpa_to_ethtool_lpa_x)
+
 /**
  * mii_lpa_to_ethtool_lpa_x
  * @adv: value of the MII_LPA register
-- 
1.8.1.4

