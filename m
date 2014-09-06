Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48144 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbaIFXX6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 6 Sep 2014 19:23:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] backports: adapt api change of rchan_callbacks->create_buf_file in ath10k
Date: Sun,  7 Sep 2014 01:23:34 +0200
Message-Id: <1410045817-4112-2-git-send-email-hauke@hauke-m.de> (sfid-20140907_012406_434367_BCA9A38B)
In-Reply-To: <1410045817-4112-1-git-send-email-hauke@hauke-m.de>
References: <1410045817-4112-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0021-umode_t-api-change/ath10k.patch           | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch

diff --git a/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch b/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch
new file mode 100644
index 0000000..09b82ed
--- /dev/null
+++ b/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch
@@ -0,0 +1,14 @@
+--- a/drivers/net/wireless/ath/ath10k/spectral.c
++++ b/drivers/net/wireless/ath/ath10k/spectral.c
+@@ -482,7 +482,11 @@ static const struct file_operations fops
+ 
+ static struct dentry *create_buf_file_handler(const char *filename,
+ 					      struct dentry *parent,
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
+ 					      umode_t mode,
++#else
++					      int mode,
++#endif
+ 					      struct rchan_buf *buf,
+ 					      int *is_global)
+ {
-- 
1.9.1

