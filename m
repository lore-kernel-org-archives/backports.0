Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41659 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320AbbKWXLO (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:14 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/14] patches: remove call to is_platform_device member of struct soc_camera_device
Date: Tue, 24 Nov 2015 00:11:02 +0100
Message-Id: <1448320264-15070-13-git-send-email-hauke@hauke-m.de> (sfid-20151124_002251_931887_03D3DC4B)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

struct soc_camera_device got the is_platform_device member function in
kernel 3.19.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0008-no-is_platform_device/si4713.patch          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 patches/collateral-evolutions/media/0008-no-is_platform_device/si4713.patch

diff --git a/patches/collateral-evolutions/media/0008-no-is_platform_device/si4713.patch b/patches/collateral-evolutions/media/0008-no-is_platform_device/si4713.patch
new file mode 100644
index 0000000..811e47f
--- /dev/null
+++ b/patches/collateral-evolutions/media/0008-no-is_platform_device/si4713.patch
@@ -0,0 +1,14 @@
+--- a/drivers/media/radio/si4713/si4713.c
++++ b/drivers/media/radio/si4713/si4713.c
+@@ -1605,7 +1605,11 @@ static int si4713_probe(struct i2c_clien
+ 		goto free_ctrls;
+ 	}
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+ 	if (!np && (!pdata || !pdata->is_platform_device))
++#else
++	if (!np && !pdata)
++#endif
+ 		return 0;
+ 
+ 	si4713_pdev = platform_device_alloc("radio-si4713", -1);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
