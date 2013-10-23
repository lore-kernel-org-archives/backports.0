Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:36164 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504Ab3JWVhV (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 17:37:21 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/8] backports: refresh patches on next-20130913
Date: Wed, 23 Oct 2013 23:36:50 +0200
Message-Id: <1382564210-15230-9-git-send-email-hauke@hauke-m.de> (sfid-20131023_233723_074132_CC44E599)
In-Reply-To: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
References: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

== ckmake-report.log ==

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.98              [  OK  ]
17  3.1.10              [  OK  ]
18  3.10.14             [  OK  ]
19  3.11.3              [  OK  ]
20  3.12-rc3            [  OK  ]
21  3.2.51              [  OK  ]
22  3.3.8               [  OK  ]
23  3.4.64              [  OK  ]
24  3.5.7               [  OK  ]
25  3.6.11              [  OK  ]
26  3.7.10              [  OK  ]
27  3.8.13              [  OK  ]
28  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/backport-adjustments/dma-buf.patch                       |    6 +++---
 .../drivers_net_wireless_rtl818x_rtl8187_dev.patch               |    2 +-
 .../network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch     |    2 +-
 .../drivers_net_wireless_rtl818x_rtl8187_dev.patch               |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/patches/backport-adjustments/dma-buf.patch b/patches/backport-adjustments/dma-buf.patch
index fec0cc3..88608c0 100644
--- a/patches/backport-adjustments/dma-buf.patch
+++ b/patches/backport-adjustments/dma-buf.patch
@@ -11,7 +11,7 @@
  #include <linux/debugfs.h>
  #include <linux/seq_file.h>
  
-@@ -148,6 +152,27 @@ struct dma_buf *dma_buf_export_named(voi
+@@ -180,6 +184,27 @@ struct dma_buf *dma_buf_export_named(voi
  }
  EXPORT_SYMBOL_GPL(dma_buf_export_named);
  
@@ -39,7 +39,7 @@
  
  /**
   * dma_buf_fd - returns a file descriptor for the given dma_buf
-@@ -163,9 +188,10 @@ int dma_buf_fd(struct dma_buf *dmabuf, i
+@@ -195,9 +220,10 @@ int dma_buf_fd(struct dma_buf *dmabuf, i
  	if (!dmabuf || !dmabuf->file)
  		return -EINVAL;
  
@@ -51,7 +51,7 @@
  
  	fd_install(fd, dmabuf->file);
  
-@@ -693,17 +719,15 @@ static inline void dma_buf_uninit_debugf
+@@ -725,17 +751,15 @@ static inline void dma_buf_uninit_debugf
  }
  #endif
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8187_dev.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8187_dev.patch
index 071d0be..291255b 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8187_dev.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8187_dev.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtl818x/rtl8187/dev.c
 +++ b/drivers/net/wireless/rtl818x/rtl8187/dev.c
-@@ -1290,9 +1290,17 @@ static void rtl8187_bss_info_changed(str
+@@ -1295,9 +1295,17 @@ static void rtl8187_bss_info_changed(str
  }
  
  static u64 rtl8187_prepare_multicast(struct ieee80211_hw *dev,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
index c4c2130..2d65822 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/qmi_wwan.c
 +++ b/drivers/net/usb/qmi_wwan.c
-@@ -674,7 +674,9 @@ static struct usb_driver qmi_wwan_driver
+@@ -802,7 +802,9 @@ static struct usb_driver qmi_wwan_driver
  	.resume		      =	qmi_wwan_resume,
  	.reset_resume         = qmi_wwan_resume,
  	.supports_autosuspend = 1,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtl818x_rtl8187_dev.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtl818x_rtl8187_dev.patch
index a18bb3a..3823436 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtl818x_rtl8187_dev.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtl818x_rtl8187_dev.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtl818x/rtl8187/dev.c
 +++ b/drivers/net/wireless/rtl818x/rtl8187/dev.c
-@@ -1673,7 +1673,9 @@ static struct usb_driver rtl8187_driver
+@@ -1678,7 +1678,9 @@ static struct usb_driver rtl8187_driver
  	.id_table	= rtl8187_table,
  	.probe		= rtl8187_probe,
  	.disconnect	= rtl8187_disconnect,
-- 
1.7.10.4

