Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40652 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbaJYSpx (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 14:45:53 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/11] backports: refresh patches on next-20141003
Date: Sat, 25 Oct 2014 11:19:28 +0200
Message-Id: <1414228770-20047-10-git-send-email-hauke@hauke-m.de> (sfid-20141025_204557_122783_CAFD3CA2)
In-Reply-To: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
References: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.62              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.103             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.54             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.27             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.18             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.2              [  OK  ]
18  3.17-rc3            [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                | 30 +++++++++++-----------
 .../0017-get_ts_info/drivers_net_usb_usbnet.patch  |  2 +-
 .../network/0025-usb-sg/usbnet.patch               | 12 ++++-----
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../0030-qdisc_tx_busylock/ieee802154.patch        |  4 +--
 .../network/0046-mmc_rescan_entered/mwifiex.patch  |  2 +-
 6 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 7947b57..02d042a 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/v4l2-core/Kconfig
 +++ b/drivers/media/v4l2-core/Kconfig
-@@ -67,7 +67,7 @@ config VIDEOBUF_DVB
+@@ -68,7 +68,7 @@ config VIDEOBUF_DVB
  
  # Used by drivers that need Videobuf2 modules
  config VIDEOBUF2_CORE
@@ -9,7 +9,7 @@
  	tristate
  
  config VIDEOBUF2_MEMOPS
-@@ -78,13 +78,13 @@ config VIDEOBUF2_DMA_CONTIG
+@@ -79,13 +79,13 @@ config VIDEOBUF2_DMA_CONTIG
  	depends on HAS_DMA
  	select VIDEOBUF2_CORE
  	select VIDEOBUF2_MEMOPS
@@ -117,7 +117,7 @@
  
  	/*
  	 * Place the busy tests at the end: -EBUSY can be ignored when
-@@ -1452,6 +1460,7 @@ err:
+@@ -1451,6 +1459,7 @@ err:
  	return ret;
  }
  
@@ -125,7 +125,7 @@
  /**
   * __qbuf_dmabuf() - handle qbuf of a DMABUF buffer
   */
-@@ -1569,6 +1578,7 @@ err:
+@@ -1568,6 +1577,7 @@ err:
  
  	return ret;
  }
@@ -133,9 +133,9 @@
  
  /**
   * __enqueue_in_driver() - enqueue a vb2_buffer in driver for processing
-@@ -1629,9 +1639,11 @@ static int __buf_prepare(struct vb2_buff
- 	case V4L2_MEMORY_USERPTR:
+@@ -1630,9 +1640,11 @@ static int __buf_prepare(struct vb2_buff
  		ret = __qbuf_userptr(vb, b);
+ 		up_read(&current->mm->mmap_sem);
  		break;
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
  	case V4L2_MEMORY_DMABUF:
@@ -145,7 +145,7 @@
  	default:
  		WARN(1, "Invalid queue type\n");
  		ret = -EINVAL;
-@@ -2004,8 +2016,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
+@@ -2018,8 +2030,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
   */
  static void __vb2_dqbuf(struct vb2_buffer *vb)
  {
@@ -156,7 +156,7 @@
  
  	/* nothing to do if the buffer is already dequeued */
  	if (vb->state == VB2_BUF_STATE_DEQUEUED)
-@@ -2013,6 +2027,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2027,6 +2041,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  
  	vb->state = VB2_BUF_STATE_DEQUEUED;
  
@@ -164,7 +164,7 @@
  	/* unmap DMABUF buffer */
  	if (q->memory == V4L2_MEMORY_DMABUF)
  		for (i = 0; i < vb->num_planes; ++i) {
-@@ -2021,6 +2036,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2035,6 +2050,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
  			vb->planes[i].dbuf_mapped = 0;
  		}
@@ -172,7 +172,7 @@
  }
  
  static int vb2_internal_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking)
