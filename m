Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:50102 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbbDZVEe (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 26 Apr 2015 17:04:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/7] patches: do not use EPROBE_DEFER in media
Date: Sun, 26 Apr 2015 23:04:23 +0200
Message-Id: <1430082264-11808-7-git-send-email-hauke@hauke-m.de> (sfid-20150426_230438_832652_13AD613C)
In-Reply-To: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
References: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added in commit 4f528afc.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0006-no-eprobe_defer/v4l2-clk.patch               | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch

diff --git a/patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch b/patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch
new file mode 100644
index 0000000..592f5e1
--- /dev/null
+++ b/patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch
@@ -0,0 +1,13 @@
+--- a/drivers/media/v4l2-core/v4l2-clk.c
++++ b/drivers/media/v4l2-core/v4l2-clk.c
+@@ -40,8 +40,10 @@ struct v4l2_clk *v4l2_clk_get(struct dev
+ 	struct v4l2_clk *clk;
+ 	struct clk *ccf_clk = clk_get(dev, id);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)
+ 	if (PTR_ERR(ccf_clk) == -EPROBE_DEFER)
+ 		return ERR_PTR(-EPROBE_DEFER);
++#endif
+ 
+ 	if (!IS_ERR_OR_NULL(ccf_clk)) {
+ 		clk = kzalloc(sizeof(*clk), GFP_KERNEL);
-- 
1.9.1

