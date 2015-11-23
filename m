Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41650 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230AbbKWXLP (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:15 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/14] patches: refresh on next-20151120
Date: Tue, 24 Nov 2015 00:11:04 +0100
Message-Id: <1448320264-15070-15-git-send-email-hauke@hauke-m.de> (sfid-20151124_002252_052342_AEBE0B87)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.72              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.110             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.92             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.49             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.56             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.23             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.9               [  OK  ]
22  4.1.12              [  OK  ]
23  4.2.5               [  OK  ]
24  4.3-rc7             [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/collateral-evolutions/media/0004-missing-include/hackrf.patch | 4 ++--
 .../collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch b/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
index c55ba88..dfc5a36 100644
--- a/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
+++ b/patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
@@ -6,5 +6,5 @@
  #include <media/videobuf2-vmalloc.h>
 +#include <linux/mm.h>
  
- /* HackRF USB API commands (from HackRF Library) */
- enum {
+ /*
+  * Used Avago MGA-81563 RF amplifier could be destroyed pretty easily with too
diff --git a/patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch b/patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch
index 592f5e1..8498457 100644
--- a/patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch
+++ b/patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch
@@ -1,8 +1,8 @@
 --- a/drivers/media/v4l2-core/v4l2-clk.c
 +++ b/drivers/media/v4l2-core/v4l2-clk.c
-@@ -40,8 +40,10 @@ struct v4l2_clk *v4l2_clk_get(struct dev
- 	struct v4l2_clk *clk;
+@@ -42,8 +42,10 @@ struct v4l2_clk *v4l2_clk_get(struct dev
  	struct clk *ccf_clk = clk_get(dev, id);
+ 	char clk_name[V4L2_CLK_NAME_SIZE];
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)
  	if (PTR_ERR(ccf_clk) == -EPROBE_DEFER)
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