-@@ -2320,6 +2336,7 @@ static int __find_plane_by_offset(struct
+@@ -2341,6 +2357,7 @@ static int __find_plane_by_offset(struct
  	return -EINVAL;
  }
  
@@ -180,7 +180,7 @@
  /**
   * vb2_expbuf() - Export a buffer as a file descriptor
   * @q:		videobuf2 queue
-@@ -2397,6 +2414,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
+@@ -2418,6 +2435,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
  	return 0;
  }
  EXPORT_SYMBOL_GPL(vb2_expbuf);
@@ -188,7 +188,7 @@
  
  /**
   * vb2_mmap() - map video buffers into application address space
-@@ -3333,6 +3351,7 @@ int vb2_ioctl_streamoff(struct file *fil
+@@ -3361,6 +3379,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -196,7 +196,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -3342,6 +3361,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -3370,6 +3389,7 @@ int vb2_ioctl_expbuf(struct file *file,
  	return vb2_expbuf(vdev->queue, p);
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
@@ -363,7 +363,7 @@
  
  	void		*(*vaddr)(void *buf_priv);
  	void		*(*cookie)(void *buf_priv);
-@@ -455,7 +459,9 @@ void vb2_queue_release(struct vb2_queue
+@@ -459,7 +463,9 @@ void vb2_queue_release(struct vb2_queue
  void vb2_queue_error(struct vb2_queue *q);
  
  int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
@@ -373,7 +373,7 @@
  int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking);
  
  int vb2_streamon(struct vb2_queue *q, enum v4l2_buf_type type);
-@@ -611,8 +617,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
+@@ -624,8 +630,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
  int vb2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *p);
  int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
  int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch b/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
index c19f6b1..68d22e5 100644
--- a/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
+++ b/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1022,7 +1022,9 @@ static const struct ethtool_ops usbnet_e
+@@ -1023,7 +1023,9 @@ static const struct ethtool_ops usbnet_e
  	.get_drvinfo		= usbnet_get_drvinfo,
  	.get_msglevel		= usbnet_get_msglevel,
  	.set_msglevel		= usbnet_set_msglevel,
diff --git a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
index 6e2cdfe..f928dbe 100644
--- a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1231,6 +1231,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1233,6 +1233,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1263,6 +1264,12 @@ static int build_dma_sg(const struct sk_
+@@ -1265,6 +1266,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1319,12 +1326,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1321,12 +1328,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1379,7 +1393,9 @@ not_drop:
+@@ -1381,7 +1395,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1432,7 +1448,9 @@ static void usbnet_bh (unsigned long par
+@@ -1434,7 +1450,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1787,7 +1805,9 @@ int usbnet_resume (struct usb_interface
+@@ -1789,7 +1807,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index c10d3b0..919a960 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -717,9 +717,19 @@ static struct net_device_stats *mwifiex_
+@@ -714,9 +714,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
index 62e743c..0533c20 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
@@ -1,6 +1,6 @@
 --- a/net/ieee802154/6lowpan_rtnl.c
 +++ b/net/ieee802154/6lowpan_rtnl.c
-@@ -389,7 +389,9 @@ static struct header_ops lowpan_header_o
+@@ -442,7 +442,9 @@ static struct header_ops lowpan_header_o
  	.create	= lowpan_header_create,
  };
  
@@ -10,7 +10,7 @@
  static struct lock_class_key lowpan_netdev_xmit_lock_key;
  
  static void lowpan_set_lockdep_class_one(struct net_device *dev,
-@@ -404,7 +406,9 @@ static void lowpan_set_lockdep_class_one
+@@ -457,7 +459,9 @@ static void lowpan_set_lockdep_class_one
  static int lowpan_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
diff --git a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
index 89de2fb..bf21470 100644
--- a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -1954,7 +1954,9 @@ static void mwifiex_sdio_card_reset_work
+@@ -1958,7 +1958,9 @@ static void mwifiex_sdio_card_reset_work
  	mmc_remove_host(target);
  	/* 20ms delay is based on experiment with sdhci controller */
  	mdelay(20);
-- 
1.9.1

