Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/6] compat-drivers: do not use struct spinlock
Date: Thu, 29 Nov 2012 00:07:49 +0100
Message-Id: <1354144069-28611-7-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
References: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

struct spinlock does not exists on kernel version <= 2.6.32, use
spinlock_t instead.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/network/67-use_spinlock_t.patch |   11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 patches/network/67-use_spinlock_t.patch

diff --git a/patches/network/67-use_spinlock_t.patch b/patches/network/67-use_spinlock_t.patch
new file mode 100644
index 0000000..4c9f315
--- /dev/null
+++ b/patches/network/67-use_spinlock_t.patch
@@ -0,0 +1,11 @@
+--- a/drivers/net/wireless/brcm80211/brcmfmac/fweh.h
++++ b/drivers/net/wireless/brcm80211/brcmfmac/fweh.h
+@@ -158,7 +158,7 @@ typedef int (*brcmf_fweh_handler_t)(stru
+  */
+ struct brcmf_fweh_info {
+ 	struct work_struct event_work;
+-	struct spinlock evt_q_lock;
++	spinlock_t evt_q_lock;
+ 	struct list_head event_q;
+ 	int (*evt_handler[BRCMF_E_LAST])(struct brcmf_if *ifp,
+ 					 const struct brcmf_event_msg *evtmsg,
-- 
1.7.10.4
