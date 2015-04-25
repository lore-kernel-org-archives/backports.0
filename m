Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49622 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbbDYNvT (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 09:51:19 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/9] patches: do not add backports code for recent kernel versions
Date: Sat, 25 Apr 2015 15:50:56 +0200
Message-Id: <1429969864-16831-2-git-send-email-hauke@hauke-m.de> (sfid-20150425_155123_885336_2D35C247)
In-Reply-To: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
References: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This caused a warning on recent kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/collateral-evolutions/network/0031-sk_data_ready.cocci | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/patches/collateral-evolutions/network/0031-sk_data_ready.cocci b/patches/collateral-evolutions/network/0031-sk_data_ready.cocci
index 3dc218c..2716edd 100644
--- a/patches/collateral-evolutions/network/0031-sk_data_ready.cocci
+++ b/patches/collateral-evolutions/network/0031-sk_data_ready.cocci
@@ -68,10 +68,12 @@ drv_data_ready(struct sock *sk)
 	...
 }
 
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
 +static void backport_drv_data_ready(struct sock *sk, int unused)
 +{
 +	drv_data_ready(sk);
 +}
++#endif
 
 @ sk_data_ready_assigned_mod_e depends on sk_data_ready_assigned @
 expression E;
-- 
1.9.1

