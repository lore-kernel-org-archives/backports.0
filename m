Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] compat: add ETHTOOL_FWVERS_LEN
Date: Wed,  9 Jan 2013 17:34:22 +0100
Message-Id: <1357749263-4596-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1357749263-4596-1-git-send-email-hauke@hauke-m.de>
References: <1357749263-4596-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

In older kernel version this was hard coded to 32

This was added in this commit:
commit 141518c95870228da4e050fbe31a8f0c9df82c72
Author: Matt Carlson <mcarlson@broadcom.com>
Date:   Thu Dec 3 08:36:22 2009 +0000

    tg3: Add some VPD preprocessor constants

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.3.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/compat-3.3.h b/include/linux/compat-3.3.h
index 5d07c1a..84988bb 100644
--- a/include/linux/compat-3.3.h
+++ b/include/linux/compat-3.3.h
@@ -267,6 +267,8 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
 	return index % n_rx_rings;
 }
 
+#define ETHTOOL_FWVERS_LEN	32
+
 #if !((LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,9) && LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)) || (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,23) && LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)))
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,37))
 /* mask qdisc_cb_private_validate as RHEL6 backports this */
-- 
1.7.10.4
