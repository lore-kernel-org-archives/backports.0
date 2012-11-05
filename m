Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] compat: add USB_SUBCLASS_VENDOR_SPEC
Date: Tue,  6 Nov 2012 00:12:28 +0100
Message-Id: <1352157148-13519-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-2.6.31.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compat-2.6.31.h b/include/linux/compat-2.6.31.h
index 347ae26..6e513ef 100644
--- a/include/linux/compat-2.6.31.h
+++ b/include/linux/compat-2.6.31.h
@@ -249,6 +249,7 @@ static inline bool sk_has_allocations(const struct sock *sk)
 	return sk_wmem_alloc_get(sk) || sk_rmem_alloc_get(sk);
 }
 
+#define USB_SUBCLASS_VENDOR_SPEC	0xff
 
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)) */
 
-- 
1.7.10.4
