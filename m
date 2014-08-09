Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:44938 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718AbaHIOrs (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 9 Aug 2014 10:47:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/6] backports: refresh patches on next-20140808
Date: Sat,  9 Aug 2014 16:47:38 +0200
Message-Id: <1407595659-10396-6-git-send-email-hauke@hauke-m.de> (sfid-20140809_164754_655654_B532BF9F)
In-Reply-To: <1407595659-10396-1-git-send-email-hauke@hauke-m.de>
References: <1407595659-10396-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.62              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.102             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.52             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.26             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.16             [  OK  ]
16  3.15.7              [  OK  ]
17  3.16.0              [  OK  ]

Manual changes were done to:
patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch

This patch was removed:
patches/collateral-evolutions/network/0009-inet_frag_evictor.patch

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                  |  8 ++++----
 .../media/0003-devnode_param_type/rc.patch           |  2 +-
 .../network/0006-ieee802154-6lowpan-namespace.patch  | 19 +++++++++++++++----
 .../network/0007-lowpan-inet_frag_lru_move.patch     |  2 +-
 .../network/0008-net-user-ns.patch                   |  2 +-
 .../network/0009-inet_frag_evictor.patch             | 20 --------------------
 .../network/0025-usb-sg/usbnet.patch                 | 12 ++++++------
 .../0032-sriov_configure/igb_sriov_configure.patch   |  8 ++++----
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch   |  8 ++++----
 .../igb_ndo_set_vf_spoofchk.patch                    |  6 +++---
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch     |  2 +-
 .../network/0043-ndo_set_vf_rate/igb.patch           |  8 ++++----
 12 files changed, 44 insertions(+), 53 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0009-inet_frag_evictor.patch

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 1ccc455..a6f4bf5 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -188,7 +188,7 @@
  
  /**
   * vb2_mmap() - map video buffers into application address space
-@@ -3324,6 +3342,7 @@ int vb2_ioctl_streamoff(struct file *fil
+@@ -3331,6 +3349,7 @@ int vb2_ioctl_streamoff(struct file *fil
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_streamoff);
  
@@ -196,7 +196,7 @@
  int vb2_ioctl_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *p)
  {
  	struct video_device *vdev = video_devdata(file);
-@@ -3333,6 +3352,7 @@ int vb2_ioctl_expbuf(struct file *file,
+@@ -3340,6 +3359,7 @@ int vb2_ioctl_expbuf(struct file *file,
  	return vb2_expbuf(vdev->queue, p);
  }
  EXPORT_SYMBOL_GPL(vb2_ioctl_expbuf);
@@ -363,7 +363,7 @@
  
  	void		*(*vaddr)(void *buf_priv);
  	void		*(*cookie)(void *buf_priv);
-@@ -449,7 +453,9 @@ void vb2_queue_release(struct vb2_queue
+@@ -453,7 +457,9 @@ void vb2_queue_release(struct vb2_queue
  void vb2_queue_error(struct vb2_queue *q);
  
  int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
@@ -373,7 +373,7 @@
  int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking);
  
  int vb2_streamon(struct vb2_queue *q, enum v4l2_buf_type type);
-@@ -605,8 +611,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
+@@ -609,8 +615,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
  int vb2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *p);
  int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
  int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
diff --git a/patches/collateral-evolutions/media/0003-devnode_param_type/rc.patch b/patches/collateral-evolutions/media/0003-devnode_param_type/rc.patch
index 38acfda..398a88e 100644
--- a/patches/collateral-evolutions/media/0003-devnode_param_type/rc.patch
+++ b/patches/collateral-evolutions/media/0003-devnode_param_type/rc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/media/rc/rc-main.c
 +++ b/drivers/media/rc/rc-main.c
-@@ -755,7 +755,11 @@ static void ir_close(struct input_dev *i
+@@ -761,7 +761,11 @@ static void ir_close(struct input_dev *i
  }
  
  /* class for /sys/class/rc */
diff --git a/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch b/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
index 82d7ae3..609bf20 100644
--- a/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
+++ b/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
@@ -4,7 +4,7 @@ idea yet.
 
 --- a/net/ieee802154/reassembly.c
 +++ b/net/ieee802154/reassembly.c
