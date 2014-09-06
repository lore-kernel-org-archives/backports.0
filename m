Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48143 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbaIFXX6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 6 Sep 2014 19:23:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] backports: bluetooth revert patch adding write_iter
Date: Sun,  7 Sep 2014 01:23:35 +0200
Message-Id: <1410045817-4112-3-git-send-email-hauke@hauke-m.de> (sfid-20140907_012404_236545_9EB4013B)
In-Reply-To: <1410045817-4112-1-git-send-email-hauke@hauke-m.de>
References: <1410045817-4112-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This reverts this upstream patch for older kernel versions:

commit 9f87eaae842575ec7de51654127a9bf4ad07ad6d
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Aug 23 11:28:14 2014 -0400

    switch hci_vhci to ->write_iter()

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0047-write_iter/bluetooth.patch        | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0047-write_iter/bluetooth.patch

diff --git a/patches/collateral-evolutions/network/0047-write_iter/bluetooth.patch b/patches/collateral-evolutions/network/0047-write_iter/bluetooth.patch
new file mode 100644
index 0000000..692b777
--- /dev/null
+++ b/patches/collateral-evolutions/network/0047-write_iter/bluetooth.patch
@@ -0,0 +1,83 @@
+--- a/drivers/bluetooth/hci_vhci.c
++++ b/drivers/bluetooth/hci_vhci.c
+@@ -159,6 +159,7 @@ static int vhci_create_device(struct vhc
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
+ static inline ssize_t vhci_get_user(struct vhci_data *data,
+ 				    struct iov_iter *from)
+ {
+@@ -166,6 +167,17 @@ static inline ssize_t vhci_get_user(stru
+ 	struct sk_buff *skb;
+ 	__u8 pkt_type, opcode;
+ 	int ret;
++#else
++static inline ssize_t vhci_get_user(struct vhci_data *data,
++				    const struct iovec *iov,
++				    unsigned long count)
++{
++	size_t len = iov_length(iov, count);
++	struct sk_buff *skb;
++	__u8 pkt_type, opcode;
++	unsigned long i;
++	int ret;
++#endif
+ 
+ 	if (len < 2 || len > HCI_MAX_FRAME_SIZE)
+ 		return -EINVAL;
+@@ -174,10 +186,20 @@ static inline ssize_t vhci_get_user(stru
+ 	if (!skb)
+ 		return -ENOMEM;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
+ 	if (copy_from_iter(skb_put(skb, len), len, from) != len) {
+ 		kfree_skb(skb);
+ 		return -EFAULT;
+ 	}
++#else
++	for (i = 0; i < count; i++) {
++		if (copy_from_user(skb_put(skb, iov[i].iov_len),
++				   iov[i].iov_base, iov[i].iov_len)) {
++			kfree_skb(skb);
++			return -EFAULT;
++		}
++	}
++#endif
+ 
+ 	pkt_type = *((__u8 *) skb->data);
+ 	skb_pull(skb, 1);
+@@ -289,12 +311,21 @@ static ssize_t vhci_read(struct file *fi
+ 	return ret;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
+ static ssize_t vhci_write(struct kiocb *iocb, struct iov_iter *from)
++#else
++static ssize_t vhci_write(struct kiocb *iocb, const struct iovec *iov,
++			  unsigned long count, loff_t pos)
++#endif
+ {
+ 	struct file *file = iocb->ki_filp;
+ 	struct vhci_data *data = file->private_data;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
+ 	return vhci_get_user(data, from);
++#else
++	return vhci_get_user(data, iov, count);
++#endif
+ }
+ 
+ static unsigned int vhci_poll(struct file *file, poll_table *wait)
+@@ -359,7 +390,11 @@ static int vhci_release(struct inode *in
+ static const struct file_operations vhci_fops = {
+ 	.owner		= THIS_MODULE,
+ 	.read		= vhci_read,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
+ 	.write_iter	= vhci_write,
++#else
++	.aio_write	= vhci_write,
++#endif
+ 	.poll		= vhci_poll,
+ 	.open		= vhci_open,
+ 	.release	= vhci_release,
-- 
1.9.1

