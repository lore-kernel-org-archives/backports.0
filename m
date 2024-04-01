Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1491C2E
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009042; cv=none; b=C/EUI9rEkGE77gKGGqmltrKCePyN6yqhgKy5tIhuCorFOrjE0gaGyJCEHdmu62Ovux3obWu26kCo8Y1L3i4EgCJ+8h0OAYMq8a8aVJo0imZ/adtkD1qJz5a2/hYx0lVUG4+XCVWMoAXLZLxh9y2gqpJfKnRulFZiBOvVRY6B+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009042; c=relaxed/simple;
	bh=rmXpgahvzb+MuPp5Hi0+TCwF4YATsGXEVyvuzFIBVn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1RbnMy5MDso0dlqzjsr59JSk/q27uDOE6na+SHS1QpY0i6HLZw6utmyv6UrfyR4tWbEMOnxDRJBZCN8npkKWguIYPLos7Ic4l3J8gP6CoNnDpjTc7IKEur5LlBB6xr/m5TqnGM3GBGB0e6CQosCSzpZKOUDgcbTw7EiP+4TtLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=dkjK/hkX; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="dkjK/hkX"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V7lQZ29j9z9ssr;
	Tue,  2 Apr 2024 00:03:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712009030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nk29CXd8rXP03AdFLSwfJ/htBD7E00AFaDu8jwA25w=;
	b=dkjK/hkXfD+nEpKhA/rVzC72KDbpmq7jqv7tfzCL8K6ipBixWwJ/gumFn24p1kbb4a+wEq
	gFaYVB9EVPV35Kpnb197lkDt/x1kZ5o5JKTyjNUHS92omgCpg1MF0nnNkmPnM/ylIHQQtN
	lgCGg4G197hLPYY7AImoZDhZPgbEr5EyRo8VluF05Un80iW3UZPUCCbOjbvhpAVdlWnv6d
	uBE68zGtg3jiDVEDiFH8etJ1QU+9YzF7uh1bQze0vM7yHICxUMx3V/WpyyqJ6kIxlVtZaS
	7kwj8cNZb/39cXzGEZx0dqDFEPkfKdWyCruSnmWtqDhg3b9vf/NX5Tl2LWDmVw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/10] backports: Remove support for kernel smaller than 4.14
Date: Tue,  2 Apr 2024 00:03:14 +0200
Message-ID: <20240401220314.2434455-11-hauke@hauke-m.de>
In-Reply-To: <20240401220314.2434455-1-hauke@hauke-m.de>
References: <20240401220314.2434455-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removes all the code which is needed to support kernel 4.13.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .github/workflows/create.yml                  |  1 -
 README                                        |  2 +-
 backport/backport-include/linux/netlink.h     | 27 ---------
 backport/backport-include/linux/rbtree.h      | 59 -------------------
 patches/0013-fix-makefile-includes/mt76.patch | 22 -------
 .../0013-fix-makefile-includes/wilc1000.patch | 24 +-------
 patches/0095-spi-delay/wilc1000.patch         |  6 +-
 7 files changed, 5 insertions(+), 136 deletions(-)
 delete mode 100644 backport/backport-include/linux/rbtree.h

diff --git a/.github/workflows/create.yml b/.github/workflows/create.yml
index 7850b8f0..36e6c930 100644
--- a/.github/workflows/create.yml
+++ b/.github/workflows/create.yml
@@ -55,7 +55,6 @@ jobs:
     strategy:
       matrix:
         kernel: [
-           "4.13",
            "4.14",
            "4.15",
            "4.16",
diff --git a/README b/README
index 2eb53ab1..505300a8 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.13 and above.
+for kernels 4.14 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/linux/netlink.h b/backport/backport-include/linux/netlink.h
index b7afaf9d..1c15d201 100644
--- a/backport/backport-include/linux/netlink.h
+++ b/backport/backport-include/linux/netlink.h
@@ -3,33 +3,6 @@
 #include_next <linux/netlink.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(4,14,0)
-struct nla_bitfield32 {
-	__u32 value;
-	__u32 selector;
-};
-#endif
-
-#ifndef NL_SET_ERR_MSG_ATTR
-#define NL_SET_ERR_MSG_ATTR(extack, attr, msg) do {	\
-	static const char __msg[] = msg;		\
-	struct netlink_ext_ack *__extack = (extack);	\
-							\
-	if (__extack) {					\
-		__extack->_msg = __msg;			\
-		__extack->bad_attr = (attr);		\
-	}						\
-} while (0)
-#endif
-
-
-#ifndef NL_SET_BAD_ATTR
-#define NL_SET_BAD_ATTR(extack, attr) do {		\
-	if ((extack))					\
-		(extack)->bad_attr = (attr);		\
-} while (0)
-#endif /* NL_SET_BAD_ATTR */
-
 #if LINUX_VERSION_IS_LESS(5,0,0)
 static inline void nl_set_extack_cookie_u64(struct netlink_ext_ack *extack,
 					    u64 cookie)