-@@ -99,7 +99,11 @@ static void lowpan_frag_expire(unsigned
+@@ -97,7 +97,11 @@ static void lowpan_frag_expire(unsigned
  	struct net *net;
  
  	fq = container_of((struct inet_frag_queue *)data, struct frag_queue, q);
@@ -16,7 +16,7 @@ idea yet.
  
  	spin_lock(&fq->q.lock);
  
-@@ -397,28 +401,44 @@ EXPORT_SYMBOL(lowpan_frag_rcv);
+@@ -393,31 +397,55 @@ static int zero;
  static struct ctl_table lowpan_frags_ns_ctl_table[] = {
  	{
  		.procname	= "6lowpanfrag_high_thresh",
@@ -27,7 +27,12 @@ idea yet.
 +#endif
  		.maxlen		= sizeof(int),
  		.mode		= 0644,
- 		.proc_handler	= proc_dointvec
+ 		.proc_handler	= proc_dointvec_minmax,
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
+ 		.extra1		= &init_net.ieee802154_lowpan.frags.low_thresh
++#else
++		.extra1		= &ieee802154_lowpan.frags.low_thresh
++#endif
  	},
  	{
  		.procname	= "6lowpanfrag_low_thresh",
@@ -38,7 +43,13 @@ idea yet.
 +#endif
  		.maxlen		= sizeof(int),
  		.mode		= 0644,
- 		.proc_handler	= proc_dointvec
+ 		.proc_handler	= proc_dointvec_minmax,
+ 		.extra1		= &zero,
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
+ 		.extra2		= &init_net.ieee802154_lowpan.frags.high_thresh
++#else
++		.extra2		= &ieee802154_lowpan.frags.high_thresh
++#endif
  	},
  	{
  		.procname	= "6lowpanfrag_time",
diff --git a/patches/collateral-evolutions/network/0007-lowpan-inet_frag_lru_move.patch b/patches/collateral-evolutions/network/0007-lowpan-inet_frag_lru_move.patch
index 6692c0c..de22c92 100644
--- a/patches/collateral-evolutions/network/0007-lowpan-inet_frag_lru_move.patch
+++ b/patches/collateral-evolutions/network/0007-lowpan-inet_frag_lru_move.patch
@@ -4,7 +4,7 @@ and then domain specific inet_frag_lru_move() define.
 
 --- a/net/ieee802154/reassembly.c
 +++ b/net/ieee802154/reassembly.c
-@@ -91,6 +91,9 @@ static void lowpan_frag_init(struct inet
+@@ -89,6 +89,9 @@ static void lowpan_frag_init(struct inet
  	fq->d_size = arg->d_size;
  	fq->saddr = *arg->src;
  	fq->daddr = *arg->dst;
diff --git a/patches/collateral-evolutions/network/0008-net-user-ns.patch b/patches/collateral-evolutions/network/0008-net-user-ns.patch
index d3a55d8..d9cea85 100644
--- a/patches/collateral-evolutions/network/0008-net-user-ns.patch
+++ b/patches/collateral-evolutions/network/0008-net-user-ns.patch
@@ -3,7 +3,7 @@ via commit 038e7332b8.
 
 --- a/net/ieee802154/reassembly.c
 +++ b/net/ieee802154/reassembly.c
-@@ -479,9 +479,11 @@ static int __net_init lowpan_frags_ns_sy
+@@ -491,9 +491,11 @@ static int __net_init lowpan_frags_ns_sy
  		table[2].data = &ieee802154_lowpan->frags.timeout;
  		table[3].data = &ieee802154_lowpan->max_dsize;
  
diff --git a/patches/collateral-evolutions/network/0009-inet_frag_evictor.patch b/patches/collateral-evolutions/network/0009-inet_frag_evictor.patch
deleted file mode 100644
index 63ee691..0000000
--- a/patches/collateral-evolutions/network/0009-inet_frag_evictor.patch
+++ /dev/null
@@ -1,20 +0,0 @@
-We can't backport this with a macro or inline helper, so just
-carry the patch and if this grows consider Coccinelle SmPL version.
-
---- a/net/ieee802154/reassembly.c
-+++ b/net/ieee802154/reassembly.c
-@@ -380,7 +380,14 @@ int lowpan_frag_rcv(struct sk_buff *skb,
- 	if (frag_info->d_size > ieee802154_lowpan->max_dsize)
- 		goto err;
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
- 	inet_frag_evictor(&ieee802154_lowpan->frags, &lowpan_frags, false);
-+#else
-+	if (atomic_read(&ieee802154_lowpan->frags.mem) <= &ieee802154_lowpan->frags.high_thresh)
-+		return 0;
-+	else
-+		inet_frag_evictor(&ieee802154_lowpan->frags, &lowpan_frags);
-+#endif
- 
- 	fq = fq_find(net, frag_info, &source, &dest);
- 	if (fq != NULL) {
diff --git a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
index 81b451a..6e2cdfe 100644
--- a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1227,6 +1227,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1231,6 +1231,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1259,6 +1260,12 @@ static int build_dma_sg(const struct sk_
+@@ -1263,6 +1264,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1315,12 +1322,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1319,12 +1326,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1375,7 +1389,9 @@ not_drop:
+@@ -1379,7 +1393,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1428,7 +1444,9 @@ static void usbnet_bh (unsigned long par
+@@ -1432,7 +1448,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1783,7 +1801,9 @@ int usbnet_resume (struct usb_interface
+@@ -1787,7 +1805,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 7f0c1ea..49d894b 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -20,7 +20,7 @@
  	.err_handler = &igb_err_handler
  };
  
-@@ -7614,6 +7618,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7639,6 +7643,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -28,7 +28,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7623,6 +7628,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7648,6 +7653,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
@@ -36,7 +36,7 @@
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
-@@ -7640,6 +7646,7 @@ out:
+@@ -7665,6 +7671,7 @@ out:
  }
  
  #endif
@@ -44,7 +44,7 @@
  static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs)
  {
  #ifdef CONFIG_PCI_IOV
-@@ -7650,6 +7657,7 @@ static int igb_pci_sriov_configure(struc
+@@ -7675,6 +7682,7 @@ static int igb_pci_sriov_configure(struc
  #endif
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 9bf192e..8ef2e21 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7282,8 +7290,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7307,8 +7315,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7297,11 +7311,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7322,11 +7336,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7317,7 +7339,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7342,7 +7364,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7327,7 +7351,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7352,7 +7376,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index f6b98a4..742e2bc 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -21,7 +21,7 @@
  	.ndo_get_vf_config	= igb_ndo_get_vf_config,
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller	= igb_netpoll,
-@@ -7965,6 +7969,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7990,6 +7994,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	return 0;
  }
  
@@ -29,7 +29,7 @@
  static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf,
  				   bool setting)
  {
-@@ -7991,6 +7996,7 @@ static int igb_ndo_set_vf_spoofchk(struc
+@@ -8016,6 +8021,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
  	return 0;
  }
@@ -37,7 +37,7 @@
  
  static int igb_ndo_get_vf_config(struct net_device *netdev,
  				 int vf, struct ifla_vf_info *ivi)
-@@ -8004,7 +8010,9 @@ static int igb_ndo_get_vf_config(struct
+@@ -8029,7 +8035,9 @@ static int igb_ndo_get_vf_config(struct
  	ivi->min_tx_rate = 0;
  	ivi->vlan = adapter->vf_data[vf].pf_vlan;
  	ivi->qos = adapter->vf_data[vf].pf_qos;
diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
index 8ae57b6..de77231 100644
--- a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
+++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4775,9 +4775,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
+@@ -4800,9 +4800,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
  	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
  				 (E1000_ADVTXD_MAC_TSTAMP));
  
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
index e8f5419..ed1db41 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
@@ -24,7 +24,7 @@
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
  	.ndo_set_vf_spoofchk	= igb_ndo_set_vf_spoofchk,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
-@@ -7947,8 +7955,12 @@ static void igb_check_vf_rate_limit(stru
+@@ -7972,8 +7980,12 @@ static void igb_check_vf_rate_limit(stru
  	}
  }
  
@@ -37,7 +37,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7957,6 +7969,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7982,6 +7994,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -45,7 +45,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7970,7 +7983,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7995,7 +8008,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
@@ -63,7 +63,7 @@
  	return 0;
  }
  
-@@ -8011,8 +8034,12 @@ static int igb_ndo_get_vf_config(struct
+@@ -8036,8 +8059,12 @@ static int igb_ndo_get_vf_config(struct
  		return -EINVAL;
  	ivi->vf = vf;
  	memcpy(&ivi->mac, adapter->vf_data[vf].vf_mac_addresses, ETH_ALEN);
-- 
1.9.1

