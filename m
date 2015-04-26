Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:50103 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbbDZVEe (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 26 Apr 2015 17:04:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/7] patches: refresh patches on next-20150424
Date: Sun, 26 Apr 2015 23:04:24 +0200
Message-Id: <1430082264-11808-8-git-send-email-hauke@hauke-m.de> (sfid-20150426_230439_615849_72C8FA3E)
In-Reply-To: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
References: <1430082264-11808-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.68              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.106             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.73             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.39             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.37             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.10             [  OK  ]
20  3.19.3              [  OK  ]
21  4.0-rc6             [  OK  ]

manual changes done to
patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                | 38 +++++++++----------
 .../network/0004-disable-wext-kconfig.patch        |  2 +-
 .../0018-pv-trace-fixes/net_mac80211_trace.patch   |  8 ++--
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0028-select_queue/mac80211.patch       |  4 +-
 .../net_bluetooth_hidp_core.patch                  |  6 +--
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 44 +++++++++++-----------
 7 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 484b3a3..ed096b7 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -117,7 +117,7 @@
  
  	/*
  	 * Place the busy tests at the end: -EBUSY can be ignored when
-@@ -1454,6 +1462,7 @@ err:
+@@ -1481,6 +1489,7 @@ err:
  	return ret;
  }
  
@@ -125,7 +125,7 @@
  /**
   * __qbuf_dmabuf() - handle qbuf of a DMABUF buffer
   */
-@@ -1572,6 +1581,7 @@ err:
+@@ -1599,6 +1608,7 @@ err:
  
  	return ret;
  }