diff --git a/backport/backport-include/linux/rbtree.h b/backport/backport-include/linux/rbtree.h
deleted file mode 100644
index a364f07b..00000000
--- a/backport/backport-include/linux/rbtree.h
+++ /dev/null
@@ -1,59 +0,0 @@
-#ifndef __BACKPORT_LINUX_RBTREE_H
-#define __BACKPORT_LINUX_RBTREE_H
-#include_next <linux/rbtree.h>
-
-#if LINUX_VERSION_IS_LESS(4,14,0)
-/*
- * Leftmost-cached rbtrees.
- *
- * We do not cache the rightmost node based on footprint
- * size vs number of potential users that could benefit
- * from O(1) rb_last(). Just not worth it, users that want
- * this feature can always implement the logic explicitly.
- * Furthermore, users that want to cache both pointers may
- * find it a bit asymmetric, but that's ok.
- */
-struct rb_root_cached {
-	struct rb_root rb_root;
-	struct rb_node *rb_leftmost;
-};
-
-#define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
-
-/* Same as rb_first(), but O(1) */
-#define rb_first_cached(root) (root)->rb_leftmost
-
-static inline void rb_insert_color_cached(struct rb_node *node,
-					  struct rb_root_cached *root,
-					  bool leftmost)
-{
-	if (leftmost)
-		root->rb_leftmost = node;
-	rb_insert_color(node, &root->rb_root);
-}
-
-
-static inline struct rb_node *
-rb_erase_cached(struct rb_node *node, struct rb_root_cached *root)
-{
-	struct rb_node *leftmost = NULL;
-
-	if (root->rb_leftmost == node)
-		leftmost = root->rb_leftmost = rb_next(node);
-
-	rb_erase(node, &root->rb_root);
-
-	return leftmost;
-}
-
-static inline void rb_replace_node_cached(struct rb_node *victim,
-					  struct rb_node *new,
-					  struct rb_root_cached *root)
-{
-	if (root->rb_leftmost == victim)
-		root->rb_leftmost = new;
-	rb_replace_node(victim, new, &root->rb_root);
-}
-#endif
-
-#endif /* __BACKPORT_LINUX_RBTREE_H */
diff --git a/patches/0013-fix-makefile-includes/mt76.patch b/patches/0013-fix-makefile-includes/mt76.patch
index 7c5f0d45..46fe75c5 100644
--- a/patches/0013-fix-makefile-includes/mt76.patch
+++ b/patches/0013-fix-makefile-includes/mt76.patch
@@ -1,27 +1,5 @@
-additional include needed for kernel 4.2, 4.11, 4.12 and 4.13
-
 linux/kthread.h include needed against kernel 4.19.
 
---- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
-+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
-@@ -6,6 +6,7 @@
-  */
- 
- #include <linux/firmware.h>
-+#include <linux/module.h>
- #include "mt7615.h"
- #include "mcu.h"
- #include "mac.h"
---- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
-+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
-@@ -2,6 +2,7 @@
- /* Copyright (C) 2020 MediaTek Inc. */
- 
- #include "mt76_connac_mcu.h"
-+#include <linux/module.h>
- 
- int mt76_connac_mcu_start_firmware(struct mt76_dev *dev, u32 addr, u32 option)
- {
 --- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
 +++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
 @@ -9,6 +9,7 @@
diff --git a/patches/0013-fix-makefile-includes/wilc1000.patch b/patches/0013-fix-makefile-includes/wilc1000.patch
index 6304b3d7..73e02955 100644
--- a/patches/0013-fix-makefile-includes/wilc1000.patch
+++ b/patches/0013-fix-makefile-includes/wilc1000.patch
@@ -1,34 +1,12 @@
 linux/interrupt.h include needed for kernel 4.14
-linux/module.h include needed for kernel 3.18
 
 --- a/drivers/net/wireless/microchip/wilc1000/netdev.c
 +++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
-@@ -9,6 +9,8 @@
+@@ -9,6 +9,7 @@
  #include <linux/firmware.h>
  #include <linux/netdevice.h>
  #include <linux/inetdevice.h>
 +#include <linux/interrupt.h>
-+#include <linux/module.h>
  
  #include "cfg80211.h"
  #include "wlan_cfg.h"
---- a/drivers/net/wireless/microchip/wilc1000/sdio.c
-+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
-@@ -10,6 +10,7 @@
- #include <linux/mmc/host.h>
- #include <linux/mmc/sdio.h>
- #include <linux/of_irq.h>
-+#include <linux/module.h>
- 
- #include "netdev.h"
- #include "cfg80211.h"
---- a/drivers/net/wireless/microchip/wilc1000/spi.c
-+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
-@@ -8,6 +8,7 @@
- #include <linux/spi/spi.h>
- #include <linux/crc7.h>
- #include <linux/crc-itu-t.h>
-+#include <linux/module.h>
- 
- #include "netdev.h"
- #include "cfg80211.h"
diff --git a/patches/0095-spi-delay/wilc1000.patch b/patches/0095-spi-delay/wilc1000.patch
index 71111710..1d3e6d6a 100644
--- a/patches/0095-spi-delay/wilc1000.patch
+++ b/patches/0095-spi-delay/wilc1000.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/microchip/wilc1000/spi.c
 +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
-@@ -219,10 +219,14 @@ static int wilc_spi_tx(struct wilc *wilc
+@@ -218,10 +218,14 @@ static int wilc_spi_tx(struct wilc *wilc
  		struct spi_transfer tr = {
  			.tx_buf = b,
  			.len = len,
@@ -15,7 +15,7 @@
  		};
  		char *r_buffer = kzalloc(len, GFP_KERNEL);
  
-@@ -263,10 +267,14 @@ static int wilc_spi_rx(struct wilc *wilc
+@@ -262,10 +266,14 @@ static int wilc_spi_rx(struct wilc *wilc
  		struct spi_transfer tr = {
  			.rx_buf = rb,
  			.len = rlen,
@@ -30,7 +30,7 @@
  
  		};
  		char *t_buffer = kzalloc(rlen, GFP_KERNEL);
-@@ -308,10 +316,14 @@ static int wilc_spi_tx_rx(struct wilc *w
+@@ -307,10 +315,14 @@ static int wilc_spi_tx_rx(struct wilc *w
  			.tx_buf = wb,
  			.len = rlen,
  			.bits_per_word = 8,
-- 
2.44.0

