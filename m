Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41035 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbbFNO3j (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:39 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 19/21] patches: deactivate struct tracing in mt7601u
Date: Sun, 14 Jun 2015 16:29:20 +0200
Message-Id: <1434292162-2261-20-git-send-email-hauke@hauke-m.de> (sfid-20150614_163350_936114_3527ABB2)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The mt7601u driver makes use of __field_struct which was added in Linux
commit 4d4c9cc83. It is hard to backport this feature, so just remove
the code using it on kernel version < 3.16.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0060-trace_field_struct/INFO           | 11 ++++++++
 .../network/0060-trace_field_struct/mt7601u.patch  | 33 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0060-trace_field_struct/INFO
 create mode 100644 patches/collateral-evolutions/network/0060-trace_field_struct/mt7601u.patch

diff --git a/patches/collateral-evolutions/network/0060-trace_field_struct/INFO b/patches/collateral-evolutions/network/0060-trace_field_struct/INFO
new file mode 100644
index 0000000..bb2d355
--- /dev/null
+++ b/patches/collateral-evolutions/network/0060-trace_field_struct/INFO
@@ -0,0 +1,11 @@
+deactivate struct tracing
+
+__field_struct was added in Linux commit 4d4c9cc83. It is hard to backport
+this feature, so just remove the code using it on kernel version < 3.16.
+
+commit 4d4c9cc839a308be3289a361ccba4447ee140552
+Author: Steven Rostedt <rostedt@goodmis.org>
+Date:   Tue Jun 17 08:59:16 2014 -0400
+
+    tracing: Add __field_struct macro for TRACE_EVENT()
+
diff --git a/patches/collateral-evolutions/network/0060-trace_field_struct/mt7601u.patch b/patches/collateral-evolutions/network/0060-trace_field_struct/mt7601u.patch
new file mode 100644
index 0000000..4e29b2c
--- /dev/null
+++ b/patches/collateral-evolutions/network/0060-trace_field_struct/mt7601u.patch
@@ -0,0 +1,33 @@
+diff --git a/drivers/net/wireless/mediatek/mt7601u/trace.h b/drivers/net/wireless/mediatek/mt7601u/trace.h
+index 2898973..7fa1b96 100644
+--- a/drivers/net/wireless/mediatek/mt7601u/trace.h
++++ b/drivers/net/wireless/mediatek/mt7601u/trace.h
+@@ -252,6 +252,7 @@ TRACE_EVENT(freq_cal_offset,
+ 		  DEV_PR_ARG, __entry->phy_mode, __entry->freq_off)
+ );
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
+ TRACE_EVENT(mt_rx,
+ 	TP_PROTO(struct mt7601u_dev *dev, struct mt7601u_rxwi *rxwi, u32 f),
+ 	TP_ARGS(dev, rxwi, f),
+@@ -306,6 +307,20 @@ TRACE_EVENT(mt_tx,
+ 		  __entry->h.ack_ctl, __entry->h.wcid,
+ 		  le16_to_cpu(__entry->h.len_ctl))
+ );
++#else
++#ifndef __BACKPORT_MT7601U_TRACE_H_EXTRA
++#define __BACKPORT_MT7601U_TRACE_H_EXTRA
++static inline void trace_mt_rx(struct mt7601u_dev *dev,
++			       struct mt7601u_rxwi *rxwi,
++			       u32 f)
++{
++}
++static inline void trace_mt_tx(struct mt7601u_dev *dev, struct sk_buff *skb,
++			       struct mt76_sta *sta, struct mt76_txwi *h)
++{
++}
++#endif /* __BACKPORT_MT7601U_TRACE_H_EXTRA */
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0) */
+ 
+ TRACE_EVENT(mt_tx_dma_done,
+ 	TP_PROTO(struct mt7601u_dev *dev, struct sk_buff *skb),
-- 
2.1.4

