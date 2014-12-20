Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35259 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbaLTVjw (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 20 Dec 2014 16:39:52 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/14] patches: adapt api change of rchan_callbacks->create_buf_file in ath9k
Date: Sat, 20 Dec 2014 22:39:35 +0100
Message-Id: <1419111577-22174-13-git-send-email-hauke@hauke-m.de> (sfid-20141220_224346_887401_13F59143)
In-Reply-To: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
References: <1419111577-22174-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0021-umode_t-api-change/ath9k.patch            | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0021-umode_t-api-change/ath9k.patch

diff --git a/patches/collateral-evolutions/network/0021-umode_t-api-change/ath9k.patch b/patches/collateral-evolutions/network/0021-umode_t-api-change/ath9k.patch
new file mode 100644
index 0000000..5275415
--- /dev/null
+++ b/patches/collateral-evolutions/network/0021-umode_t-api-change/ath9k.patch
@@ -0,0 +1,14 @@
+--- a/drivers/net/wireless/ath/ath9k/common-spectral.c
++++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
+@@ -552,7 +552,11 @@ static const struct file_operations fops
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

