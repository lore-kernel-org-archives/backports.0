Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2425 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932198Ab3DHK0f (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Apr 2013 06:26:35 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: =?UTF-8?q?=5BPATCH=20v3=206/8=5D=20backports=3A=20add=20NFC=20patches?=
Date: Mon,  8 Apr 2013 12:26:11 +0200
Message-Id: <1365416773-12836-7-git-send-email-thierry.escande@linux.intel.com> (sfid-20130408_122641_570139_8BCDA0E0)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These are NFC patches refreshed on next-20130404

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 .../nfc/01-netlink-portid/INFO                     |   42 +++++
 .../nfc/01-netlink-portid/net_nfc_netlink.patch    |   71 ++++++++
 patches/collateral-evolutions/nfc/02-pr_fmt/INFO   |    6 +
 .../nfc/02-pr_fmt/net_nfc.patch                    |  181 ++++++++++++++++++++
 .../nfc/03-driver-core-constify-data/INFO          |    7 +
 .../net_nfc_core.patch                             |   14 ++
 6 files changed, 321 insertions(+)
 create mode 100644 patches/collateral-evolutions/nfc/01-netlink-portid/INFO
 create mode 100644 patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
 create mode 100644 patches/collateral-evolutions/nfc/02-pr_fmt/INFO
 create mode 100644 patches/collateral-evolutions/nfc/02-pr_fmt/net_nfc.patch
 create mode 100644 patches/collateral-evolutions/nfc/03-driver-core-constify-data/INFO
 create mode 100644 patches/collateral-evolutions/nfc/03-driver-core-constify-data/net_nfc_core.patch

diff --git a/patches/collateral-evolutions/nfc/01-netlink-portid/INFO b/patches/collateral-evolutions/nfc/01-netlink-portid/INFO
new file mode 100644
index 0000000..e49ac3b
--- /dev/null
+++ b/patches/collateral-evolutions/nfc/01-netlink-portid/INFO
@@ -0,0 +1,42 @@
+The patch:
+
+commit 15e473046cb6e5d18a4d0057e61d76315230382b
+Author: Eric W. Biederman <ebiederm@xmission.com>
+Date:   Fri Sep 7 20:12:54 2012 +0000
+
+    netlink: Rename pid to portid to avoid confusion
+    
+    It is a frequent mistake to confuse the netlink port identifier with a
+    process identifier.  Try to reduce this confusion by renaming fields
+    that hold port identifiers portid instead of pid.
+    
+    I have carefully avoided changing the structures exported to
+    userspace to avoid changing the userspace API.
+    
+    I have successfully built an allyesconfig kernel with this change.
+    
+    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
+    Acked-by: Stephen Hemminger <shemminger@vyatta.com>
+    Signed-off-by: David S. Miller <davem@davemloft.net>
+
+Changed the struct members:
+
+struct netlink_notify->pid    to
+struct netlink_notify->portid
+
+struct genl_info->snd_pid     to
+struct genl_info->snd_portid
+
+To help backport this and not have to #ifdef around it against
+kernel versions compat has introduced two helpers for us to
+simply do the backport with two macro helpers:
+
+genl_info_snd_portid()
+netlink_notify_portid()
+
+This takes care of the work for us requiring only one
+single line change. If we get another patch thrown into
+this file then I suspect we can extract SMPL out of it
+and use it to backport further collateral evolutions like
+this one should other drivers / subsystem need this change.
+
diff --git a/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch b/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
new file mode 100644
index 0000000..61770ce
--- /dev/null
+++ b/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
@@ -0,0 +1,71 @@
+--- a/net/nfc/netlink.c
++++ b/net/nfc/netlink.c
+@@ -69,7 +69,7 @@ static int nfc_genl_send_target(struct s
+ {
+ 	void *hdr;
+ 
+-	hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
++	hdr = genlmsg_put(msg, NETLINK_CB_PORTID(cb->skb), cb->nlh->nlmsg_seq,
+ 			  &nfc_genl_family, flags, NFC_CMD_GET_TARGET);
+ 	if (!hdr)
+ 		return -EMSGSIZE;
+@@ -482,7 +482,7 @@ static int nfc_genl_dump_devices(struct
+ 	while (dev) {
+ 		int rc;
+ 
+-		rc = nfc_genl_send_device(skb, dev, NETLINK_CB(cb->skb).portid,
++		rc = nfc_genl_send_device(skb, dev, NETLINK_CB_PORTID(cb->skb),
+ 					  cb->nlh->nlmsg_seq, cb, NLM_F_MULTI);
+ 		if (rc < 0)
+ 			break;
+@@ -601,7 +601,7 @@ static int nfc_genl_get_device(struct sk
+ 		goto out_putdev;
+ 	}
+ 
+-	rc = nfc_genl_send_device(msg, dev, info->snd_portid, info->snd_seq,
++	rc = nfc_genl_send_device(msg, dev, genl_info_snd_portid(info), info->snd_seq,
+ 				  NULL, 0);
+ 	if (rc < 0)
+ 		goto out_free;
+@@ -692,7 +692,7 @@ static int nfc_genl_start_poll(struct sk
+ 
+ 	rc = nfc_start_poll(dev, im_protocols, tm_protocols);
+ 	if (!rc)
+-		dev->genl_data.poll_req_portid = info->snd_portid;
++		dev->genl_data.poll_req_portid = genl_info_snd_portid(info);
+ 
+ 	mutex_unlock(&dev->genl_data.genl_data_mutex);
+ 
+@@ -726,7 +726,7 @@ static int nfc_genl_stop_poll(struct sk_
+ 
+ 	mutex_lock(&dev->genl_data.genl_data_mutex);
+ 
+-	if (dev->genl_data.poll_req_portid != info->snd_portid) {
++	if (dev->genl_data.poll_req_portid != genl_info_snd_portid(info)) {
+ 		rc = -EBUSY;
+ 		goto out;
+ 	}
+@@ -852,7 +852,7 @@ static int nfc_genl_llc_get_params(struc
+ 		goto exit;
+ 	}
+ 
+-	rc = nfc_genl_send_params(msg, local, info->snd_portid, info->snd_seq);
++	rc = nfc_genl_send_params(msg, local, genl_info_snd_portid(info), info->snd_seq);
+ 
+ exit:
+ 	device_unlock(&dev->dev);
+@@ -1135,12 +1135,12 @@ static int nfc_genl_rcv_nl_event(struct
+ 	if (event != NETLINK_URELEASE || n->protocol != NETLINK_GENERIC)
+ 		goto out;
+ 
+-	pr_debug("NETLINK_URELEASE event from id %d\n", n->portid);
++	pr_debug("NETLINK_URELEASE event from id %d\n", netlink_notify_portid(n));
+ 
+ 	w = kmalloc(sizeof(*w), GFP_ATOMIC);
+ 	if (w) {
+ 		INIT_WORK((struct work_struct *) w, nfc_urelease_event_work);
+-		w->portid = n->portid;
++		w->portid = netlink_notify_portid(n);
+ 		schedule_work((struct work_struct *) w);
+ 	}
+ 
diff --git a/patches/collateral-evolutions/nfc/02-pr_fmt/INFO b/patches/collateral-evolutions/nfc/02-pr_fmt/INFO
new file mode 100644
index 0000000..d7895f4
--- /dev/null
+++ b/patches/collateral-evolutions/nfc/02-pr_fmt/INFO
@@ -0,0 +1,6 @@
+
+Undef/define/include printk.h for fixing redefinition warnings
+during build.
+
+Patch adapted from compat-wireless tree.
+
diff --git a/patches/collateral-evolutions/nfc/02-pr_fmt/net_nfc.patch b/patches/collateral-evolutions/nfc/02-pr_fmt/net_nfc.patch
new file mode 100644
index 0000000..94544a3
--- /dev/null
+++ b/patches/collateral-evolutions/nfc/02-pr_fmt/net_nfc.patch
@@ -0,0 +1,181 @@
+--- a/net/nfc/core.c
++++ b/net/nfc/core.c
+@@ -21,8 +21,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/module.h>
+--- a/net/nfc/hci/command.c
++++ b/net/nfc/hci/command.c
+@@ -17,8 +17,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "hci: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/sched.h>
+--- a/net/nfc/hci/core.c
++++ b/net/nfc/hci/core.c
+@@ -17,8 +17,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "hci: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/module.h>
+--- a/net/nfc/hci/hcp.c
++++ b/net/nfc/hci/hcp.c
+@@ -17,8 +17,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "hci: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/module.h>
+--- a/net/nfc/hci/llc_shdlc.c
++++ b/net/nfc/hci/llc_shdlc.c
+@@ -18,8 +18,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "shdlc: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/types.h>
+ #include <linux/sched.h>
+ #include <linux/wait.h>
+--- a/net/nfc/llcp/commands.c
++++ b/net/nfc/llcp/commands.c
+@@ -17,8 +17,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "llcp: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/module.h>
+--- a/net/nfc/llcp/llcp.c
++++ b/net/nfc/llcp/llcp.c
+@@ -17,8 +17,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "llcp: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/list.h>
+--- a/net/nfc/llcp/sock.c
++++ b/net/nfc/llcp/sock.c
+@@ -17,8 +17,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "llcp: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/module.h>
+--- a/net/nfc/nci/core.c
++++ b/net/nfc/nci/core.c
+@@ -25,8 +25,10 @@
+  *
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/module.h>
+ #include <linux/types.h>
+ #include <linux/workqueue.h>
+--- a/net/nfc/nci/data.c
++++ b/net/nfc/nci/data.c
+@@ -21,8 +21,10 @@
+  *
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/types.h>
+ #include <linux/interrupt.h>
+ #include <linux/wait.h>
+--- a/net/nfc/nci/ntf.c
++++ b/net/nfc/nci/ntf.c
+@@ -25,8 +25,10 @@
+  *
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/types.h>
+ #include <linux/interrupt.h>
+ #include <linux/bitops.h>
+--- a/net/nfc/nci/rsp.c
++++ b/net/nfc/nci/rsp.c
+@@ -25,7 +25,9 @@
+  *
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
++#include <linux/printk.h>
+ 
+ #include <linux/types.h>
+ #include <linux/interrupt.h>
+--- a/net/nfc/netlink.c
++++ b/net/nfc/netlink.c
+@@ -21,8 +21,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <net/genetlink.h>
+ #include <linux/nfc.h>
+ #include <linux/slab.h>
+--- a/net/nfc/rawsock.c
++++ b/net/nfc/rawsock.c
+@@ -21,8 +21,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <net/tcp_states.h>
+ #include <linux/nfc.h>
+ #include <linux/export.h>
diff --git a/patches/collateral-evolutions/nfc/03-driver-core-constify-data/INFO b/patches/collateral-evolutions/nfc/03-driver-core-constify-data/INFO
new file mode 100644
index 0000000..7926612
--- /dev/null
+++ b/patches/collateral-evolutions/nfc/03-driver-core-constify-data/INFO
@@ -0,0 +1,7 @@
+This backports:
+
+commit 9f3b795a626ee79574595e06d1437fe0c7d51d29
+Author: Michał Mirosław <mirq-linux@rere.qmqm.pl>
+Date: Fri Feb 1 20:40:17 2013 +0100
+
+ driver-core: constify data for class_find_device()
diff --git a/patches/collateral-evolutions/nfc/03-driver-core-constify-data/net_nfc_core.patch b/patches/collateral-evolutions/nfc/03-driver-core-constify-data/net_nfc_core.patch
new file mode 100644
index 0000000..d09365f
--- /dev/null
+++ b/patches/collateral-evolutions/nfc/03-driver-core-constify-data/net_nfc_core.patch
@@ -0,0 +1,14 @@
+--- a/net/nfc/core.c
++++ b/net/nfc/core.c
+@@ -732,7 +732,11 @@ struct class nfc_class = {
+ };
+ EXPORT_SYMBOL(nfc_class);
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0))
+ static int match_idx(struct device *d, const void *data)
++#else
++static int match_idx(struct device *d, void *data)
++#endif
+ {
+ 	struct nfc_dev *dev = to_nfc_dev(d);
+ 	const unsigned int *idx = data;
-- 
1.7.10.4

