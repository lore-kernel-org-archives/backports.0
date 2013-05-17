Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:34196 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab3EQLBA (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 17 May 2013 07:01:00 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro8so3188865pbb.41
        for <backports@vger.kernel.org>; Fri, 17 May 2013 04:00:59 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/3] backports: refresh patches for next-20130430
Date: Fri, 17 May 2013 04:00:44 -0700
Message-Id: <1368788445-1641-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130517_130101_595023_36F966AC)
In-Reply-To: <1368788445-1641-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368788445-1641-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.76              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.44              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.43              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.11              [  OK  ]
26  3.9.0               [  OK  ]

real    30m45.327s
user    814m25.678s
sys     128m22.341s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../media/0002-dma_mmap_coherent-revert.patch            |    4 ++--
 .../nfc/01-netlink-portid/net_nfc_netlink.patch          |   14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/patches/collateral-evolutions/media/0002-dma_mmap_coherent-revert.patch b/patches/collateral-evolutions/media/0002-dma_mmap_coherent-revert.patch
index 2a6f51a..c1f3dc5 100644
--- a/patches/collateral-evolutions/media/0002-dma_mmap_coherent-revert.patch
+++ b/patches/collateral-evolutions/media/0002-dma_mmap_coherent-revert.patch
@@ -25,7 +25,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
 
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -186,6 +186,52 @@ static void *vb2_dc_alloc(void *alloc_ct
+@@ -183,6 +183,52 @@ static void *vb2_dc_alloc(void *alloc_ct
  	return buf;
  }
  
@@ -78,7 +78,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
  static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
  {
  	struct vb2_dc_buf *buf = buf_priv;
-@@ -222,6 +238,7 @@ static int vb2_dc_mmap(void *buf_priv, s
+@@ -219,6 +265,7 @@ static int vb2_dc_mmap(void *buf_priv, s
  
  	return 0;
  }
diff --git a/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch b/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
index 61770ce..cee65ee 100644
--- a/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
+++ b/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
@@ -1,6 +1,6 @@
 --- a/net/nfc/netlink.c
 +++ b/net/nfc/netlink.c
-@@ -69,7 +69,7 @@ static int nfc_genl_send_target(struct s
+@@ -68,7 +68,7 @@ static int nfc_genl_send_target(struct s
  {
  	void *hdr;
  
@@ -9,7 +9,7 @@
  			  &nfc_genl_family, flags, NFC_CMD_GET_TARGET);
  	if (!hdr)
  		return -EMSGSIZE;
-@@ -482,7 +482,7 @@ static int nfc_genl_dump_devices(struct
+@@ -481,7 +481,7 @@ static int nfc_genl_dump_devices(struct
  	while (dev) {
  		int rc;
  
@@ -18,7 +18,7 @@
  					  cb->nlh->nlmsg_seq, cb, NLM_F_MULTI);
  		if (rc < 0)
  			break;
-@@ -601,7 +601,7 @@ static int nfc_genl_get_device(struct sk
+@@ -600,7 +600,7 @@ static int nfc_genl_get_device(struct sk
  		goto out_putdev;
  	}
  
@@ -27,7 +27,7 @@
  				  NULL, 0);
  	if (rc < 0)
  		goto out_free;
-@@ -692,7 +692,7 @@ static int nfc_genl_start_poll(struct sk
+@@ -691,7 +691,7 @@ static int nfc_genl_start_poll(struct sk
  
  	rc = nfc_start_poll(dev, im_protocols, tm_protocols);
  	if (!rc)
@@ -36,7 +36,7 @@
  
  	mutex_unlock(&dev->genl_data.genl_data_mutex);
  
-@@ -726,7 +726,7 @@ static int nfc_genl_stop_poll(struct sk_
+@@ -725,7 +725,7 @@ static int nfc_genl_stop_poll(struct sk_
  
  	mutex_lock(&dev->genl_data.genl_data_mutex);
  
@@ -45,7 +45,7 @@
  		rc = -EBUSY;
  		goto out;
  	}
-@@ -852,7 +852,7 @@ static int nfc_genl_llc_get_params(struc
+@@ -851,7 +851,7 @@ static int nfc_genl_llc_get_params(struc
  		goto exit;
  	}
  
@@ -54,7 +54,7 @@
  
  exit:
  	device_unlock(&dev->dev);
-@@ -1135,12 +1135,12 @@ static int nfc_genl_rcv_nl_event(struct
+@@ -1134,12 +1134,12 @@ static int nfc_genl_rcv_nl_event(struct
  	if (event != NETLINK_URELEASE || n->protocol != NETLINK_GENERIC)
  		goto out;
  
-- 
1.7.10.4