@@ -133,7 +133,7 @@
  
  /**
   * __enqueue_in_driver() - enqueue a vb2_buffer in driver for processing
-@@ -1634,9 +1644,11 @@ static int __buf_prepare(struct vb2_buff
+@@ -1661,9 +1671,11 @@ static int __buf_prepare(struct vb2_buff
  		ret = __qbuf_userptr(vb, b);
  		up_read(&current->mm->mmap_sem);
  		break;
@@ -145,7 +145,7 @@
  	default:
  		WARN(1, "Invalid queue type\n");
  		ret = -EINVAL;
-@@ -2022,8 +2034,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
+@@ -2049,8 +2061,10 @@ EXPORT_SYMBOL_GPL(vb2_wait_for_all_buffe
   */
  static void __vb2_dqbuf(struct vb2_buffer *vb)
  {
@@ -156,7 +156,7 @@
  
  	/* nothing to do if the buffer is already dequeued */
  	if (vb->state == VB2_BUF_STATE_DEQUEUED)
-@@ -2031,6 +2045,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2058,6 +2072,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  
  	vb->state = VB2_BUF_STATE_DEQUEUED;
  
@@ -164,7 +164,7 @@
  	/* unmap DMABUF buffer */
  	if (q->memory == V4L2_MEMORY_DMABUF)
  		for (i = 0; i < vb->num_planes; ++i) {
-@@ -2039,6 +2054,7 @@ static void __vb2_dqbuf(struct vb2_buffe
+@@ -2066,6 +2081,7 @@ static void __vb2_dqbuf(struct vb2_buffe
  			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
  			vb->planes[i].dbuf_mapped = 0;
  		}
@@ -172,7 +172,7 @@
  }
  
  static int vb2_internal_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking)
-@@ -2345,6 +2361,7 @@ static int __find_plane_by_offset(struct
+@@ -2372,6 +2388,7 @@ static int __find_plane_by_offset(struct
  	return -EINVAL;
  }
  
@@ -180,7 +180,7 @@
  /**
   * vb2_expbuf() - Export a buffer as a file descriptor
   * @q:		videobuf2 queue
-@@ -2422,6 +2439,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
+@@ -2449,6 +2466,7 @@ int vb2_expbuf(struct vb2_queue *q, stru
  	return 0;
  }
  EXPORT_SYMBOL_GPL(vb2_expbuf);
@@ -188,7 +188,7 @@
  
  /**
   * vb2_mmap() - map video buffers into application address space
-@@ -3364,6 +3382,7 @@ int vb2_ioctl_streamoff(struct file *fil
+@@ -3386,6 +3404,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -196,7 +196,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -3373,6 +3392,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -3395,6 +3414,7 @@ int vb2_ioctl_expbuf(struct file *file,
  	return vb2_expbuf(vdev->queue, p);
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
@@ -233,7 +233,7 @@
  
  /*********************************************/
  /*       callbacks for USERPTR buffers       */
-@@ -773,6 +777,7 @@ fail_buf:
+@@ -772,6 +776,7 @@ fail_buf:
  	return ERR_PTR(ret);
  }
  
@@ -241,7 +241,7 @@
  /*********************************************/
  /*       callbacks for DMABUF buffers        */
  /*********************************************/
-@@ -883,6 +888,7 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -882,6 +887,7 @@ static void *vb2_dc_attach_dmabuf(void *
  
  	return buf;
  }
@@ -249,7 +249,7 @@
  
  /*********************************************/
  /*       DMA CONTIG exported functions       */
-@@ -891,7 +897,9 @@ static void *vb2_dc_attach_dmabuf(void *
+@@ -890,7 +896,9 @@ static void *vb2_dc_attach_dmabuf(void *
  const struct vb2_mem_ops vb2_dma_contig_memops = {
  	.alloc		= vb2_dc_alloc,
  	.put		= vb2_dc_put,
@@ -259,7 +259,7 @@
  	.cookie		= vb2_dc_cookie,
  	.vaddr		= vb2_dc_vaddr,
  	.mmap		= vb2_dc_mmap,
-@@ -899,10 +907,12 @@ const struct vb2_mem_ops vb2_dma_contig_
+@@ -898,10 +906,12 @@ const struct vb2_mem_ops vb2_dma_contig_
  	.put_userptr	= vb2_dc_put_userptr,
  	.prepare	= vb2_dc_prepare,
  	.finish		= vb2_dc_finish,
@@ -367,7 +367,7 @@
  
  	void		*(*vaddr)(void *buf_priv);
  	void		*(*cookie)(void *buf_priv);
-@@ -465,7 +469,9 @@ void vb2_queue_release(struct vb2_queue
+@@ -459,7 +463,9 @@ void vb2_queue_release(struct vb2_queue
  void vb2_queue_error(struct vb2_queue *q);
  
  int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
@@ -377,7 +377,7 @@
  int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking);
  
  int vb2_streamon(struct vb2_queue *q, enum v4l2_buf_type type);
-@@ -630,8 +636,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
+@@ -624,8 +630,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
  int vb2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *p);
  int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
  int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
@@ -390,7 +390,7 @@
  
 --- a/drivers/media/platform/am437x/am437x-vpfe.c
 +++ b/drivers/media/platform/am437x/am437x-vpfe.c
-@@ -2266,7 +2266,9 @@ static const struct v4l2_ioctl_ops vpfe_
+@@ -2272,7 +2272,9 @@ static const struct v4l2_ioctl_ops vpfe_
  	.vidioc_querybuf		= vb2_ioctl_querybuf,
  	.vidioc_qbuf			= vb2_ioctl_qbuf,
  	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
@@ -402,7 +402,7 @@
  
 --- a/drivers/media/platform/coda/coda-common.c
 +++ b/drivers/media/platform/coda/coda-common.c
-@@ -845,7 +845,9 @@ static const struct v4l2_ioctl_ops coda_
+@@ -864,7 +864,9 @@ static const struct v4l2_ioctl_ops coda_
  	.vidioc_querybuf	= v4l2_m2m_ioctl_querybuf,
  
  	.vidioc_qbuf		= coda_qbuf,
@@ -474,7 +474,7 @@
  	.vidioc_g_crop			= fimc_m2m_g_crop,
 --- a/drivers/media/platform/vivid/vivid-core.c
 +++ b/drivers/media/platform/vivid/vivid-core.c
-@@ -572,7 +572,9 @@ static const struct v4l2_ioctl_ops vivid
+@@ -573,7 +573,9 @@ static const struct v4l2_ioctl_ops vivid
  	.vidioc_querybuf		= vb2_ioctl_querybuf,
  	.vidioc_qbuf			= vb2_ioctl_qbuf,
  	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
diff --git a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
index 658f2d8..82562b8 100644
--- a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
+++ b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
@@ -27,7 +27,7 @@ so remove the Kconfig options for them.
  	depends on RFKILL || !RFKILL
 @@ -177,7 +159,7 @@ config CFG80211_INTERNAL_REGDB
  config CFG80211_WEXT
- 	bool "cfg80211 wireless extensions compatibility"
+ 	bool "cfg80211 wireless extensions compatibility" if !CFG80211_WEXT_EXPORT
  	depends on CFG80211
 -	select WEXT_CORE
 +	depends on WEXT_CORE
diff --git a/patches/collateral-evolutions/network/0018-pv-trace-fixes/net_mac80211_trace.patch b/patches/collateral-evolutions/network/0018-pv-trace-fixes/net_mac80211_trace.patch
index 183cec2..b8fee1a 100644
--- a/patches/collateral-evolutions/network/0018-pv-trace-fixes/net_mac80211_trace.patch
+++ b/patches/collateral-evolutions/network/0018-pv-trace-fixes/net_mac80211_trace.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/trace.c
 +++ b/net/mac80211/trace.c
-@@ -15,12 +15,16 @@ void __sdata_info(const char *fmt, ...)
+@@ -16,12 +16,16 @@ void __sdata_info(const char *fmt, ...)
  	struct va_format vaf = {
  		.fmt = fmt,
  	};
@@ -19,7 +19,7 @@
  	trace_mac80211_info(&vaf);
  	va_end(args);
  }
-@@ -33,10 +37,16 @@ void __sdata_dbg(bool print, const char
+@@ -34,10 +38,16 @@ void __sdata_dbg(bool print, const char
  	va_list args;
  
  	va_start(args, fmt);
@@ -38,7 +38,7 @@
  	trace_mac80211_dbg(&vaf);
  	va_end(args);
  }
-@@ -46,12 +56,16 @@ void __sdata_err(const char *fmt, ...)
+@@ -47,12 +57,16 @@ void __sdata_err(const char *fmt, ...)
  	struct va_format vaf = {
  		.fmt = fmt,
  	};
@@ -57,7 +57,7 @@
  	trace_mac80211_err(&vaf);
  	va_end(args);
  }
-@@ -64,10 +78,16 @@ void __wiphy_dbg(struct wiphy *wiphy, bo
+@@ -65,10 +79,16 @@ void __wiphy_dbg(struct wiphy *wiphy, bo
  	va_list args;
  
  	va_start(args, fmt);
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index 66b0832..de7f5b2 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1262,6 +1262,9 @@ struct ieee80211_local {
+@@ -1277,6 +1277,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index 5023dc8..f9691ef 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1094,10 +1094,20 @@ static void ieee80211_uninit(struct net_
+@@ -1101,10 +1101,20 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -21,7 +21,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1113,10 +1123,20 @@ static const struct net_device_ops ieee8
+@@ -1120,10 +1130,20 @@ static const struct net_device_ops ieee8
  	.ndo_select_queue	= ieee80211_netdev_select_queue,
  };
  
diff --git a/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
index af487b3..3b63efe 100644
--- a/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
+++ b/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hidp/core.c
 +++ b/net/bluetooth/hidp/core.c
-@@ -223,6 +223,7 @@ static void hidp_input_report(struct hid
+@@ -224,6 +224,7 @@ static void hidp_input_report(struct hid
  	input_sync(dev);
  }
  
@@ -8,7 +8,7 @@
  static int hidp_get_raw_report(struct hid_device *hid,
  		unsigned char report_number,
  		unsigned char *data, size_t count,
-@@ -395,6 +396,7 @@ static int hidp_raw_request(struct hid_d
+@@ -396,6 +397,7 @@ static int hidp_raw_request(struct hid_d
  		return -EIO;
  	}
  }
@@ -16,7 +16,7 @@
  
  static void hidp_idle_timeout(unsigned long arg)
  {
-@@ -724,8 +726,10 @@ static struct hid_ll_driver hidp_hid_dri
+@@ -725,8 +727,10 @@ static struct hid_ll_driver hidp_hid_dri
  	.stop = hidp_stop,
  	.open  = hidp_open,
  	.close = hidp_close,
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index 35297c7..22e8c2d 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,32 +1,32 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1841,8 +1841,12 @@ static int btusb_recv_event_intel(struct
- 			if (test_and_clear_bit(BTUSB_DOWNLOADING,
- 					       &data->flags) &&
- 			    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
+@@ -2151,8 +2151,12 @@ static void btusb_intel_bootup(struct bt
+ 		return;
+ 
+ 	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
- 				smp_mb__after_atomic();
- 				wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
+ 		smp_mb__after_atomic();
+ 		wake_up_bit(&data->flags, BTUSB_BOOTING);
 +#else
-+				wake_up_interruptible(&hdev->req_wait_q);
++		wake_up_interruptible(&data->hdev->req_wait_q);
 +#endif
- 			}
- 		}
+ 	}
+ }
  
-@@ -1853,8 +1857,12 @@ static int btusb_recv_event_intel(struct
- 		if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
- 		    skb->data[2] == 0x02) {
- 			if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
+@@ -2169,8 +2173,12 @@ static void btusb_intel_secure_send_resu
+ 
+ 	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
+ 	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
- 				smp_mb__after_atomic();
- 				wake_up_bit(&data->flags, BTUSB_BOOTING);
+ 		smp_mb__after_atomic();
+ 		wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
 +#else
-+				wake_up_interruptible(&hdev->req_wait_q);
++		wake_up_interruptible(&data->hdev->req_wait_q);
 +#endif
- 			}
- 		}
  	}
-@@ -2222,6 +2230,7 @@ static int btusb_setup_intel_new(struct
+ }
+ 
+@@ -2569,6 +2577,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2236,6 +2245,31 @@ static int btusb_setup_intel_new(struct
+@@ -2583,6 +2592,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2275,6 +2309,7 @@ done:
+@@ -2622,6 +2656,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2288,6 +2323,33 @@ done:
+@@ -2635,6 +2670,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
-- 
1.9.1

