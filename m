Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] compat: move config_enabled to compat-3.4.h
Date: Wed, 28 Nov 2012 23:57:40 +0100
Message-Id: <1354143460-28164-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354143460-28164-1-git-send-email-hauke@hauke-m.de>
References: <1354143460-28164-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

config_enabled() was introduced in kernel version 3.4 and not in
version 3.1. Now some driver uses this directly and this fails without
this patch.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.1.h |   15 +--------------
 include/linux/compat-3.4.h |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/compat-3.1.h b/include/linux/compat-3.1.h
index fc05245..71bc00f 100644
--- a/include/linux/compat-3.1.h
+++ b/include/linux/compat-3.1.h
@@ -42,19 +42,6 @@ static inline struct sk_buff *__netdev_alloc_skb_ip_align(struct net_device *dev
 	return skb;
 }
 
-/*
- * Getting something that works in C and CPP for an arg that may or may
- * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
- * we match on the placeholder define, insert the "0," for arg1 and generate
- * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a one).
- * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
- * the last step cherry picks the 2nd arg, we get a zero.
- */
-#define __ARG_PLACEHOLDER_1 0,
-#define config_enabled(cfg) _config_enabled(cfg)
-#define _config_enabled(value) __config_enabled(__ARG_PLACEHOLDER_##value)
-#define __config_enabled(arg1_or_junk) ___config_enabled(arg1_or_junk 1, 0)
-#define ___config_enabled(__ignored, val, ...) val
 #define genl_dump_check_consistent(cb, user_hdr, family)
 
 /*
@@ -63,7 +50,7 @@ static inline struct sk_buff *__netdev_alloc_skb_ip_align(struct net_device *dev
  *
  */
 #define IS_ENABLED(option) \
-        (config_enabled(option) || config_enabled(option##_MODULE))
+	(config_enabled(option) || config_enabled(option##_MODULE))
 
 #define IFF_TX_SKB_SHARING	0x10000	/* The interface supports sharing
 					 * skbs on transmit */
diff --git a/include/linux/compat-3.4.h b/include/linux/compat-3.4.h
index 887293d..fbd92a2 100644
--- a/include/linux/compat-3.4.h
+++ b/include/linux/compat-3.4.h
@@ -123,6 +123,20 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 	module_driver(__pci_driver, pci_register_driver, \
 		       pci_unregister_driver)
 
+/*
+ * Getting something that works in C and CPP for an arg that may or may
+ * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
+ * we match on the placeholder define, insert the "0," for arg1 and generate
+ * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a one).
+ * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
+ * the last step cherry picks the 2nd arg, we get a zero.
+ */
+#define __ARG_PLACEHOLDER_1 0,
+#define config_enabled(cfg) _config_enabled(cfg)
+#define _config_enabled(value) __config_enabled(__ARG_PLACEHOLDER_##value)
+#define __config_enabled(arg1_or_junk) ___config_enabled(arg1_or_junk 1, 0)
+#define ___config_enabled(__ignored, val, ...) val
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) */
 
 #endif /* LINUX_5_4_COMPAT_H */
-- 
1.7.10.4
